package egovframework.rte.swfc.util;

import java.io.File;
import java.io.FileNotFoundException;

import org.springframework.core.io.FileSystemResource;

import egovframework.rte.swfc.common.Code;
import egovframework.rte.swfc.dto.SWFCImageMetaDTO;
import egovframework.rte.swfc.view.DefaultDownloadView.DownloadModelAndView;
import egovframework.rte.utils.Utils;



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
		Code.IMAGE_CODE imageCode = Code.IMAGE_CODE.valueOf(metaImage.getCode());
		FileSystemResource location = getBrowseLocation(imageCode);
		return new File(location.getPath(), metaImage.getFilePath());
	}
	
	public File getThumbnailFile(SWFCImageMetaDTO metaImage) {
		Code.IMAGE_CODE imageCode = Code.IMAGE_CODE.valueOf(metaImage.getCode());
		FileSystemResource location = getThumbnailLocation(imageCode);
		return new File(location.getPath(), metaImage.getFilePath());
	}
	
	DownloadModelAndView DownloadImage(FileSystemResource location, String filepath) throws FileNotFoundException {
		File parentFile = new File(location.getPath());
		File fileFullPath = new File(parentFile, filepath);
		if(Utils.isParent(parentFile, fileFullPath)) {
			return new DownloadModelAndView(fileFullPath);
		}
		throw new FileNotFoundException();
	}
	
	public DownloadModelAndView DownloadBrowse(String imageCode, String filepath) throws FileNotFoundException {
		Code.IMAGE_CODE code = Code.IMAGE_CODE.valueOf(imageCode);
		return DownloadBrowse(code, filepath);
	}
	
	public DownloadModelAndView DownloadBrowse(Code.IMAGE_CODE imageCode, String filepath) throws FileNotFoundException {
		FileSystemResource location = getBrowseLocation(imageCode);
		return DownloadImage(location, filepath);
	}
	
	public DownloadModelAndView DownloadThumbnail(String imageCode, String filepath) throws FileNotFoundException {
		Code.IMAGE_CODE code = Code.IMAGE_CODE.valueOf(imageCode);
		return DownloadThumbnail(code, filepath);
	}

	public DownloadModelAndView DownloadThumbnail(Code.IMAGE_CODE imageCode, String filepath) throws FileNotFoundException {
		FileSystemResource location = getThumbnailLocation(imageCode);
		return DownloadImage(location, filepath);
	}
	
	FileSystemResource getBrowseLocation(Code.IMAGE_CODE imageCode) {
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
	
	FileSystemResource getThumbnailLocation(Code.IMAGE_CODE imageCode) {
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
