package com.gaia3d.web.mapper;

import java.util.HashMap;

import com.gaia3d.web.dto.DataKindDTO;
import com.gaia3d.web.dto.DataMasterDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface DataMasterMapper  extends BasicMapper<DataMasterDTO>{

	HashMap SelectOneAll(Object obj);

}
