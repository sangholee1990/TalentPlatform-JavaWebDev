package com.gaia3d.web.controller.admin;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jackson.map.util.BeanUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.dto.DomainDataMappingDTO;
import com.gaia3d.web.dto.wmo.*;
import com.gaia3d.web.exception.DataNotFoundException;
import com.gaia3d.web.mapper.CodeMapper;
import com.gaia3d.web.mapper.DomainMapper;
import com.gaia3d.web.mapper.WmoMetaMapper;
import com.gaia3d.web.service.CodeService;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.ReflectUtils;
import com.gaia3d.web.util.TxUtil;
import com.gaia3d.web.util.WebUtil;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;

@Controller
@RequestMapping("/admin/wmo")
public class WmoMetaMngController extends BaseController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(WmoMetaMngController.class);
	
	@Resource(name="txUtil")
	private TxUtil txUtil;

	@Autowired
	private CodeService codeService;
	
	private Integer extensioninformationseqn; 	
	
	/**
	 * @param model
	 * @param requestParams
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("wmometa_list.do")
	public void wmometa_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {

		WmoMetaMapper mapper = sessionTemplate.getMapper(WmoMetaMapper.class);

		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}
	
	/**
	 * @param model
	 * @param requestParams
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("wmometa_list_popup.do")
	public void wmometa_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {

		WmoMetaMapper mapper = sessionTemplate.getMapper(WmoMetaMapper.class);

		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}
	
	
	
	/**
	 * 등록/수정 폼
	 * @param model
	 * @param clt_tar_grp_seq_n
	 * @param mode
	 * @throws Exception
	 */
	@RequestMapping("wmometa_form.do")
	public void wmometa_form(ModelMap model, 
			@RequestParam(value="view_metadataseqn", required=false) String metadataseqn,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {

		/*
		WmoMetaMapper mapper = sessionTemplate.getMapper(WmoMetaMapper.class);	
		MD_Metadata md_Metadata = null;
		
		try{
			Map<String,String> params = new HashMap<String,String>();
			params.put("metadataseqn", metadataseqn);
			md_Metadata = mapper.SelectOne(params);
		}catch(Exception e){
			e.printStackTrace();
		}
			
		//WmoJAXBEUtil.bean2json(re);
		//WmoJAXBEUtil.bean2xml(re);
		
		model.addAttribute("md_Metadata", md_Metadata );
		*/
		model.addAttribute("view_metadataseqn", metadataseqn );
		model.addAttribute("mode", mode);
	}

	/**
	 * bound box 샘플 적용 안함.
	 * @param model
	 * @param mode
	 * @throws Exception
	 */
	@RequestMapping("wmometa_boundbox.do")
	public void wmometa_boundbox(ModelMap model, 
			@RequestParam(value="mode", required=false) String mode ) throws Exception {


	}
	
	/**
	 * 상세 조회
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("wmometa_view.do")
	public void wmometa_view(ModelMap model) throws Exception {
		// call wmometa_getmeta.do after loading
	}

	
	/**
	 * WMO meta 상세 조회 Tab
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("wmometa_view_innerHtml.do")
	public void wmometa_view_innerHtml(ModelMap model) throws Exception {
		// wmometa_view.do , datamaster_view.do tab load after call
	}
	
	/**
	 * WMO Meta 기본 정보 (json object )
	 * @param model
	 * @param md_Metadata
	 * @param mode
	 * @throws Exception
	 */
	@RequestMapping(value = "wmometa_getmeta.do" )
	public @ResponseBody MD_Metadata wmometa_getmeta(ModelMap model, 
			@RequestParam(value="metadataseqn", required=true) String metadataseqn ) throws Exception {
		
		WmoMetaMapper mapper = sessionTemplate.getMapper(WmoMetaMapper.class);
		
		Map<String,String> param = new HashMap<String,String>();
		param.put("metadataseqn", metadataseqn);
		MD_Metadata md_Metadata = mapper.SelectOne(param);
		
		return md_Metadata;
	}
	
	/**
	 * WMO Code List ( json object)
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "wmometa_getcodelist.do" )	
	public @ResponseBody Map<String, List<Map<String, String>>> getWmoCodeList(ModelMap model) throws Exception {
		return codeService.getWmoCodeList();
	}
	
	/**
	 * WMO 삭제
	 * @param model
	 * @param requestParams
	 * @param metadataseqn
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "wmometa_delete.do" )
	public String wmometa_delete(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_metadataseqn", required=false) String metadataseqn ) throws Exception {
		
		WmoMetaMapper mapper = sessionTemplate.getMapper(WmoMetaMapper.class);
		
		try{
			Map<String,String> param = new HashMap<String,String>();
			param.put("metadataseqn", metadataseqn);
			MD_Metadata md_Metadata = mapper.SelectOne(param);
			
			txUtil.startTransaction();
			deleteMetadata(mapper, md_Metadata);
			
			mapper.Delete(md_Metadata);
			txUtil.commitTransaction();
		
		}catch(Exception e){
			e.printStackTrace();
			txUtil.rollBackTransaction();
		}
		
		return "redirect:wmometa_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	/**
	 * WMO Meta 등록/수정/삭제 처리
	 * @param model
	 * @param md_Metadata
	 * @param mode
	 * @throws Exception
	 */
	@RequestMapping(value = "wmometa_submit.do" )
	public @ResponseBody MD_Metadata wmometa_submit(ModelMap model, 
			@RequestBody MD_Metadata md_Metadata,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {

		WmoMetaMapper mapper = sessionTemplate.getMapper(WmoMetaMapper.class);
		
		if (md_Metadata.getMetadataseqn() == null ){

			try{
				txUtil.startTransaction();
				InsertMetadata(mapper, md_Metadata);
				txUtil.commitTransaction();
			
			}catch(Exception e){
				e.printStackTrace();
				txUtil.rollBackTransaction();
			}

		}else if (md_Metadata.getMetadataseqn() != null ){
			try{
				txUtil.startTransaction();

				deleteMetadata(mapper, md_Metadata);
				mapper.Update(md_Metadata);
				InsertMetadata(mapper, md_Metadata);

				txUtil.commitTransaction();
			
			}catch(Exception e){
				e.printStackTrace();
				txUtil.rollBackTransaction();
			}
		
			
		}else{
			
		}
		return md_Metadata;
	}
	
	@RequestMapping("wmometa_xmldownload.do")
	@ResponseBody
	public DownloadModelAndView wmometa_xmldownload(ModelMap model,
			@RequestParam(value="view_metadataseqn", required=false) String metadataseqn) throws FileNotFoundException, UnsupportedEncodingException {

		WmoMetaMapper mapper = sessionTemplate.getMapper(WmoMetaMapper.class);
		
		Map<String,String> param = new HashMap<String,String>();
		param.put("metadataseqn", metadataseqn);
		MD_Metadata md_Metadata = mapper.SelectOne(param);
		if (md_Metadata != null) {
			
			String xmlStr = WmoJAXBEUtil.bean2xml(md_Metadata);
			
			return new DownloadModelAndView(xmlStr.getBytes(), md_Metadata.getFileidentifier() + ".xml");
		} else {
			throw new DataNotFoundException();
		}
	}
	/*****************************************************************************************
	 * 
	 * WMO Meata 삭제  start 
	 * 
	 *****************************************************************************************/

	/**
	 * Object to HashMap Convert
	 * @param obj
	 * @return
	 */
	private Map<String, Object> convertHashMap2(Object obj) {
		Map<String, Object> objectAsMap = new HashMap<String, Object>();
		try{
		    BeanInfo info = Introspector.getBeanInfo(obj.getClass());
		    for (PropertyDescriptor pd : info.getPropertyDescriptors()) {
		        Method reader = pd.getReadMethod();
		        if (reader != null)
		            objectAsMap.put(pd.getName(),reader.invoke(obj));
		    }
		}catch(Exception e){
			e.printStackTrace();
		}
		return objectAsMap;
	} 
    
	/**
	 * Wmo meta 삭제
	 * @param mapper
	 * @param md_Metadata
	 */
	private void deleteMetadata(WmoMetaMapper mapper, MD_Metadata md_Metadata) {

		Map param = new HashMap(); 
		param.put("metadataseqn", md_Metadata.getMetadataseqn());
		
		DeleteCI_ResponsibleParty(mapper, md_Metadata.getContact());
		mapper.DeleteCI_ResponsibleParty(param);
		
		
		DeleteDQ_DataQuality(mapper, md_Metadata.getDataqualityinfo());
		mapper.DeleteDQ_DataQuality(param);
		
		
		DeleteMD_Distribution(mapper, md_Metadata.getDistributioninfo());
		mapper.DeleteMD_Distribution(param);
		
		
		DeleteMD_DataIdentification(mapper, md_Metadata.getIdentificationinfo());
		mapper.DeleteMD_DataIdentification(param);
		
		
		mapper.DeleteMD_Constraints(param);
		
		DeleteMD_ExtensionInformation(mapper, md_Metadata.getMetadataextensioninfo());
		mapper.DeleteMD_ExtensionInformation(param);
		
		
		DeleteMD_MaintenanceInformation(mapper, md_Metadata.getMetadatamaintenance());
		mapper.DeleteMD_MaintenanceInformation(param);
		
	}

	
	/**
	 * Delete MD_MaintenanceInformation
	 * @param mapper
	 * @param metadatamaintenance
	 */
	private void DeleteMD_MaintenanceInformation(WmoMetaMapper mapper,
			MD_MaintenanceInformation metadatamaintenance) {
		if ( metadatamaintenance == null ) return;
		
		Map param = new HashMap(); 
		param.put("maintenanceinformationseqn", metadatamaintenance.getMaintenanceinformationseqn());
		
		DeleteCI_ResponsibleParty(mapper, metadatamaintenance.getContact());
		mapper.DeleteCI_ResponsibleParty(param);
		
	}


	/**
	 * Delete MD_MaintenanceInformation list
	 * @param mapper
	 * @param list
	 */
	private void DeleteMD_MaintenanceInformation(WmoMetaMapper mapper,
			List<MD_MaintenanceInformation> list) {
		if ( list == null ) return;
		for ( MD_MaintenanceInformation metadatamaintenance : list){
			DeleteMD_MaintenanceInformation(mapper, metadatamaintenance);
		}
	}


	/**
	 * @param mapper
	 * @param metadataextensioninfo
	 */
	private void DeleteMD_ExtensionInformation(WmoMetaMapper mapper,
			List<MD_ExtensionInformation> list) {
		if ( list == null ) return;
		for(MD_ExtensionInformation metadataextensioninfo : list ){
			Map param = new HashMap(); 
			param.put("extensioninformationseqn", metadataextensioninfo.getExtensioninformationseqn());
			mapper.DeleteCI_OnlineResource( param );
		}
		
	}



	/**
	 * MD_DataIdentification delete
	 * @param mapper
	 * @param identificationinfo
	 */
	private void DeleteMD_DataIdentification(WmoMetaMapper mapper,
			List<MD_DataIdentification> list) {
		if ( list == null ) return;
		for(MD_DataIdentification identificationinfo : list){
			Map param = new HashMap(); 
			param.put("dataidentificationseqn", identificationinfo.getDataidentificationseqn());
			
			DeleteCI_Citation( mapper, identificationinfo.getCitation());
			mapper.DeleteCI_Citation(param);
			
			DeleteMD_Keywords( mapper, identificationinfo.getDescriptivekeywords());
			mapper.DeleteMD_Keywords(param);
			
			DeleteEX_Extent( mapper, identificationinfo.getExtent());
			mapper.DeleteEX_Extent(param);
			
			DeleteCI_ResponsibleParty( mapper, identificationinfo.getPointofcontact());
			mapper.DeleteCI_ResponsibleParty(param);
			
			mapper.DeleteMD_Constraints(param);
			
			DeleteMD_MaintenanceInformation( mapper, identificationinfo.getResourcemaintenance());
			mapper.DeleteMD_MaintenanceInformation(param);
			
		}
		
	}


	/**
	 * EX_Extent delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteEX_Extent(WmoMetaMapper mapper, List<EX_Extent> list) {
		if ( list == null ) return;
		for( EX_Extent extent : list ){
		
			Map param = new HashMap(); 
			param.put("extentseqn", extent.getDataidentificationseqn());
			
			
			DeleteEX_GeographicExtent(mapper, extent.getGeographicelement());
			mapper.DeleteEX_GeographicExtent(param);
			
			mapper.DeleteEX_TemporalExtent(param);
				
		}
		
	}



	/**
	 * EX_GeographicExtent delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteEX_GeographicExtent(WmoMetaMapper mapper,
			List<EX_GeographicExtent> list) {
		if ( list == null ) return;
		
		for(EX_GeographicExtent geographicelement : list){
			if ( geographicelement instanceof EX_GeographicDescription ){
				EX_GeographicDescription geographicdescription = (EX_GeographicDescription)geographicelement;

				Map param = new HashMap(); 
				param.put("geographicdescriptionseqn", geographicdescription.getGeographicdescriptionseqn() );
				
				DeleteMD_Identifier(mapper, geographicdescription.getGeographicidentifier());
				mapper.DeleteMD_Identifier( param);
			}
			
			//if ( geographicelement instanceof EX_GeographicBoundingBox ){
				//Nothing to do, EX_GeographicBoundingBox has no reference object
				//TODO if added EX_GeographicBoundingBox reference object and something to write code
			//}
		}
		
	}


	/**
	 * MD_Keywords delete 
	 * @param mapper
	 * @param list
	 */
	private void DeleteMD_Keywords(WmoMetaMapper mapper,
			List<MD_Keywords> list) {
		
		if ( list == null ) return;
		
		for(MD_Keywords descriptivekeywords : list ){
			
			Map param = new HashMap(); 
			param.put("keywordsseqn", descriptivekeywords.getKeywordsseqn() );
			
			
			DeleteCI_Citation(mapper, descriptivekeywords.getThesaurusname());
			mapper.DeleteCI_Citation(param);
		}
		
	}


	


	/**
	 * MD_Distribution delete
	 * @param mapper
	 * @param distributioninfo
	 */
	private void DeleteMD_Distribution(WmoMetaMapper mapper,
			MD_Distribution distributioninfo) {
		if ( distributioninfo == null ) return;
		
		Map param = new HashMap(); 
		param.put("distributionseqn", distributioninfo.getDistributionseqn());
		
		DeleteMD_Format(mapper, distributioninfo.getDistributionformat());
		mapper.DeleteMD_Format(param);
		
		DeleteMD_Distributor(mapper, distributioninfo.getDistributor());
		mapper.DeleteMD_Distributor(param);
		
		DeleteMD_DigitalTransferOptions(mapper, distributioninfo.getTransferoptions());
		mapper.DeleteMD_DigitalTransferOptions(param);
		
	}


	/**
	 * MD_DigitalTransferOptions delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteMD_DigitalTransferOptions(WmoMetaMapper mapper,
			List<MD_DigitalTransferOptions> list) {

		if ( list == null ) return;
		
		for(MD_DigitalTransferOptions transferoptions: list ){
			Map param = new HashMap(); 
			param.put("digitaltransferoptionsseqn", transferoptions.getDigitaltransferoptionsseqn());
			
			mapper.DeleteCI_OnlineResource(param);
		}
	}


	/**
	 * MD_Distributor delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteMD_Distributor(WmoMetaMapper mapper,
			List<MD_Distributor> list) {
		if ( list == null ) return;
		
		for(MD_Distributor distributor : list){
			DeleteMD_Distributor(mapper, distributor);
		}
		
	}


	/**
	 * MD_Distributor delete
	 * @param mapper
	 * @param distributor
	 */
	private void DeleteMD_Distributor(WmoMetaMapper mapper,
			MD_Distributor distributor) {
		
		if ( distributor == null ) return;
		Map param = new HashMap();
		param.put("distributorseqn", distributor.getDistributorseqn());
		
		DeleteCI_ResponsibleParty(mapper, distributor.getDistributorcontact());
		mapper.DeleteCI_ResponsibleParty(param);
		
		DeleteMD_Format(mapper, distributor.getDistributorformat());
		mapper.DeleteMD_Format(param);
		
		DeleteMD_DigitalTransferOptions(mapper, distributor.getDistributortransferoptions());
		mapper.DeleteMD_DigitalTransferOptions(param);
	}


	/**
	 * MD_Format delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteMD_Format(WmoMetaMapper mapper,
			List<MD_Format> list) {
		if ( list == null ) return;
		
		for(MD_Format distributionformat : list ){
			
			Map param = new HashMap();
			param.put("formatseqn", distributionformat.getFormatseqn());
			DeleteMD_Distributor(mapper, distributionformat.getFormatdistributor());
			mapper.DeleteMD_Distributor(param);
		}
	}


	/**
	 * DQ_DataQuality delete
	 * @param mapper
	 * @param dataqualityinfo
	 */
	private void DeleteDQ_DataQuality(WmoMetaMapper mapper,
			List<DQ_DataQuality> list) {
		
		if ( list == null ) return;
	
		for(DQ_DataQuality dataqualityinfo : list){
			
			Map param = new HashMap(); 
			param.put("dataqualityseqn", dataqualityinfo.getDataqualityseqn());
			
			
			mapper.DeleteLI_Lineage( param);
	
			DeleteDQ_Element(mapper, dataqualityinfo.getReport());
			mapper.DeleteDQ_Element(param);
			
			mapper.DeleteDQ_Scope( param );
		}
	}



	/**
	 * DQ_Element delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteDQ_Element(WmoMetaMapper mapper, List<DQ_Element> list) {
		if ( list == null ) return;
		
		for(DQ_Element tmp : list){
			if ( tmp instanceof DQ_DomainConsistency){
				DQ_DomainConsistency report = (DQ_DomainConsistency)tmp;
			
				Map param = new HashMap(); 
				param.put("domainconsistencyseqn", report.getDomainconsistencyseqn());
				
				
				DeleteMD_Identifier(mapper, report.getMeasureidentification());
				mapper.DeleteMD_Identifier(param);
				
				DeleteDQ_Result(mapper, report.getResult());
				mapper.DeleteDQ_Result(param);
			}
		}
	}



	/**
	 * DQ_Result delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteDQ_Result(WmoMetaMapper mapper, DQ_Result[] list) {
		if ( list == null ) return;
		
		for( DQ_Result tmp : list){
			if ( tmp instanceof DQ_ConformanceResult ){
				DQ_ConformanceResult result = (DQ_ConformanceResult)tmp; 
				
				
				Map param = new HashMap(); 
				param.put("conformanceresultseqn", result.getConformanceresultseqn());
				
				DeleteCI_Citation(mapper, result.getSpecification() );
				mapper.DeleteCI_Citation(param);
				
			}
		}
		
	}


	/**
	 * CI_Citation delete
	 * @param mapper
	 * @param specification
	 */
	private void DeleteCI_Citation(WmoMetaMapper mapper,
			CI_Citation specification) {
		
		if ( specification == null ) return;
		
		Map param = new HashMap(); 
		param.put("citationseqn", specification.getCitationseqn());
		
		DeleteCI_ResponsibleParty(mapper, specification.getCitedresponsibleparty());
		mapper.DeleteCI_ResponsibleParty( param );
		
		mapper.DeleteCI_Date(param );
		
		DeleteMD_Identifier(mapper, specification.getIdentifier());
		mapper.DeleteMD_Identifier(param);
	}
	
	/**
	 * CI_Citation delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteCI_Citation(WmoMetaMapper mapper,
			List<CI_Citation> list) {
		
		if ( list == null ) return;
		
		for(CI_Citation citation : list ){
			DeleteCI_Citation(mapper, citation);
		}
	}


	/**
	 * MD_Identifier delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteMD_Identifier(WmoMetaMapper mapper,
			List<MD_Identifier> list) {
		
		if ( list == null ) return;
		
		for(MD_Identifier identifier : list ){
			DeleteMD_Identifier(mapper, identifier);
		}
	}
	

	/**
	 * MD_Identifier delete
	 * @param mapper
	 * @param measureidentification
	 */
	private void DeleteMD_Identifier(WmoMetaMapper mapper,
			MD_Identifier measureidentification) {
		
		if ( measureidentification == null ) return;
		
		DeleteCI_ResponsibleParty(mapper, measureidentification.getAuthority());
	}


	/**
	 * CI_ResponsibleParty delete
	 * @param mapper
	 * @param contact
	 */
	private void DeleteCI_ResponsibleParty(WmoMetaMapper mapper,
			CI_ResponsibleParty contact) {

		if ( contact == null ) return;
		
		Map param = new HashMap(); 
		param.put("responsiblepartyseqn", contact.getResponsiblepartyseqn());
		
		DeleteCI_Contact(mapper, contact.getContactinfo());
		mapper.DeleteCI_Contact(param);
	}


	/**
	 * CI_ResponsibleParty delete
	 * @param mapper
	 * @param contact
	 */
	private void DeleteCI_ResponsibleParty(WmoMetaMapper mapper,
			List<CI_ResponsibleParty> list) {
		
		if ( list == null ) return;
		
		for(CI_ResponsibleParty contact : list ){
			DeleteCI_ResponsibleParty(mapper, contact);
		}
	}


	/**
	 * CI_Contact delete
	 * @param mapper
	 * @param list
	 */
	private void DeleteCI_Contact(WmoMetaMapper mapper,
			List<CI_Contact> list) {
	
		if ( list == null ) return;
		
		for( CI_Contact contactinfo : list ) {
			Map param = new HashMap(); 
			param.put("contactseqn", contactinfo.getContactseqn());
			
			
			mapper.DeleteCI_OnlineResource( param );
			mapper.DelteCI_Address( param );
			mapper.DelteCI_Telephone( param);
		}
		
	}


	/*****************************************************************************************
	 * 
	 * WMO Meata 삭제 End 
	 * 
	 *****************************************************************************************/
	
	
	
	
	
	
	
	
	
	/*****************************************************************************************
	 * 
	 * WMO Meata 등록 start 
	 * 
	 *****************************************************************************************/

	/**
	 * Wmo meata등록
	 * @param mapper
	 * @param md_Metadata
	 */
	private void InsertMetadata(WmoMetaMapper mapper, MD_Metadata md_Metadata){
			
			//WMO meta 기본정보
			mapper.Insert(md_Metadata);

		
			//contact 관련그룹
			InsertCI_ResponsibleParty(mapper, 
					"metadataseqn",
					md_Metadata.getMetadataseqn(), 
					md_Metadata.getContact());
			
			//metadataextensioninfo 확장설명정보
			InsertMD_ExtensionInformation(mapper,
					md_Metadata.getMetadataseqn(),
					md_Metadata.getMetadataextensioninfo()
					);
			
			
			//metadatamaintenance 유지보수정보
			if ( md_Metadata.getMetadatamaintenance() != null ) {
			List metadatamaintenanceList = new ArrayList();
			metadatamaintenanceList.add(md_Metadata.getMetadatamaintenance());
			InsertMD_MaintenanceInformation(mapper, 
								"metadataseqn",
								md_Metadata.getMetadataseqn(), 
								metadatamaintenanceList);
			}
			
			//identificationinfo 자료기본정보
			InsertMD_DataIdentification(mapper,
									md_Metadata.getMetadataseqn(),
									md_Metadata.getIdentificationinfo());
			
		
			//metadataconstraints 자료활용정보
			InsertMD_Constraints(mapper, 
							"metadataseqn",
							md_Metadata.getMetadataseqn(),
							md_Metadata.getMetadataconstraints());
			
			//distributioninfo 자료분배및옵션정보
			InsertMD_Distribution(mapper, md_Metadata.getMetadataseqn(), md_Metadata.getDistributioninfo());
		
			//dataqualityinfo 자료품질평가
			InsertDQ_DataQuality(mapper, md_Metadata.getMetadataseqn(), md_Metadata.getDataqualityinfo() );
			
			
	}

	/**
	 * 자료품질평가
	 * @param mapper
	 * @param metadataseqn
	 * @param dataqualityinfo
	 */
	private void InsertDQ_DataQuality(WmoMetaMapper mapper,
			Integer metadataseqn, List<DQ_DataQuality> list) {
		
		if ( list == null ) return;
		
		for( DQ_DataQuality dataqualityinfo : list ){
			dataqualityinfo.setMetadataseqn(metadataseqn);
			mapper.InsertDQ_DataQuality(dataqualityinfo);
			
			DQ_Scope scope = dataqualityinfo.getScope();
			scope.setDataqualityseqn(dataqualityinfo.getDataqualityseqn());

			mapper.InsertDQ_Scope(scope);
			
			InsertDQ_Element(mapper,dataqualityinfo.getDataqualityseqn(), dataqualityinfo.getReport() );
			
			
			
		}
	}


	/**
	 * 물리적품질정보
	 * @param mapper
	 * @param dataqualityseqn
	 * @param report
	 */
	private void InsertDQ_Element(WmoMetaMapper mapper,
			Integer dataqualityseqn, List<DQ_Element> list) {

		if ( list == null ) return;

		for( DQ_Element report : list ){
			report.setDataqualityseqn(dataqualityseqn);
			if ( report instanceof DQ_DomainConsistency ) {
				DQ_DomainConsistency tmp = (DQ_DomainConsistency)report;
				mapper.InsertDQ_DomainConsistency((DQ_DomainConsistency)tmp);
				
				List measureidentificationList = new ArrayList();
				measureidentificationList.add(tmp.getMeasureidentification());
				InsertMD_Identifier(mapper, 
						"domainconsistencyseqn", 
						tmp.getDomainconsistencyseqn(), 
						measureidentificationList);
				
				
				InsertDQ_Result(mapper, 
						tmp.getDomainconsistencyseqn(),
						tmp.getResultArray());
				
			}
		}
	}


	private void InsertDQ_Result(WmoMetaMapper mapper,
			Integer domainconsistencyseqn, List<DQ_ConformanceResult> list) {
		
		if ( list == null ) return;

		for( DQ_Result resultArray : list ){
			resultArray.setDomainconsistencyseqn(domainconsistencyseqn);
			
			if ( resultArray instanceof DQ_ConformanceResult ) {	
				DQ_ConformanceResult tmp = (DQ_ConformanceResult)resultArray;
				mapper.InsertDQ_ConformanceResult(tmp);
				
				List specificationList = new ArrayList();
				specificationList.add(tmp.getSpecification());
				InsertCI_Citation(mapper, 
						"conformanceresultseqn", 
						tmp.getConformanceresultseqn(), 
						specificationList);

			}
		}
	}


	/**
	 * 자료분배및옵션정보
	 * @param mapper
	 * @param metadataseqn
	 * @param distributioninfo
	 */
	private void InsertMD_Distribution(WmoMetaMapper mapper,
			Integer metadataseqn, MD_Distribution distributioninfo) {

		if ( distributioninfo == null ) return;

		distributioninfo.setMetadataseqn(metadataseqn);
		mapper.InsertMD_Distribution(distributioninfo);
		
		InsertMD_Format(mapper,
				"distributionseqn",  
				distributioninfo.getDistributionseqn(), 
				distributioninfo.getDistributionformat());
		
		InsertMD_Distributor(mapper,
				"distributionseqn",  
				distributioninfo.getDistributionseqn(), 
				distributioninfo.getDistributor());
		
		
		InsertMD_DigitalTransferOptions(mapper,
				"distributionseqn",  
				distributioninfo.getDistributionseqn(), 
				distributioninfo.getTransferoptions());
		
	}
	
	
	
	/**
	 * 자료형식
	 * @param mapper
	 * @param property
	 * @param value
	 * @param list
	 */
	private void InsertMD_Format(WmoMetaMapper mapper, String property,
			Integer value, List<MD_Format> list) {
		
		if ( list == null ) return;
		
		for( MD_Format distributionformat : list ){
			ReflectUtils.callSetter(distributionformat, property, value);
			mapper.InsertMD_Format(distributionformat);
			
			InsertMD_Distributor(mapper, 
						"formatseqn",
						distributionformat.getFormatseqn(), 
						distributionformat.getFormatdistributor());

			
		}
		
	}


	/**
	 * 배포처정보
	 * @param mapper
	 * @param property
	 * @param value
	 * @param list
	 */
	private void InsertMD_Distributor(WmoMetaMapper mapper, String property,
			Integer value, List<MD_Distributor> list) {
		
		if ( list == null ) return;

		for( MD_Distributor formatdistributor : list ){
			ReflectUtils.callSetter(formatdistributor, property, value);
			mapper.InsertMD_Distributor(formatdistributor);
	
			//distributorcontact 관련그룹_
			List distributorcontactList = new ArrayList();
			distributorcontactList.add(formatdistributor.getDistributorcontact());
			InsertCI_ResponsibleParty(mapper, 
					"distributorseqn", 
					formatdistributor.getDistributorseqn()
					, distributorcontactList);
			
			//distributorformat 자료형식
			InsertMD_Format(mapper, 
					"distributorseqn", 
					formatdistributor.getDistributorseqn(),
					formatdistributor.getDistributorformat());
			
			//distributortransferoptions 자료의기술적방법및미디어정보
			InsertMD_DigitalTransferOptions(mapper, 
					"distributorseqn", 
					formatdistributor.getDistributorseqn(),
					formatdistributor.getDistributortransferoptions());
			
		}
		
	}


	/**
	 * 자료의기술적방법및미디어정보
	 * @param mapper
	 * @param string
	 * @param distributorseqn
	 * @param distributortransferoptions
	 */
	private void InsertMD_DigitalTransferOptions(WmoMetaMapper mapper,
			String property,
			Integer value, 
			List<MD_DigitalTransferOptions> list) {
		
		if ( list == null ) return;

		for( MD_DigitalTransferOptions distributortransferoptions : list ){
			ReflectUtils.callSetter(distributortransferoptions, property, value);
			
			mapper.InsertMD_DigitalTransferOptions(distributortransferoptions);
			
			InsertCI_OnlineResource(mapper, 
					"digitaltransferoptionsseqn", 
					distributortransferoptions.getDigitaltransferoptionsseqn(), 
					distributortransferoptions.getOnlines());
			
		}	
		
	}


	/**
	 * 자료기본정보
	 * @param mapper
	 * @param metadataseqn
	 * @param list
	 */
	private void InsertMD_DataIdentification(WmoMetaMapper mapper,
			Integer metadataseqn, List<MD_DataIdentification> list) {
		
		if ( list == null ) return;

		for( MD_DataIdentification identificationinfo : list ){
			identificationinfo.setMetadataseqn(metadataseqn);
			
			mapper.InsertMD_DataIdentification(identificationinfo);
		
			//citation 자료인용정보
			InsertCI_Citation(mapper,
							"dataidentificationseqn",
							identificationinfo.getDataidentificationseqn(), 
							identificationinfo.getCitation());
			
			//pointofcontact 관련그룹
			InsertCI_ResponsibleParty(mapper, 
					"dataidentificationseqn",
					identificationinfo.getDataidentificationseqn(), 
					identificationinfo.getPointofcontact());
			
			//resourcemaintenance 유지보수정보
			InsertMD_MaintenanceInformation(mapper, 
					"dataidentificationseqn",
					identificationinfo.getDataidentificationseqn(), 
					identificationinfo.getResourcemaintenance());
			
			//descriptivekeywords 키워드정보
			InsertMD_Keywords(mapper, 
					identificationinfo.getDataidentificationseqn(), 
					identificationinfo.getDescriptivekeywords());
			
			//extent 범위정보
			InsertEX_Extent(mapper, 
					identificationinfo.getDataidentificationseqn(),
					identificationinfo.getExtent());
			
			//resourceconstraints 자료활용정보
			InsertMD_Constraints(mapper, 
					"dataidentificationseqn",
					identificationinfo.getDataidentificationseqn(),
					identificationinfo.getResourceconstraints());
			
		}
		
	}

	/**
	 * 자료활용정보
	 * @param mapper
	 * @param property
	 * @param value
	 * @param list
	 */
	private void InsertMD_Constraints(WmoMetaMapper mapper, 
							String property,
							Integer value,
							List<MD_Constraints> list) {
	
		if ( list == null ) return;

		for( MD_Constraints resourceconstraints : list ){
			ReflectUtils.callSetter(resourceconstraints, property, value);
			mapper.InsertMD_Constraints(resourceconstraints);
		}
	}


	/**
	 * 범위정보
	 * @param mapper
	 * @param dataidentificationseqn
	 * @param extent
	 */
	private void InsertEX_Extent(WmoMetaMapper mapper,
			Integer dataidentificationseqn, List<EX_Extent> list) {
		
		if ( list == null ) return;

		for( EX_Extent extent : list ){
			extent.setDataidentificationseqn(dataidentificationseqn);
			mapper.InsertEX_Extent(extent);
			
			
			InsertEX_GeographicExtent(mapper, extent.getExtentseqn(), extent.getGeographicelement() );
			
			InsertEX_TemporalExtent(mapper, extent.getExtentseqn(), extent.getTemporalelement());
			
	
			
		}
	}


	/**
	 * 지리적검색요소
	 * @param mapper
	 * @param extentseqn
	 * @param list
	 */
	private void InsertEX_GeographicExtent(WmoMetaMapper mapper,
			Integer extentseqn, List<EX_GeographicExtent> list) {
		
		if ( list == null ) return;

		for( EX_GeographicExtent geographicelement : list ){
			
			geographicelement.setExtentseqn(extentseqn);
			
			if ( geographicelement instanceof EX_GeographicBoundingBox ){
				mapper.InsertEX_GeographicBoundingBox((EX_GeographicBoundingBox)geographicelement);
			}
			
			if ( geographicelement instanceof EX_GeographicDescription ){
				mapper.InsertEX_GeographicDescription((EX_GeographicDescription)geographicelement );
			}
			
		}
		
	}


	/**
	 * 시간적검색요소
	 * @param mapper
	 * @param extentseqn
	 * @param list
	 */
	private void InsertEX_TemporalExtent(WmoMetaMapper mapper,
			Integer extentseqn, List<EX_TemporalExtent> list) {
	
		if ( list == null ) return;

		for( EX_TemporalExtent temporalelement : list ){
			temporalelement.setExtentseqn(extentseqn);
			mapper.InsertEX_TemporalExtent(temporalelement);
	
		}
	}


	/**
	 * 키워드정보
	 * @param mapper
	 * @param dataidentificationseqn
	 * @param list
	 */
	private void InsertMD_Keywords(WmoMetaMapper mapper,
							Integer dataidentificationseqn,
							List<MD_Keywords> list) {
		
		if ( list == null ) return;

		for( MD_Keywords descriptivekeywords : list ){
			descriptivekeywords.setDataidentificationseqn(dataidentificationseqn);
			mapper.InsertMD_Keywords(descriptivekeywords);
	
			
			List thesaurusnameList = new ArrayList();
			thesaurusnameList.add(descriptivekeywords.getThesaurusname());
			
			InsertCI_Citation(mapper, 
					"keywordsseqn",
					descriptivekeywords.getKeywordsseqn(), 
					thesaurusnameList);
			
			
			
		}
		
	}


	/**
	 * 자료인용정보
	 * @param mapper
	 * @param dataidentificationseqn
	 * @param keywordsseqn
	 * @param conformanceresultseqn
	 * @param list
	 */
	private void InsertCI_Citation(WmoMetaMapper mapper,
			String property,
			Integer value,
			List<CI_Citation> list) {

		if ( list == null ) return;

		for( CI_Citation citation : list ){
			ReflectUtils.callSetter(citation, property, value);
			mapper.InsertCI_Citation(citation);
			
			InsertCI_Date(mapper, citation.getCitationseqn(), citation.getDates());
			
			InsertMD_Identifier(mapper, "citationseqn", citation.getCitationseqn(), citation.getIdentifier());
			
		}
	}
	
	
	
	
	/**
	 * 대상식별고유값
	 * @param mapper
	 * @param property
	 * @param value
	 * @param list
	 */
	private void InsertMD_Identifier(WmoMetaMapper mapper, String property,
			Integer value, List<MD_Identifier> list) {
		
		if ( list == null ) return;

		for( MD_Identifier identifier : list ){
			ReflectUtils.callSetter(identifier, property, value);
			mapper.InsertMD_Identifier(identifier);
			
			List tmpList = new ArrayList();
			tmpList.add(identifier.getAuthority());
			InsertCI_ResponsibleParty(mapper, "identifierseqn", identifier.getIdentifierseqn(), tmpList);
		}
	}


	/**
	 * 조회날짜
	 * @param mapper
	 * @param citationseqn
	 * @param list
	 */
	private void InsertCI_Date(WmoMetaMapper mapper, 
						Integer citationseqn,
						List<CI_Date> list) {
		
		if ( list == null ) return;

		for( CI_Date dates : list ){
			dates.setCitationseqn(citationseqn);
			mapper.InsertCI_Date(dates);
		}
	}


	/**
	 * 관련그룹
	 * @param mapper
	 * @param metadataseqn
	 * @param maintenanceinformationseqn
	 * @param dataidentificationseqn
	 * @param citationseqn
	 * @param identifierseqn
	 * @param distributorseqn
	 * @param list
	 */
	public void InsertCI_ResponsibleParty(WmoMetaMapper mapper,
						String property, 
						Integer value,
						List<CI_ResponsibleParty> list){
	
		if ( list == null ) return;
		
		for( CI_ResponsibleParty contact : list ){
			ReflectUtils.callSetter(contact, property, value);
			mapper.InsertCI_ResponsibleParty(contact);
			
			InsertCI_Contact(mapper, contact.getResponsiblepartyseqn(), contact.getContactinfo());
		}
		
	}
	
	


	/**
	 * 책임그룹주소
	 * @param mapper
	 * @param responsiblepartyseqn
	 * @param list
	 */
	public void InsertCI_Contact(WmoMetaMapper mapper, 
			Integer responsiblepartyseqn, 
			List<CI_Contact> list){
		
		if ( list == null ) return;

		for( CI_Contact contactinfo : list ){
			contactinfo.setResponsiblepartyseqn(responsiblepartyseqn);
			mapper.InsertCI_Contact(contactinfo);
		
			InsertCI_Telephone(mapper, contactinfo.getContactseqn(), contactinfo.getPhone());
			
			InsertCI_Address(mapper, contactinfo.getContactseqn(), contactinfo.getAddress());

			InsertCI_OnlineResource(mapper,
							"contactseqn",
							contactinfo.getContactseqn(),
							contactinfo.getOnlineresource());
		}
		
	}
	
	/**
	 * 주소
	 * @param mapper
	 * @param contactseqn
	 * @param extensioninformationseqn
	 * @param digitaltransferoptionsseqn
	 * @param list
	 */
	private void InsertCI_OnlineResource(WmoMetaMapper mapper,
								String property,
								Integer value,
								List<CI_OnlineResource> list) {

		if ( list == null ) return;

		for( CI_OnlineResource onlineresource : list ){
			ReflectUtils.callSetter(onlineresource, property, value);
			mapper.InsertCI_OnlineResource(onlineresource);
		}
	}


	/**
	 * 온라인정보
	 * @param mapper
	 * @param contactseqn
	 * @param list
	 */
	private void InsertCI_Address(WmoMetaMapper mapper, 
							Integer contactseqn,
							List<CI_Address> list) {

		if ( list == null ) return;

		for( CI_Address address : list ){
			address.setContactseqn(contactseqn);
			mapper.InsertCI_Address(address);
		}
	}


	/**
	 * 전화번호
	 * @param mapper
	 * @param contactseqn
	 * @param list
	 */
	public void InsertCI_Telephone(WmoMetaMapper mapper, 
			Integer contactseqn, 
			List<CI_Telephone> list){
	
		if ( list == null ) return;

		for( CI_Telephone phone : list ){
			phone.setContactseqn(contactseqn);
			mapper.InsertCI_Telephone(phone);
		}
	}
	
	/**
	 * 확장설명정보
	 * @param mapper
	 * @param metadataseqn
	 * @param list
	 */
	public void InsertMD_ExtensionInformation(WmoMetaMapper mapper, 
			Integer metadataseqn, 
			List<MD_ExtensionInformation> list){
		
		if ( list == null ) return;

		for( MD_ExtensionInformation metadataextensioninfo : list ){
			metadataextensioninfo.setMetadataseqn(metadataseqn);
			mapper.InsertMD_ExtensionInformation(metadataextensioninfo);
			
			InsertCI_OnlineResource(mapper, 
									"extensioninformationseqn",
									metadataextensioninfo.getExtensioninformationseqn(),
									metadataextensioninfo.getExtensiononlineresource() );
		}
		
	}

	/**
	 * 유지보수정보
	 * @param mapper
	 * @param metadataseqn
	 * @param dataidentificationseqn
	 * @param list
	 */
	public void InsertMD_MaintenanceInformation(WmoMetaMapper mapper,
								String property,
								Integer value,
								List<MD_MaintenanceInformation> list){
		
		if ( list == null ) return;

		for( MD_MaintenanceInformation metadatamaintenance : list ){
			
			ReflectUtils.callSetter(metadatamaintenance, property, value);
			mapper.InsertMD_MaintenanceInformation(metadatamaintenance);
			
			InsertCI_ResponsibleParty(mapper, 
							"maintenanceinformationseqn",
							metadatamaintenance.getMaintenanceinformationseqn(),
							metadatamaintenance.getContact() );
		}
		
	}
	

	
	
}
