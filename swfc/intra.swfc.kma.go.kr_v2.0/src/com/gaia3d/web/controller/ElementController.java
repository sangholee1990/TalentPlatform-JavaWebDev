package com.gaia3d.web.controller;

import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.coobird.thumbnailator.Thumbnails;

import org.apache.commons.codec.binary.Base64;
import org.joda.time.LocalDateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gaia3d.web.code.IMAGE_CODE;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.dto.SWFCImageMetaDTO;
import com.gaia3d.web.dto.SimpleStringValueChartData;
import com.gaia3d.web.exception.ArticleFileNotFoundException;
import com.gaia3d.web.mapper.ChartDataMapper;
import com.gaia3d.web.mapper.ForecastReportMapper;
import com.gaia3d.web.mapper.SWFCImageMetaMapper;
import com.gaia3d.web.service.SolarEventReportService;
import com.gaia3d.web.util.AnimatedGifEncoder;
import com.gaia3d.web.util.ImageLocationResource;
import com.gaia3d.web.util.SequenceEncoder;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;
/**
 * @author 태영
 * 
 */
@Controller
@RequestMapping("/element")
public class ElementController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ElementController.class);


	@Autowired(required = false)
	@Qualifier("imageLocationResource")
	private ImageLocationResource imageLocationResource;
	
	@Autowired(required = false)
	@Qualifier("TECLocationResource")
	private FileSystemResource TECLocationResource;
	
	@Autowired(required = false)
	@Qualifier("DefaultLocationResource")
	private FileSystemResource DefaultLocationResource;

	
	@RequestMapping("search.do")
	@ResponseBody
	public List<SWFCImageMetaDTO> search(@RequestParam(value="sd", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") LocalDateTime startDate,
			@RequestParam(value="ed", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") LocalDateTime endDate
			)
			throws Exception {
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		
		/*
		 * String startDate = (String)map.get("sd"); String startHour =
		 * (String)map.get("sh"); String startMinute = (String)map.get("sm");
		 * 
		 * String endDate = (String)map.get("ed"); String endHour =
		 * (String)map.get("eh"); String endMinute = (String)map.get("em");
		 */
		/*
		String filterDateString = (String) map.get("fd");

		if (codes == null || codes.size() == 0) {
			//codes = new ArrayList<String>(Arrays.asList(new String[] { "SDO__01001", "SDO__01002", "SDO__01003", "SDO__01004", "SDO__01005", "SDO__01006", "SOHO_01001", "SOHO_01002" }));
		}

		//params.put("codes", codes);
		//params.put("hour", hour);

		SimpleDateFormat filterDateFormat = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss");
		Calendar filterCalenar = Calendar.getInstance();
		filterCalenar.setTime(filterDateFormat.parse(filterDateString));
		Date startDate = filterCalenar.getTime();
		filterCalenar.add(Calendar.HOUR, 2);
		Date endDate = filterCalenar.getTime();
		*/
		MapperParam params = new MapperParam();
		params.put("startDate", startDate.toDate());
		params.put("endDate", endDate.plusHours(1).toDate());
		List<SWFCImageMetaDTO> data = mapper.SelectMany(params);
		return data;
/*
		ImmutableListMultimap<Integer, SWFCImageMetaDTO> groupByHour = Multimaps.index(data, new Function<SWFCImageMetaDTO, Integer>() {
			Calendar calenar = Calendar.getInstance();

			@Override
			public Integer apply(SWFCImageMetaDTO input) {
				calenar.setTime(input.getCreateDate());
				return (calenar.get(Calendar.MINUTE) / 6 + 1) * 6;
			}
		});

		Map<Integer, Map<String, Collection<SWFCImageMetaDTO>>> result = Maps.newHashMap();
		for (Integer key : groupByHour.keys()) {
			Map<String, Collection<SWFCImageMetaDTO>> groupByType = Multimaps.index(groupByHour.get(key), new Function<SWFCImageMetaDTO, String>() {
				@Override
				public String apply(SWFCImageMetaDTO input) {
					return input.getCode();
				}
			}).asMap();
			result.put(key, groupByType);
		}
		return result;
	*/
	}

	@RequestMapping("view_movie.do")
	public void view_movie(@RequestParam(value = "id", required = true) Integer id, 
			@RequestParam(value = "delay", required = false, defaultValue = "200") int delay,
			@RequestParam(value = "frames", required = true, defaultValue = "20") int frames, 
			@RequestParam(value = "size", required = true, defaultValue = "512") int size,
			HttpServletResponse response) throws IOException {
		
		
		response.setContentType("image/gif");
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam params = new MapperParam();
		params.put("id", id);
		params.put("cnt", frames);
		
		List<SWFCImageMetaDTO> list = null;
		BufferedOutputStream bos = null;
		AnimatedGifEncoder encoder = null;
		list = mapper.SelectManyMovie(params);
		if (list != null && list.size() > 0) {
			
			try{
				encoder =new AnimatedGifEncoder();
				
				encoder.setDelay(delay);
				encoder.setRepeat(0);
				encoder.setQuality(15);
				bos = new BufferedOutputStream(response.getOutputStream());
				encoder.start(bos);
				
				for (SWFCImageMetaDTO dao : list) {
					try {
						File file = imageLocationResource.getBrowseFile(dao);
						BufferedImage bi = Thumbnails.of(file).outputQuality(0.0f).size(size, size).asBufferedImage();
						encoder.addFrame(bi);
						bos.flush();
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}
				if(bos != null)bos.flush();
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				if(encoder != null) encoder.finish();
				if(bos != null) bos.close();
			}
		}
	}
	
	@RequestMapping("view_movie_mp4.do")
	public DownloadModelAndView view_movie_mp4(@RequestParam(value = "id", required = true) Integer id, 
			@RequestParam(value = "delay", required = false, defaultValue = "200") int delay,
			@RequestParam(value = "frames", required = true, defaultValue = "50") int frames, 
			@RequestParam(value = "size", required = true, defaultValue = "512") int size,
			HttpServletResponse response) throws IOException {
		String filename = String.format("swfc_sun_%d_%d_h264.mp4", size, frames);
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam params = new MapperParam();
		params.put("id", id);
		params.put("cnt", frames);
		List<SWFCImageMetaDTO> list = mapper.SelectManyMovie(params);
		if (list.size() > 0) {
			File tempFile = File.createTempFile("movie", ".mp4");
			SequenceEncoder encoder = new SequenceEncoder(tempFile); 
			for (SWFCImageMetaDTO dao : list) {
				try {
					File file = imageLocationResource.getBrowseFile(dao);
					BufferedImage bi = Thumbnails.of(file).size(size, size).asBufferedImage();
					encoder.encodeImage(bi);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			encoder.finish();
			DownloadModelAndView mv = new DownloadModelAndView(tempFile, filename);
			mv.setContentType("video/mp4");
			mv.setDeleteFile(true);
			return mv;
		}
		return null;
	}

	@RequestMapping("view_image.do")
	public DownloadModelAndView view_image(@RequestParam(value = "c", required = true) IMAGE_CODE code, @RequestParam(value = "ft", required = true, defaultValue = "0") int imageFileType,
			@RequestParam(value = "f", required = true) String filePathString) throws FileNotFoundException {
		String filePath = new String(org.springframework.security.crypto.codec.Base64.decode(filePathString.getBytes()));

		if (imageFileType == 0) // Browse Image
			return imageLocationResource.DownloadBrowse(code, filePath);
		else
			// Thumbnail Image
			return imageLocationResource.DownloadThumbnail(code, filePath);
	}

	@RequestMapping("view_browseimage.do")
	public DownloadModelAndView view_image(@RequestParam(value = "id", required = true) int id) throws FileNotFoundException {
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam param = new MapperParam();
		param.put("id", id);
		SWFCImageMetaDTO dao = mapper.SelectOne(param);

		String filePath = new String(org.springframework.security.crypto.codec.Base64.decode(dao.getFilePath().getBytes()));
		return imageLocationResource.DownloadBrowse(dao.getCode(), filePath);
	}

	@RequestMapping("view_popup.do")
	public void view_popup(ModelMap model, @RequestParam(value = "id", required = true) int id) {
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam param = new MapperParam();
		param.put("id", id);
		SWFCImageMetaDTO dao = mapper.SelectOne(param);
		model.addAttribute("dao", dao);
	}

	@RequestMapping("view_compare.do")
	public void view_compare(ModelMap model, @RequestParam(value = "id", required = true) int id, @RequestParam(value = "id2", required = true) int id2) {
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam param = new MapperParam();
		param.put("id", id);
		SWFCImageMetaDTO item1 = mapper.SelectOne(param);

		param.put("createDate", item1.getCreateDate());
		List<SWFCImageMetaDTO> item1List = mapper.SelectManyWithHour(param);

		param.clear();
		param.put("id", id2);
		SWFCImageMetaDTO item2 = mapper.SelectOne(param);

		param.put("createDate", item2.getCreateDate());
		List<SWFCImageMetaDTO> item2List = mapper.SelectManyWithHour(param);

		model.addAttribute("item1", item1);
		model.addAttribute("item2", item2);

		model.addAttribute("item1List", item1List);
		model.addAttribute("item2List", item2List);
	}

	@RequestMapping("search_in_time.do")
	@ResponseBody
	public Collection<SWFCImageMetaDTO> search_in_time(@RequestParam(value = "id", required = true) int id, @DateTimeFormat(pattern = "yyyyMMddHH") Date date) {
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam param = new MapperParam();
		param.put("id", id);
		param.put("createDate", date);
		return mapper.SelectManyWithHour(param);
	}
	
	@RequestMapping("sun_list.do")
	public void sun_list(ModelMap model) {

	}

	@RequestMapping("magnetosphere_list.do")
	public void magnetosphere(ModelMap model) {

	}

	@RequestMapping("ionsphere_list.do")
	public void ionsphere(ModelMap model) {

	}
	
	@RequestMapping("view_tec_image.do")
	public DownloadModelAndView view_tec_image(@RequestParam(value = "f", required = true) String filePathString) throws FileNotFoundException {
		String filePath = new String(org.springframework.security.crypto.codec.Base64.decode(filePathString.getBytes()));

		File tecImageFile = new File(TECLocationResource.getPath(), filePath);
		if(!tecImageFile.exists() || !tecImageFile.isFile()) {
			throw new FileNotFoundException();
		}
		
		return new DownloadModelAndView(tecImageFile);
	}
	
	@RequestMapping("tec_image_popup.do")
	public void tec_image_popup(ModelMap model, @RequestParam(value = "tm", required = true) String tm) throws FileNotFoundException {
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		
		MapperParam param = new MapperParam();
		param.put("tm", tm);
		SimpleStringValueChartData tec = mapper.SelectOneTEC(param);
		if(tec == null) {
			throw new ArticleFileNotFoundException();
		}
		
		model.put("item", tec);
	}
	

	@RequestMapping("interplanetary_list.do")
	public void interplanetary(ModelMap model, @RequestParam(value = "p", defaultValue = "1") int page, @RequestParam(value = "ps", defaultValue = "10") int pageSize) {
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);
		logger.info(Integer.toString(page));

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("page", page);
		params.put("pageSize", pageSize);

		model.addAttribute("list", mapper.SelectMany(params));
		model.addAttribute("page", page);
	}
	
	
	@Autowired
	private SolarEventReportService solarEventService;
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	/**
	 * 태양발현 리포트 페이지
	 * */
	@RequestMapping("solar_event_report.do")
	public void solarEventReport(Model model){
	}
	
	/**
	 * 태양발현 리포트 가져오기
	 * 
	 * */
	
	@RequestMapping("search_event_report.do")
	@ResponseBody
	public Map<String, Object> searchEventReport(ModelMap model, @RequestParam Map<String, Object> params ){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchList", solarEventService.selectLine(params));
		map.put("searchType", solarEventService.selectType(params));
		return map;
	}
	
	@RequestMapping("getPwvImageList.do")
	@ResponseBody
	public List<String> getPwvImageList(ModelMap model, @RequestParam Map<String, Object> params ){
		File dir = new File( DefaultLocationResource.getPath() + "/whyi/pwv/pwv_img/");
		String[] fileList = null;
		if(dir.exists() && dir.isDirectory()){
			fileList = dir.list(new FilenameFilter() {
				@Override
				public boolean accept(File dir, String name) {
					return (name.matches("^pwv_(\\d{10}).png"));
				}
			});
		}
		
		List<String> list = Arrays.asList(fileList);
		Collections.reverse(list);
		
		return list;
	}
	
	@RequestMapping("getPwvImageResource.do")
	public DownloadModelAndView getPwvImageResource(ModelMap model, @RequestParam(value="fileNm", required=true) String fileNm, HttpServletRequest request ){
		File file = new File( DefaultLocationResource.getPath() + "/whyi/pwv/pwv_img/", fileNm);
		
		
		String prefix = request.getSession().getServletContext().getRealPath("/");
		String noImage = "/images/report/noimg250.gif";


		if(file.exists() && file.isFile()){
			return new DownloadModelAndView(file);
		}else{
			file = new File(prefix + File.separator + noImage);
			if(file.exists() && file.isFile()){
				return new DownloadModelAndView(file);
			};
		}
		return null;
	}
	
	@RequestMapping("element_image_click.do")
	public String element_image_click(Model model, String imagesrc) throws IOException {
		int k = imagesrc.indexOf("/elementSWAA");
		imagesrc = imagesrc.substring(k);
		//int i = imagesrc.indexOf("/SWFCWeb");
		//int j = imagesrc.indexOf("/intra");
		//if(i != -1) {
		//	imagesrc = imagesrc.replaceAll("/SWFCWeb", "");
		//}
		//if(j != -1) {
		//	imagesrc = imagesrc.replaceAll("/intra", "");
		//}
		String imagesrc2 = imagesrc.replace('*', '&');
		model.addAttribute("imagesrc", imagesrc2);
		return "/elementSWAA/element_image_click";
	}
	
}//class end 
