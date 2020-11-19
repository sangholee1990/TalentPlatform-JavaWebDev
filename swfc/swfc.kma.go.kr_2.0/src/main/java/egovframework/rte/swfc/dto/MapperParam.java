package egovframework.rte.swfc.dto;

import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.swfc.BaseModel;

public class MapperParam extends BaseModel{

	private static final long serialVersionUID = 1L;
	
	/**
     * 파라메터를 추가한다.
     * 
     * @param key 키
     * @param value 값
     * @return 기존 값
     */
    public Object add(String key, Object value) {
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;
            
            if (values.length == 1) {
                return put(key, values[0]);
            }
        }
        
        return put(key, value);
    }
    
    /**
     * 파일을 반환한다.
     * 
     * @param key 키
     * @return 파일
     */
    public MultipartFile getFile(String key) {
        return (MultipartFile) get(key);
    }
    
    /**
     * 파일 배열을 반환한다.
     * 
     * @param key 키
     * @return 파일 배열
     */
    public MultipartFile[] getFileArray(String key) {
        Object value = get(key);
        
        if (value instanceof MultipartFile[]) {
            return (MultipartFile[]) value;
        }
        
        if (value instanceof MultipartFile) {
            return new MultipartFile[] { (MultipartFile) value };
        }
        
        return new MultipartFile[0];
    }

}
