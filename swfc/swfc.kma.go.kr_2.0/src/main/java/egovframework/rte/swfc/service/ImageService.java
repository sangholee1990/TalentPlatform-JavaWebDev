package egovframework.rte.swfc.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.swfc.common.Code.IMAGE_CODE;
import egovframework.rte.swfc.dto.SWFCImageMetaDTO;
import egovframework.rte.swfc.mapper.SWFCImageMetaMapper;

@Service
public class ImageService extends BaseService {
	
	@Autowired(required=true)
	private SqlSession sessionTemplate;
	
	public Map<String, Map<String, String>> selectRecentOneForEach(){
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		Map<String, Map<String, String>> imageUrlSet = new HashMap<String, Map<String, String>>();
		for(SWFCImageMetaDTO meta : mapper.SelectRecentOneForEach()) {
			IMAGE_CODE code = IMAGE_CODE.valueOf(meta.getCode());
			String url = String.format("/current/image/%s/%s", meta.getCode(), meta.getFilePath());
			Map<String, String> data = new HashMap<String, String>();
			data.put("codeText", code.getText());
			data.put("imageUrl", url);
			imageUrlSet.put(code.toString(), data);
		}
		return imageUrlSet;
	}

}
