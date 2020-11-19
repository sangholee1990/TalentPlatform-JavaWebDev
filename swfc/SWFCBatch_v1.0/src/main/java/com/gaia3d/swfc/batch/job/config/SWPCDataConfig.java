package com.gaia3d.swfc.batch.job.config;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.configuration.HierarchicalConfiguration;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.gaia3d.swfc.batch.job.swpc.SWPCDataType;
import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

public class SWPCDataConfig {
	static final Logger logger = LogManager.getLogger(SWPCDataType.class.getName());

	Multimap<SWPCDataType, URL> data = ArrayListMultimap.create();

	public Multimap<SWPCDataType, URL> getData() {
		return data;
	}

	public void putData(SWPCDataType dataType, String url) {
		try {
			data.put(dataType, new URL(url));
		} catch (MalformedURLException e) {
			logger.warn("Invalid SWPC url [" + url + "]");
		}
	}

	public void loadFromHttp(String[] urls) throws IOException {
		for (String url : urls) {
			try {
				Document document = Jsoup.connect(url).timeout(60000).maxBodySize(0).get();
				Elements links = document.select("a[href]");
				for (Element link : links) {
					String httpUrl = link.absUrl("href");
					String filename = FilenameUtils.getName(httpUrl).toLowerCase();

					SWPCDataType dataType = null;
					if (filename.contains("ace_epam"))
						dataType = SWPCDataType.ACE_EPAM;
					else if (filename.contains("ace_mag"))
						dataType = SWPCDataType.ACE_MAG;
					else if (filename.contains("ace_sis"))
						dataType = SWPCDataType.ACE_SIS;
					else if (filename.contains("ace_swepam"))
						dataType = SWPCDataType.ACE_SWEPAM;
					
					else if (filename.contains("gp_mag_1m.txt"))
						dataType = SWPCDataType.GOES_MAG_P;
					else if (filename.contains("gs_mag_1m.txt"))
						dataType = SWPCDataType.GOES_MAG_S;

					else if (filename.contains("gp_part"))
						dataType = SWPCDataType.GOES_PARTICLE_P;
					else if (filename.contains("gs_part"))
						dataType = SWPCDataType.GOES_PARTICLE_S;

					else if (filename.contains("gp_xr_1m"))
						dataType = SWPCDataType.GOES_XRAY_1M;
					else if (filename.contains("gp_xr_5m"))
						dataType = SWPCDataType.GOES_XRAY_5M;

					else if (filename.contains("sta_het"))
						dataType = SWPCDataType.STA_HET;
					else if (filename.contains("sta_impact"))
						dataType = SWPCDataType.STA_IMPACT;
					else if (filename.contains("sta_plastic"))
						dataType = SWPCDataType.STA_PLASTIC;
					else if (filename.contains("sta_mag"))
						dataType = SWPCDataType.STA_MAG;
					else if (filename.contains("stb_het"))
						dataType = SWPCDataType.STB_HET;
					else if (filename.contains("stb_impact"))
						dataType = SWPCDataType.STB_IMPACT;
					else if (filename.contains("stb_plastic"))
						dataType = SWPCDataType.STB_PLASTIC;
					else if (filename.contains("stb_mag"))
						dataType = SWPCDataType.STB_MAG;
					else if (filename.contains("ak.txt"))
						dataType = SWPCDataType.KP_INDEX;
					else
						logger.warn("Can't parse SWPC Type from " + httpUrl);

					if (dataType != null)
						data.put(dataType, new URL(httpUrl));
				}
			} catch (Exception ex) {
				logger.error(ex);
			}
		}
	}

	public void loadConfig(HierarchicalConfiguration config) {
		for (HierarchicalConfiguration dataConfigNode : config.configurationsAt("swpc")) {
			try {
				SWPCDataType dataType = SWPCDataType.valueOf(dataConfigNode.getString("[@type]"));
				for (HierarchicalConfiguration fileNode : dataConfigNode.configurationsAt("file")) {
					putData(dataType, fileNode.getString("[@url]"));
				}

			} catch (Exception ex) {
				logger.error("Invalid SWPC type", ex);
				continue;
			}
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("================================================ TextDataConfig ================================================\n");
		for (SWPCDataType key : data.keySet()) {
			builder.append(key + ":" + data.get(key));
			builder.append(System.getProperty("line.separator"));
		}
		builder.append("================================================================================================================");
		return builder.toString();
	}
}
