package com.gaia3d.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.dto.BoardsDTO;
import com.gaia3d.web.dto.BoardsFileDTO;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.exception.ArticleFileNotFoundException;
import com.gaia3d.web.exception.ArticleNotFoundException;
import com.gaia3d.web.mapper.BoardFileMapper;
import com.gaia3d.web.mapper.BoardMapper;
import com.gaia3d.web.service.CodeService;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;

@Controller
@RequestMapping("/board")
public class BoardController extends BaseController {
	
	private static final String SITE_CODE_CD = "SITE_CODE_CD";
	private static final String ARCHIVES_BOARD_CODE_CD = "ARCHIVES_CODE_CD";
	private static final String BOARD_ARCHIVES_CODE = "2";
	private static final String BOARD_NOTICE_CODE = "3";
	private static final String BOARD_FAQ_CODE = "1";
	private static final String INTRANET_SITE_CODE_CD = "3";
	
	@Autowired
	private CodeService codeService;
	
	@Autowired(required=false)
	@Qualifier("PDSLocationResource")
	private FileSystemResource pdsLocation;

	
	private List<CodeDTO> listCode(String code){
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("site_cd", "intranet");
		return mapper.selectBoardSectionCode(params);
	}
	
	@RequestMapping("archives_list.do")
	public void archives_list(ModelMap model, 
			@RequestParam Map<String, String> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize) {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		model.addAttribute("boardSubCodeList", listCode(ARCHIVES_BOARD_CODE_CD));
		requestParams.put("board_code_cd", BOARD_ARCHIVES_CODE);
		requestParams.put("use_yn", "Y");
		requestParams.put("site_code_cd", INTRANET_SITE_CODE_CD);
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());

		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}

	@RequestMapping("archives_view.do")
	public void archives_view(ModelMap model, 
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		BoardsDTO dto = mapper.SelectOne(params);
		List<BoardsFileDTO> filedto = filemapper.SelectMany(params);

		if (dto == null)
			throw new ArticleNotFoundException();

		mapper.IncreaseHit(params);

		model.addAttribute("archives", dto);
		model.addAttribute("archivesFileList", filedto);
	}
	
	@RequestMapping("notice_list.do")
	public void notice_list(ModelMap model, 
			@RequestParam Map<String, String> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize) {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		requestParams.put("site_code_cd", INTRANET_SITE_CODE_CD);
		requestParams.put("board_code_cd", BOARD_NOTICE_CODE);
		requestParams.put("use_yn", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());

		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}

	@RequestMapping("notice_view.do")
	public void notice_view(ModelMap model, 
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		BoardsDTO dto = mapper.SelectOne(params);
		List<BoardsFileDTO> filedto = filemapper.SelectMany(params);

		if (dto == null)
			throw new ArticleNotFoundException();

		mapper.IncreaseHit(params);

		model.addAttribute("board", dto);
		model.addAttribute("fileList", filedto);
	}
	
	@RequestMapping("notice_view_popup.do")
	public void notice_popup(ModelMap model,
			@RequestParam Map<String, Object> requestParams,
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		MapperParam param = new MapperParam();
		param.put("board_seq", board_seq);
		param.put("site_code_cd", INTRANET_SITE_CODE_CD);
		param.put("board_code_cd", BOARD_NOTICE_CODE);
		param.put("use_yn", "Y");
		param.put("popup_yn", "Y");
		BoardsDTO dto = mapper.SelectOne(param);
		
		if(dto == null) {
			throw new ArticleNotFoundException();
		}
		
		//mapper.IncreaseHit(param);
		
		model.addAttribute("notice", dto);
	}
	
	
	@RequestMapping("faq_list.do")
	public void faq_list(ModelMap model, 
			@RequestParam Map<String, String> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize) {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		requestParams.put("site_code_cd", INTRANET_SITE_CODE_CD);
		requestParams.put("board_code_cd", BOARD_FAQ_CODE);
		requestParams.put("use_yn", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());

		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}

	@RequestMapping("faq_view.do")
	public void faq_view(ModelMap model, 
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		BoardsDTO dto = mapper.SelectOne(params);
		List<BoardsFileDTO> filedto = filemapper.SelectMany(params);

		if (dto == null)
			throw new ArticleNotFoundException();

		mapper.IncreaseHit(params);

		model.addAttribute("board", dto);
		model.addAttribute("fileList", filedto);
	}
	
	
	@RequestMapping("download.do")
	public DownloadModelAndView archives_download(
			@RequestParam(value="board_file_seq", required=true) Integer board_file_seq
			) throws Exception {
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);

		MapperParam params = new MapperParam();
		params.put("board_file_seq", board_file_seq);

		BoardsFileDTO fileDto = filemapper.SelectOne(params);
		File file = new File(pdsLocation.getPath(), fileDto.getFilepath());
		if (!file.exists() || !file.isFile())
			throw new ArticleFileNotFoundException();

		return new DownloadModelAndView(file, fileDto.getFilename());
	}
}
