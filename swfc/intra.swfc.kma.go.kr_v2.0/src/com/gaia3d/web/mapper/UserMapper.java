package com.gaia3d.web.mapper;

import com.gaia3d.web.dto.UserDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface UserMapper extends BasicMapper<UserDTO> {
	
	UserDTO SelectById(Object parameter);

}
