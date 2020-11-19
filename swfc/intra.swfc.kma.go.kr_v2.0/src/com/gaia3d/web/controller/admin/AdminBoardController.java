package com.gaia3d.web.controller.admin;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.access.hierarchicalroles.UserDetailsWrapper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.BoardsDTO;
import com.gaia3d.web.dto.BoardsFileDTO;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.exception.ArticleFileNotFoundException;
import com.gaia3d.web.exception.ArticleNotFoundException;
import com.gaia3d.web.mapper.BoardFileMapper;
import com.gaia3d.web.mapper.BoardMapper;
import com.gaia3d.web.service.CodeService;
import com.gaia3d.web.user.WebUser;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.FileSaveInfo;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.Utils;
import com.gaia3d.web.util.WebUtil;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;

@Controller
@RequestMapping("/admin/board/")
public class AdminBoardController extends BaseController {

	private static final String SITE_CODE_CD = "SITE_CODE_CD";
	private static final String ARCHIVES_BOARD_CODE_CD = "ARCHIVES_CODE_CD";
	private static final String BOARD_FAQ_CODE = "1";
	private static final String BOARD_ARCHIVES_CODE = "2";
	private static final String BOARD_NOTICE_CODE = "3";

	@Autowired
	private CodeService codeService;

	@Autowired(required=false)
	@Qualifier("PDSLocationResource")
	private FileSystemResource pdsLocation;

	/**
	 * 게시판 종류 정보를 가져온다.
	 * @param code
	 * @return
	 */
	private List<CodeDTO> listCode(String code){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("site_cd", "manager");
		params.put("code", code);
		return codeService.selectSubCodeList(params);
	}
	
	/**
	 * 게시판 종류 정보를 가져온다.
	 * @param code
	 * @return
	 */
	private List<CodeDTO> listCode(){
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("site_cd", "manager");
		return mapper.selectBoardSectionCode(params);
	}
	
