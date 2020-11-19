/**
 * 
 */
package egovframework.rte.swfc.mapper;

import egovframework.rte.swfc.dto.MapperParam;
import egovframework.rte.swfc.dto.UserDTO;

/**
 * 사용자 정보의 database를 핸들링하는 mapper
 * @author Administrator
 *
 */
public interface UserMapper {
	
	public UserDTO selectById(MapperParam param);

}
