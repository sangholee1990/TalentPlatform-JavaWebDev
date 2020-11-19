package egovframework.rte.utils;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.web.multipart.MultipartFile;

public abstract class Utils {
	public static boolean isParent( File parent, File file ) {

	    File f;
	    try {
	        parent = parent.getCanonicalFile();

	        f = file.getCanonicalFile();
	    } catch( IOException e ) {
	        return false;
	    }

	    while( f != null ) {
	        // equals() only works for paths that are normalized, hence the need for
	        // getCanonicalFile() above. "a" isn't equal to "./a", for example.
	        if( parent.equals( f ) ) {
	            return true;
	        }

	        f = f.getParentFile();
	    }

	    return false;
	}
	
	public static boolean deleteFile(FileSystemResource fileSytemResource, String filepath) {
		if(fileSytemResource != null && filepath != null) {
			File file = new File(fileSytemResource.getPath(), filepath);
			try {
				return file.delete();
			}finally {
				
			}
		}
		return false;
	}
	
	public static FileSaveInfo SaveTo(FileSystemResource fileSytemResource, MultipartFile file) throws Exception {
		return SaveTo(fileSytemResource.getPath(), file);
	}
	
	public static FileSaveInfo SaveTo(String parentPath, MultipartFile file) throws Exception {
		if(file != null && !file.isEmpty()) {
			SimpleDateFormat dtFormat = new SimpleDateFormat("/yyyy/MM/dd");
			String subPath = dtFormat.format(new Date());
			
			File savePath = new File(parentPath, subPath);
			if(!savePath.isDirectory()) {
				savePath.mkdirs();
			}
			
			String saveFilename = UUID.randomUUID().toString();
			File fullPath = new File(savePath, saveFilename);
			file.transferTo(fullPath);
			
			FileSaveInfo info = new FileSaveInfo();
			info.setOriginalFilename(file.getOriginalFilename());
			info.setSaveFilepath(new File(subPath, saveFilename).getPath());
			
			return info;
		}
		return null;
	}
}
