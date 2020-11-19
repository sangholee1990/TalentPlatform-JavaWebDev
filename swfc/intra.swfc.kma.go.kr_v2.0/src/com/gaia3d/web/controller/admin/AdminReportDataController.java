package com.gaia3d.web.controller.admin;

import java.io.File;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.dto.ProgramDTO;
import com.gaia3d.web.exception.ArticleFileNotFoundException;
import com.gaia3d.web.exception.ArticleNotFoundException;
import com.gaia3d.web.mapper.ProgramMapper;
import com.gaia3d.web.util.FileSaveInfo;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.Utils;
import com.gaia3d.web.util.WebUtil;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;

@Controller
@RequestMapping("/admin/reportdata")
public class AdminReportDataController extends BaseController{
	
	
	@Autowired(required=false)
	@Qualifier(value="programLocationResource")
	private FileSystemResource programLocationResource;
	
	@RequestMapping("program_list.do")
	public void program_list(ModelMap model,
		@RequestParam(value="p", defaultValue="1") int page,
		@RequestParam(value="ps", defaultValue="10") int pageSize) {
		
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
	
		MapperParam params = new MapperParam();
		int count = mapper.Count(params);
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("startRow", navigation.getStartRow());
		params.put("endRow", navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(params));
		model.addAttribute("pageNavigation", navigation);
	}
	
	@RequestMapping("program_form.do")
	public void program_form(ModelMap model, @RequestParam(value="id", required=false) Integer id) throws Exception {
		ProgramDTO dto = null;
		if(id == null) {
			dto = new ProgramDTO();
		} else {
			ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
			MapperParam params = new MapperParam();
			params.put("id", id);
			dto = mapper.SelectOne(params);
		}
		
		if(dto == null) 
			throw new ArticleNotFoundException();
		
		model.addAttribute("program", dto);
	}
	
	@RequestMapping(value="program_submit.do", method=RequestMethod.POST)
	public String program_submit(@ModelAttribute("program") @Valid ProgramDTO program, 
			BindingResult bindingResult, 
			@RequestParam("file1Data") MultipartFile file1Data) throws Exception {
		if(bindingResult.hasErrors())
			return "program_form";
		
		
		FileSaveInfo saveInfo = Utils.SaveTo(programLocationResource, file1Data);
		if(saveInfo != null) {
			program.setFilename(saveInfo.getOriginalFilename());
			program.setFilepath(saveInfo.getSaveFilepath());
		}
		
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		if(program.getId() == null) {
			mapper.Insert(program);
		}
		else {
			mapper.Update(program);
		}
		
		return "redirect:program_list.do";
	}
	
	@RequestMapping("program_del.do")
	public String program_del(@RequestParam Map<String,String> requestParams, @RequestParam(value="id", required=true) Integer id) throws Exception {
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		MapperParam params = new MapperParam();
		params.put("id", id);
		
		ProgramDTO dto = mapper.SelectOne(params);
		if(dto == null) 
			throw new ArticleNotFoundException();
		
		mapper.Delete(params);
		requestParams.remove("id");
		
		Utils.deleteFile(programLocationResource, dto.getFilepath());
		
		return "redirect:program_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}	
	
	@RequestMapping("program_download.do")
	public DownloadModelAndView download(@RequestParam("id") int id) throws Exception{
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		MapperParam params = new MapperParam();
		params.put("id", id);
		ProgramDTO dto = mapper.SelectOne(params);
		if(dto == null) 
			throw new ArticleNotFoundException();
		
		String filepath = dto.getFilepath();
		if(filepath == null)
			throw new ArticleFileNotFoundException();
		
		File file = new File(programLocationResource.getFile(), filepath);
		if(!file.exists() || !file.isFile())
			throw new ArticleFileNotFoundException();
		
	    return new DownloadModelAndView(file, dto.getFilename());
	}
}
