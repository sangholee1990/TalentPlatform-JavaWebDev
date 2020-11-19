package com.gaia3d.swfc.batch.util;

import java.io.File;
import java.io.FileNotFoundException;

import org.apache.commons.configuration.AbstractConfiguration;
import org.apache.commons.lang.StringUtils;

public class DestinationInfo {
	final File baseBrowsePath;
	final File baseThumbnailPath;
	
	File browsePath;
	File thumbnailPath;
	
	int thumbnailWidth;
	int thumbnailHeight;

	public DestinationInfo(AbstractConfiguration config) throws FileNotFoundException {
		if(config == null)
			throw new IllegalArgumentException("invalid destination config!");
		
		String originalPath = config.getString("browse");
		if(StringUtils.isBlank(originalPath))
			throw new IllegalArgumentException("destination.browse must be not empty!");
		
		String thumbnailPath = config.getString("thumbnail");
		if(StringUtils.isBlank(thumbnailPath))
			throw new IllegalArgumentException("destination.thumbnail must be not empty!");
		
		baseBrowsePath = new File(originalPath);
		baseThumbnailPath = new File(thumbnailPath);
		
		if (!baseBrowsePath.isDirectory())
			throw new FileNotFoundException("destination.browse [" + baseBrowsePath.getPath() + "]");

		if (!baseThumbnailPath.isDirectory())
			throw new FileNotFoundException("destination.thumbnail [" + baseThumbnailPath.getPath() + "]");
		
		thumbnailWidth = config.getInt("thumbnail[@width]");
		thumbnailHeight = config.getInt("thumbnail[@height]");
	}
	
	public File getBaseBrowsePath() {
		return baseBrowsePath;
	}
	
	public File getBaseThumbnailPath() {
		return baseThumbnailPath;
	}
	
	public int getThumbnailWidth() {
		return thumbnailWidth;
	}
	
	public int getThumbnailHeight() {
		return thumbnailHeight;
	}
	
	public void setSubPath(String subPath) {
		browsePath = new File(this.getBaseBrowsePath(), subPath);
		if (!browsePath.exists())
			browsePath.mkdirs();
		
		thumbnailPath = new File(this.getBaseThumbnailPath(), subPath);
		if (!thumbnailPath.exists())
			thumbnailPath.mkdirs();
	}
	
	public File getBrowsePath() {
		return browsePath;
	}
	
	public File getThumbnailPath() {
		return thumbnailPath;
	}	
}
