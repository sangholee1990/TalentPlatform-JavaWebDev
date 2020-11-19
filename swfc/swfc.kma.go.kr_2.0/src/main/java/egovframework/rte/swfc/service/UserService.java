/**
 * 
 */
package egovframework.rte.swfc.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.swfc.dto.MapperParam;
import egovframework.rte.swfc.dto.UserDTO;
import egovframework.rte.swfc.mapper.UserMapper;

/**
 * 사용자의 서비스 로직음 담당하는 클래스
 * @author Administrator
 *
 */
@Service
public class UserService extends BaseService {
	
	
	@Autowired(required=true)
	private SqlSession sessionTemplate;
	
	/**
	 * 사용자 정보를 가져온다.
	 * @param param 요청값을  가지고 있는 파라메터 객체
	 * @return 결과값
	 */
	public UserDTO selectUser(MapperParam param){
		UserMapper mapper = sessionTemplate.getMapper(UserMapper.class);
		return mapper.selectById(param);
	}
	
}