	/**
	 * 자료실 목록을 보여준다.
	 * 
	 * @param requestParams
	 * @param iPage 
	 * @param iPageSize
	 * 
	 */
	@RequestMapping("archives_list.do")
	public void archives_list(ModelMap model, 
			@RequestParam Map<String, String> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize) {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		model.addAttribute("subList", listCode(SITE_CODE_CD));
		model.addAttribute("boardSubCodeList", listCode());
		requestParams.put("board_code_cd", BOARD_ARCHIVES_CODE);
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());

		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}
	
	/**
	 * 
	 * 자료실 글을 상세 조회한다.
	 * @param board_seq
	 * @throws Exception
	 * 
	 */
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

	/**
	 * 
	 * 자료실 등록 또는 수정페이지로 이동한다.
	 * @param board_seq
	 * @param mode
	 * @throws Exception
	 * 
	 */
	@RequestMapping("archives_form.do")
	public void archives_form(ModelMap model, 
			@RequestParam(value="board_seq", required=false) String board_seq, 
			@RequestParam(value="mode", required=false) String mode) throws Exception {
		
		BoardsDTO dto = null;
		List<BoardsFileDTO> filedto = null;
		
		if (board_seq == null) {
			dto = new BoardsDTO();
			model.addAttribute("mode", "new");
		} else {
			BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
			MapperParam params = new MapperParam();
			params.put("board_seq", board_seq);
			dto = mapper.SelectOne(params);

			BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
			filedto = filemapper.SelectMany(params);
			model.addAttribute("mode", "update");
		}

		if (dto == null) {
			throw new Exception("게시물이 존재하지 않습니다.");
		}
		model.addAttribute("subList", listCode(SITE_CODE_CD));
		model.addAttribute("boardSubCodeList", listCode());
		model.addAttribute("archives", dto);
		model.addAttribute("archivesFileList", filedto);
	}
	
	/**
	 * 
	 * 자료실에 등록되어 있는 글을 삭제한다.
	 * @param board_seq
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value="archives_del.do")
	public String archives_del(HttpServletRequest request, 
			@RequestParam Map<String, String> requestParams, 
			@RequestParam(value="board_seq", required=true) String board_seq) throws Exception {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);

		@SuppressWarnings("deprecation")
		WebUser user = (WebUser) (((UserDetailsWrapper) SecurityContextHolder
				.getContext().getAuthentication().getPrincipal())
				.getUnwrappedUserDetails());
		params.put("writer", String.valueOf(user.getDetail().getUserId()));
		params.put("writer_ip", request.getRemoteAddr());

		filemapper.Delete(params);
		mapper.Delete(params);
		requestParams.remove("board_seq");

		return "redirect:archives_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	/**
	 * 
	 * 자료실의 글을 수정하거나 첨부파일을 추가 또는 삭제한다.
	 * @param requestParams 
	 * @param delete_file_seq 
	 * @param fileData
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value="archives_submit.do", method=RequestMethod.POST)
	public String archives_submit(HttpServletRequest request, 
			@RequestParam Map<String, String> requestParams, 
			@ModelAttribute("archives") @Valid BoardsDTO archives, 
			@ModelAttribute("archives_file") @Valid BoardsFileDTO archives_file, 
			@RequestParam(value="delete_file_seq", required=false) String[] delete_file_seq,
			BindingResult bindingResult, 
			@RequestParam(value="p", required=false) Integer page, 
			@RequestParam("fileData") CommonsMultipartFile[] fileData,
			RedirectAttributes redirectAttr) throws Exception {
		
		if (bindingResult.hasErrors()) {
			return "admin/archives_form";
		}

		@SuppressWarnings("unchecked")
		WebUser user = (WebUser) (((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());

		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		
		if (archives.getBoard_seq() == null) {
			archives.setBoard_code_cd(BOARD_ARCHIVES_CODE);
			archives.setWriter_ip(request.getRemoteAddr());
			archives.setWriter(String.valueOf(user.getDetail().getUserId()));
			mapper.Insert(archives);
				
			// 파일 업로드
			insertBoardFile(fileData, archives.getBoard_seq());

			return "redirect:archives_list.do";
		} else {
			mapper.Update(archives);
			// 파일 업로드
			insertBoardFile(fileData, archives.getBoard_seq());

			if(delete_file_seq !=null && delete_file_seq.length > 0){
				for(int i=0; i < delete_file_seq.length; i++) {
					params.put("board_file_seq", delete_file_seq[i]);
					filemapper.DeleteFile(params);
				}
			}
			//redirectAttr.addAllAttributes(requestParams);
			return "redirect:archives_view.do?board_seq=" + archives.getBoard_seq();
		}
	}

	/**
	 * 
	 * 자료실에 등록되어 있는 첨부파일을 다운로드한다.
	 * @param board_file_seq
	 * @throws Exception
	 * 
	 */
	@RequestMapping("archives_download.do")
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
	
	/**
	 * 
	 * 공지사항 목록을 보여준다.
	 * @param requestParams
	 * @param iPage
	 * @param iPageSize
	 * 
	 */
	@RequestMapping("notice_list.do")
	public void notice_list(ModelMap model,
			@RequestParam Map<String, String> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize
			) {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		model.addAttribute("subList", listCode(SITE_CODE_CD));

		requestParams.put("board_code_cd", BOARD_NOTICE_CODE);
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow",""+navigation.getStartRow());
		requestParams.put("endRow","" +navigation.getEndRow());

		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}

	/**
	 * 
	 * 공지사항 글을 상세 조회한다.
	 * @param board_seq
	 * @throws Exception
	 * 
	 */
	@RequestMapping("notice_view.do")
	public void notice_view(ModelMap model, 
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		BoardsDTO dto = mapper.SelectOne(params);
		List<BoardsFileDTO> filedto = filemapper.SelectMany(params);

		if (dto == null) throw new ArticleNotFoundException();

		mapper.IncreaseHit(params);
		model.addAttribute("notice", dto);
		model.addAttribute("noticeFileList", filedto);
	}

	/**
	 * 
	 * 공지사항 등록 또는 수정 페이지로 이동한다.
	 * @param board_seq
	 * @param mode
	 * @throws Exception
	 * 
	 */
	@RequestMapping("notice_form.do")
	public void notice_form(ModelMap model, 
			@RequestParam(value="board_seq", required=false) Integer board_seq, 
			@RequestParam(value="mode", required=false) String mode) throws Exception {
		BoardsDTO dto = null;
		List<BoardsFileDTO> filedto = null;
		if (board_seq == null) {
			dto = new BoardsDTO();
			model.addAttribute("mode", "new");
		} else {
			BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
			MapperParam params = new MapperParam();
			params.put("board_seq", board_seq);
			dto = mapper.SelectOne(params);

			BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
			filedto = filemapper.SelectMany(params);
			model.addAttribute("mode", "update");
		}

		if (dto == null) {
			throw new Exception("게시물이 존재하지 않습니다.");
		}
		model.addAttribute("subList", listCode(SITE_CODE_CD));
		model.addAttribute("notice", dto);
		model.addAttribute("noticeFileList", filedto);
	}
	
	/**
	 * 
	 * 공지사항 글을 삭제한다.
	 * @param board_seq
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value="notice_del.do")
	public String notice_del(HttpServletRequest request, 
			@RequestParam Map<String, String> requestParams, 
			@RequestParam(value="board_seq", required=true) String board_seq) throws Exception {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);

		@SuppressWarnings("deprecation")
		WebUser user = (WebUser) (((UserDetailsWrapper) SecurityContextHolder
				.getContext().getAuthentication().getPrincipal())
				.getUnwrappedUserDetails());
		params.put("writer", String.valueOf(user.getDetail().getUserId()));
		params.put("writer_ip", request.getRemoteAddr());

		filemapper.Delete(params);
		mapper.Delete(params);
		requestParams.remove("board_seq");

		return "redirect:notice_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	@RequestMapping(value="notice_delFile.do")
	@ResponseBody
	public Map<String, String> notice_delFile(@RequestParam Map<String, String> requestParams, @RequestParam(value="board_file_seq", required=true) String board_file_seq, ModelAndView map) throws Exception {
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		params.put("board_file_seq", board_file_seq);
		
		filemapper.DeleteFile(params);
		
		return requestParams;
	}
	
	/**
	 * 
	 * 공지사항의 글을 수정하거나 첨부파일을 추가 또는 삭제한다.
	 * @param requestParams 
	 * @param delete_file_seq 
	 * @param fileData
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value="notice_submit.do", method=RequestMethod.POST)
	public String notice_submit(HttpServletRequest request, 
			@RequestParam Map<String, String> requestParams, 
			@ModelAttribute("notice") @Valid BoardsDTO notice, 
			@ModelAttribute("notice_file") @Valid BoardsFileDTO notice_file, 
			@RequestParam(value="delete_file_seq", required=false) String[] delete_file_seq,
			BindingResult bindingResult, 
			@RequestParam(value="p", required=false) Integer page, 
			@RequestParam("fileData") CommonsMultipartFile[] fileData,
			RedirectAttributes redirectAttr) throws Exception {
		
		if (bindingResult.hasErrors()) {
			return "admin/notice_form";
		}

		@SuppressWarnings("unchecked")
		WebUser user = (WebUser) (((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());

		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);
		MapperParam params = new MapperParam();
		
		if (notice.getBoard_seq() == null) {
			notice.setBoard_code_cd(BOARD_NOTICE_CODE);
			notice.setWriter_ip(request.getRemoteAddr());
			notice.setWriter(String.valueOf(user.getDetail().getUserId()));
			mapper.Insert(notice);

			// 파일 업로드
			insertBoardFile(fileData, notice.getBoard_seq());

			return "redirect:notice_list.do";
		} else {
			mapper.Update(notice);
			// 파일 업로드
			insertBoardFile(fileData, notice.getBoard_seq());
			
			
			// 첨부파일 삭제
			if(delete_file_seq !=null && delete_file_seq.length > 0){
				for(int i=0; i < delete_file_seq.length; i++) {
					params.put("board_file_seq", delete_file_seq[i]);
					filemapper.DeleteFile(params);
				}
			}

			return "redirect:notice_view.do?board_seq=" + notice.getBoard_seq();
		}
	}

	/**
	 * 
	 * 공지사항에 등록되어 있는 첨부파일을 다운로드한다.
	 * @param board_file_seq
	 * @throws Exception
	 * 
	 */
	@RequestMapping("notice_download.do")
	public DownloadModelAndView notice_download(
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

	/**
	 * 파일 등록을 처리한다
	 * 
	 * @param fileData
	 * @param pid
	 * @throws Exception
	 */
	private void insertBoardFile(CommonsMultipartFile[] fileData, Integer board_seq) throws Exception {

		BoardFileMapper filemapper = sessionTemplate.getMapper(BoardFileMapper.class);

		// 첨부파일이 있으면
		if (fileData != null && fileData.length > 0) {
			FileSaveInfo filesaveInfo = null;
			for (CommonsMultipartFile file : fileData) {
				if(!file.isEmpty()){
					filesaveInfo = Utils.SaveTo(pdsLocation, file);
					BoardsFileDTO fileDto = new BoardsFileDTO();
					fileDto.setFilename(filesaveInfo.getOriginalFilename());
					fileDto.setFilepath(filesaveInfo.getSaveFilepath());
					fileDto.setBoard_seq(board_seq);
					filemapper.InsertFile(fileDto);
				}
			}
		}
	}
	
	/**
	 * 
	 * FAQ 목록을 보여준다.
	 * @param requestParams 
	 * @param iPage
	 * @param iPageSize
	 * 
	 */
	@RequestMapping("faq_list.do")
	public void faq_list(ModelMap model,
			@RequestParam Map<String, String> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize) {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		model.addAttribute("subList", listCode(SITE_CODE_CD));
		
		requestParams.put("board_code_cd", BOARD_FAQ_CODE);
		int count = mapper.Count(requestParams);
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}
	
	/**
	 * 
	 * FAQ 등록 또는 수정 페이지로 이동한다.
	 * @param board_seq
	 * @param mode
	 * @throws Exception
	 * 
	 */
	@RequestMapping("faq_form.do")
	public void faq_form(ModelMap model,
			@RequestParam(value="board_seq", required=false) Integer board_seq,
			@RequestParam(value="mode", required=false) String mode) throws Exception {
		BoardsDTO dto = null;
		if(board_seq == null) {
			dto = new BoardsDTO();
			model.addAttribute("mode", "new");
		} else {
			BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
			MapperParam params = new MapperParam();
			params.put("board_seq", board_seq);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("게시물이 존재하지 않습니다.");
		}
		
		model.addAttribute("subList", listCode(SITE_CODE_CD));
		model.addAttribute("faq", dto);
	}
	
	/**
	 * 
	 * FAQ에 등록되어 있는 글을 삭제한다.
	 * @param board_seq
	 * @throws Exception
	 * 
	 */
	@RequestMapping("faq_del.do")
	public String faq_del(HttpServletRequest request,
			@RequestParam Map<String, String> requestParams,
			@RequestParam(value="board_seq", required=true) Integer board_seq) throws Exception {
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		MapperParam params = new MapperParam();
		params.put("board_seq", board_seq);
		
		mapper.Delete(params);
		return "redirect:faq_list.do";
	}
	
	/**
	 * 
	 * FAQ에 등록되어 있는 글을 수정한다.
	 * @param request
	 * @param requestParams 
	 * @param faq
	 * @param p
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value="faq_submit.do", method=RequestMethod.POST)
	public String faq_submit(HttpServletRequest request,
			@RequestParam Map<String, String> requestParams,
			@ModelAttribute("faq") @Valid BoardsDTO faq,
			BindingResult bindingResult,
			@RequestParam(value="p", required=false) Integer page,
			RedirectAttributes redirectAttr) throws Exception {
		if(bindingResult.hasErrors()) {
			return "admin/faq_form";
		}
		@SuppressWarnings("unchecked")
		WebUser user = (WebUser) (((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		
		if(faq.getBoard_seq() == null) {
			faq.setBoard_code_cd(BOARD_FAQ_CODE);
			faq.setWriter_ip(request.getRemoteAddr());
			faq.setWriter(String.valueOf(user.getDetail().getUserId()));
			mapper.Insert(faq);
			return "redirect:faq_list.do";
		} else {
			mapper.Update(faq);
			//redirectAttr.addFlashAttribute("board_seq", faq.getBoard_seq());
			return "redirect:faq_form.do?board_seq=" + faq.getBoard_seq();
		}
	}
}
