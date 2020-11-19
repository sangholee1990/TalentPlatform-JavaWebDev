package com.gaia3d.web.filter;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.jsoup.Jsoup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;

import com.gaia3d.web.util.SpringApplicationContext;
import com.gaia3d.web.util.StringServletResponseWrapper;
import com.itextpdf.text.Document;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.Pipeline;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

/**
 * Servlet Filter implementation class PDFCreateFilter
 */
public class ReportPDFFilter implements Filter {
	private static final Logger logger = LoggerFactory.getLogger(ReportPDFFilter.class);

	/**
	 * Default constructor.
	 */
	public ReportPDFFilter() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}
	
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		// pass the request along the filter chain
		ServletResponse newResponse = response;
		if (request instanceof HttpServletRequest) {
			newResponse = new StringServletResponseWrapper(
					(HttpServletResponse) response);
		}

		chain.doFilter(request, newResponse);
		
		if (newResponse instanceof StringServletResponseWrapper) {
			String text = newResponse.toString();
			
			org.jsoup.nodes.Document jsoupDoc = Jsoup.parse(text);
			org.jsoup.nodes.Element meta = jsoupDoc.head().select("meta[name=Filename]").first();
			String filename = "Report.pdf";
			if(meta != null) {
				filename = meta.attr("content");
			}
			
			if(logger.isDebugEnabled())
				logger.debug(text);

			if (text != null) {
				Document document = new Document();
				try {
					HttpServletResponse res = (HttpServletResponse)response;
					
					res.setContentType("application/pdf");
					res.setHeader("Content-Transfer-Encoding", "binary");
					res.setHeader("Content-Disposition", String.format("inline;filename=\"%s\";", filename));
					
					final FileSystemResource fs = (FileSystemResource)SpringApplicationContext.getBean("ForecastReportLocationResource");

					BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

					FontFactory.registerDirectories();
					PdfWriter writer = PdfWriter.getInstance(document, bos);
					document.open();
					
					HtmlPipelineContext htmlContext = new HtmlPipelineContext(null);
					
					htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
					
					htmlContext.setImageProvider(new AbstractImageProvider() {
					    public String getImageRootPath() {
					        return fs.getPath();
					    }
					});
					/*
					htmlContext.setLinkProvider(new LinkProvider() {
					
					    public String getLinkRoot() {
					
					        return "http://tutorial.itextpdf.com/src/main/resources/html/";
					    }
					
					});
					*/
					CSSResolver cssResolver = XMLWorkerHelper.getInstance().getDefaultCssResolver(true);
					Pipeline<?> pipeline =
					    new CssResolverPipeline(cssResolver,
					            new HtmlPipeline(htmlContext,
					                new PdfWriterPipeline(document, writer)));
					
					XMLWorker worker = new XMLWorker(pipeline, true);
					
					XMLParser p = new XMLParser(worker);
					
					InputStream is = IOUtils.toInputStream(text);
					p.parse(is);
					p.flush();
					
					writer.flush();
					writer.close();
					
					bos.flush();
					bos.close();
				} catch (Exception ex) {
					logger.error("ReportPDF", ex);
				} finally {
					if(document.isOpen())
						document.close();
				}
			}
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
