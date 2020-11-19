package com.gaia3d.web.util;

import java.io.File;
import java.io.FileNotFoundException;

import org.springframework.core.io.FileSystemResource;

import com.gaia3d.web.code.IMAGE_CODE;
import com.gaia3d.web.dto.SWFCImageMetaDTO;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;



public class ImageLocationResource {
	FileSystemResource sdoBrowseLocation;
	FileSystemResource sdoThumbnailLocation;
	FileSystemResource sohoBrowseLocation;
	FileSystemResource sohoThumbnailLocation;
	FileSystemResource stereoBrowseLocation;
	FileSystemResource stereoThumbnailLocation;
	
	public FileSystemResource getSdoBrowseLocation() {
		return sdoBrowseLocation;
	}
	public void setSdoBrowseLocation(FileSystemResource sdoBrowseLocation) {
		this.sdoBrowseLocation = sdoBrowseLocation;
	}
	public FileSystemResource getSdoThumbnailLocation() {
		return sdoThumbnailLocation;
	}
	public void setSdoThumbnailLocation(FileSystemResource sdoThumbnailLocation) {
		this.sdoThumbnailLocation = sdoThumbnailLocation;
	}
	public FileSystemResource getSohoBrowseLocation() {
		return sohoBrowseLocation;
	}
	public void setSohoBrowseLocation(FileSystemResource sohoBrowseLocation) {
		this.sohoBrowseLocation = sohoBrowseLocation;
	}
	public FileSystemResource getSohoThumbnailLocation() {
		return sohoThumbnailLocation;
	}
	public void setSohoThumbnailLocation(FileSystemResource sohoThumbnailLocation) {
		this.sohoThumbnailLocation = sohoThumbnailLocation;
	}
	public FileSystemResource getStereoBrowseLocation() {
		return stereoBrowseLocation;
	}
	public void setStereoBrowseLocation(FileSystemResource stereoBrowseLocation) {
		this.stereoBrowseLocation = stereoBrowseLocation;
	}
	public FileSystemResource getStereoThumbnailLocation() {
		return stereoThumbnailLocation;
	}
	public void setStereoThumbnailLocation(FileSystemResource stereoThumbnailLocation) {
		this.stereoThumbnailLocation = stereoThumbnailLocation;
	}
	
	public File getBrowseFile(SWFCImageMetaDTO metaImage) {
		IMAGE_CODE imageCode = IMAGE_CODE.valueOf(metaImage.getCode());
		FileSystemResource location = getBrowseLocation(imageCode);
		String filePath = metaImage.getFilePath();
		if(filePath.startsWith("/swfc/")){
			return new File(filePath);
		}
		return new File(location.getPath(), filePath);
	}
	
	public File getThumbnailFile(SWFCImageMetaDTO metaImage) {
		IMAGE_CODE imageCode = IMAGE_CODE.valueOf(metaImage.getCode());
		FileSystemResource location = getThumbnailLocation(imageCode);
		return new File(location.getPath(), metaImage.getFilePath());
	}
	
	DownloadModelAndView DownloadImage(FileSystemResource location, String filepath) throws FileNotFoundException {
		File parentFile = new File(location.getPath());
		File fileFullPath = null;
		if(filepath.startsWith("/swfc/")){
			fileFullPath = new File(filepath);
			return new DownloadModelAndView(fileFullPath);
		}else{
			fileFullPath = new File(parentFile, filepath);
			
			if(Utils.isParent(parentFile, fileFullPath)) {
				return new DownloadModelAndView(fileFullPath);
			}
		}
		throw new FileNotFoundException();
	}
	
	public DownloadModelAndView DownloadBrowse(String imageCode, String filepath) throws FileNotFoundException {
		IMAGE_CODE code = IMAGE_CODE.valueOf(imageCode);
		return DownloadBrowse(code, filepath);
	}
	
	public DownloadModelAndView DownloadBrowse(IMAGE_CODE imageCode, String filepath) throws FileNotFoundException {
		FileSystemResource location = getBrowseLocation(imageCode);
		return DownloadImage(location, filepath);
	}
	
	public DownloadModelAndView DownloadThumbnail(String imageCode, String filepath) throws FileNotFoundException {
		IMAGE_CODE code = IMAGE_CODE.valueOf(imageCode);
		return DownloadThumbnail(code, filepath);
	}

	public DownloadModelAndView DownloadThumbnail(IMAGE_CODE imageCode, String filepath) throws FileNotFoundException {
		FileSystemResource location = getThumbnailLocation(imageCode);
		return DownloadImage(location, filepath);
	}
	
	FileSystemResource getBrowseLocation(IMAGE_CODE imageCode) {
		switch(imageCode) {
		case SOHO_01001:
		case SOHO_01002:
			return sohoBrowseLocation;
			
		case SDO__01001:
		case SDO__01002:
		case SDO__01003:
		case SDO__01004:
		case SDO__01005:
		case SDO__01006:
		case SDO__01007:
		case SDO__01008:
		case SDO__01009:
		case SDO__01010:
			return sdoBrowseLocation;
			
		case STA__01001:
		case STA__01002:
		case STB__01001:
		case STB__01002:
			return stereoBrowseLocation; 
		}
		return null;
	}
	
	FileSystemResource getThumbnailLocation(IMAGE_CODE imageCode) {
		switch(imageCode) {
		case SOHO_01001:
		case SOHO_01002:
			return sohoThumbnailLocation;
			
		case SDO__01001:
		case SDO__01002:
		case SDO__01003:
		case SDO__01004:
		case SDO__01005:
		case SDO__01006:
		case SDO__01007:
		case SDO__01008:
		case SDO__01009:
		case SDO__01010:
			return sdoThumbnailLocation;
			
		case STA__01001:
		case STA__01002:
		case STB__01001:
		case STB__01002:
			return stereoThumbnailLocation;	
		}
		return null;
	}

}
