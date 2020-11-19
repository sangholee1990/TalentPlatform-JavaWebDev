/**
 * 
 */
package egovframework.rte.swfc.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.swfc.dto.BoardsDTO;
import egovframework.rte.swfc.dto.BoardsFileDTO;
import egovframework.rte.swfc.dto.CodeDTO;
import egovframework.rte.swfc.dto.MapperParam;
import egovframework.rte.swfc.service.BoardService;
import egovframework.rte.swfc.service.CodeService;
import egovframework.rte.swfc.view.DefaultDownloadView.DownloadModelAndView;
import egovframework.rte.utils.PageNavigation;

/**
 * @author Administrator
 *
 */
@Controller
public class BoardController extends BaseController {
	
	private static final String SITE_CODE_CD = "SITE_CODE_CD";
	private static final String ARCHIVES_BOARD_CODE_CD = "ARCHIVES_CODE_CD";
	private static final String BOARD_FAQ_CODE = "1";
	private static final String BOARD_ARCHIVES_CODE = "2";
	private static final String BOARD_NOTICE_CODE = "3";
	private static final String KOR_SITE_CODE_CD = "1";
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CodeService codeService;
	
	
	@Autowired(required=false)
	@Qualifier("PDSLocationResource")
	private FileSystemResource pdsLocation;
	
	
	private List<CodeDTO> listCode(String code){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("site_cd", "homepage");
		return boardService.selectBoardSectionCode(params);
	}
	
	/**
	 * 자료실 목록
	 * @param lang
	 * @param model
	 * @param requestParams
	 * @param page
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/{lang}/board/archives_list.do")
	public String archives_list(@PathVariable("lang") String lang,
			ModelMap model,
			@RequestParam Map<String, Object> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue="10") int pageSize) {
		
		//model.addAttribute("subList", listCode(SITE_CODE_CD));
		model.addAttribute("boardSubCodeList", listCode(ARCHIVES_BOARD_CODE_CD));
		
		requestParams.put("board_code_cd", BOARD_ARCHIVES_CODE);
		requestParams.put("use_yn", "Y");
		requestParams.put("site_code_cd", "1");
		int count = boardService.selectCountBoard(requestParams);
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", boardService.listBoard(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
		return getViewName(lang, "board/archives_list");
	}
	
	/**
	 * 상세보기 
	 * @param lang
	 * @param model
	 * @param board_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{lang}/board/archives_view.do")
	public String archives_view(@PathVariable("lang") String lang,
			ModelMap model,
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		BoardsDTO dto = boardService.viewBoard(params);
		List<BoardsFileDTO> filedto = boardService.listBoardFile(params);
		
		if(dto == null)
			throw new Exception();
		
		model.addAttribute("archives", dto);
		model.addAttribute("archivesFileList", filedto);
		
		return getViewName(lang, "board/archives_view");
	}
    
	/**
	 * 공지사항 목록
	 * @param lang
	 * @param model
	 * @param requestParams
	 * @param page
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/{lang}/board/notice_list.do")
	public String notice_list(@PathVariable("lang") String lang,
			ModelMap model,
			@RequestParam Map<String, Object> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue="10") int pageSize) {
		
		//model.addAttribute("subList", listCode(SITE_CODE_CD));
		
		requestParams.put("board_code_cd", BOARD_NOTICE_CODE);
		requestParams.put("use_yn", "Y");
		requestParams.put("site_code_cd", "1");
		int count = boardService.selectCountBoard(requestParams);
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", boardService.listBoard(requestParams));
		model.addAttribute("pageNavigation", navigation);
		return getViewName(lang, "board/notice_list");
	}
	
	@RequestMapping(value = "/{lang}/board/notice_view.do")
	public String notice_view(@PathVariable("lang") String lang,
			ModelMap model,
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		BoardsDTO dto = boardService.viewBoard(params);
		List<BoardsFileDTO> filedto = boardService.listBoardFile(params);
		
		if(dto == null) throw new Exception();
		
		model.addAttribute("notice", dto);
		model.addAttribute("noticeFileList", filedto);
		
		return getViewName(lang, "board/notice_view");
	}
	
	@RequestMapping(value = "/{lang}/board/notice_view_popup.do")
	public String notice_popup(@PathVariable("lang") String lang,
			ModelMap model,
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		params.put("site_code_cd", KOR_SITE_CODE_CD);
		params.put("board_code_cd", BOARD_NOTICE_CODE);
		params.put("use_yn", "Y");
		params.put("popup_yn", "Y");
		
		BoardsDTO dto = boardService.viewBoard(params);
		
		if(dto == null) throw new Exception();
		
		model.addAttribute("notice", dto);
		
		return getViewName(lang, "board/notice_view_popup");
	}
	
	/**
	 * 파일 다운로드를 처리한다.
	 * @param board_file_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{lang}/board/download.do")
	public DownloadModelAndView notice_download(
			@RequestParam(value="board_file_seq", required=true) Integer board_file_seq) throws Exception {
		
		MapperParam params = new MapperParam();
		params.put("board_file_seq", board_file_seq);
		
		BoardsFileDTO fileDto = boardService.viewBoardFile(params);
		File file = new File(pdsLocation.getPath(), fileDto.getFilepath());
		if(!file.exists() || !file.isFile())
			throw new Exception();
		
		return new DownloadModelAndView(file, fileDto.getFilename());
	}
	
	/**
	 * FAQ 목록
	 * @param lang
	 * @param model
	 * @param requestParams
	 * @param page
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/{lang}/board/faq_list.do")
	public String faq_list(@PathVariable("lang") String lang,
			ModelMap model,
			@RequestParam Map<String, Object> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue="10") int pageSize) {
		
		//model.addAttribute("subList", listCode(SITE_CODE_CD));
		
		requestParams.put("board_code_cd", BOARD_FAQ_CODE);
		requestParams.put("use_yn", "Y");
		requestParams.put("site_code_cd", "1");
		int count = boardService.selectCountBoard(requestParams);
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", boardService.listBoard(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
		return getViewName(lang, "board/faq_list");
	}
	
	@RequestMapping(value = "/{lang}/board/faq_view.do")
	public String faq_view(@PathVariable("lang") String lang,
			ModelMap model,
			@RequestParam(value="view_board_seq", required=false) Integer board_seq) throws Exception {
		
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		BoardsDTO dto = boardService.viewBoard(params);
		List<BoardsFileDTO> filedto = boardService.listBoardFile(params);
		
		if(dto == null) throw new Exception();
		
		model.addAttribute("faq", dto);
		model.addAttribute("fileList", filedto);
		
		return getViewName(lang, "board/faq_view");
	}
}
