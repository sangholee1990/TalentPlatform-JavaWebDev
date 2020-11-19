package com.gaia3d.web.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.dto.wmo.CI_Address;
import com.gaia3d.web.dto.wmo.CI_Citation;
import com.gaia3d.web.dto.wmo.CI_Contact;
import com.gaia3d.web.dto.wmo.CI_Date;
import com.gaia3d.web.dto.wmo.CI_OnlineResource;
import com.gaia3d.web.dto.wmo.CI_ResponsibleParty;
import com.gaia3d.web.dto.wmo.CI_Telephone;
import com.gaia3d.web.dto.wmo.DQ_ConformanceResult;
import com.gaia3d.web.dto.wmo.DQ_DataQuality;
import com.gaia3d.web.dto.wmo.DQ_DomainConsistency;
import com.gaia3d.web.dto.wmo.DQ_Scope;
import com.gaia3d.web.dto.wmo.EX_Extent;
import com.gaia3d.web.dto.wmo.EX_GeographicBoundingBox;
import com.gaia3d.web.dto.wmo.EX_GeographicDescription;
import com.gaia3d.web.dto.wmo.EX_TemporalExtent;
import com.gaia3d.web.dto.wmo.MD_Constraints;
import com.gaia3d.web.dto.wmo.MD_DataIdentification;
import com.gaia3d.web.dto.wmo.MD_DigitalTransferOptions;
import com.gaia3d.web.dto.wmo.MD_Distribution;
import com.gaia3d.web.dto.wmo.MD_Distributor;
import com.gaia3d.web.dto.wmo.MD_ExtensionInformation;
import com.gaia3d.web.dto.wmo.MD_Format;
import com.gaia3d.web.dto.wmo.MD_Identifier;
import com.gaia3d.web.dto.wmo.MD_Keywords;
import com.gaia3d.web.dto.wmo.MD_MaintenanceInformation;
import com.gaia3d.web.dto.wmo.MD_Metadata;


public interface WmoMetaMapper {

	public List<Object> SelectMany(Object parameter);

	public int Count(Object parameter);
	
	public MD_Metadata SelectOne(Object parameter);
	
	public List<CI_ResponsibleParty>  getCI_ResponsiblePartyList(Object parameter);

	public int Insert(MD_Metadata md_Metadata);

	public int InsertCI_ResponsibleParty(CI_ResponsibleParty contact);

	public void InsertCI_Contact(CI_Contact contactinfo);

	public void InsertCI_Telephone(CI_Telephone phone);

	public void InsertCI_OnlineResource(CI_OnlineResource onlineresource);

	public void InsertCI_Address(CI_Address address);

	public void InsertMD_ExtensionInformation(
			MD_ExtensionInformation metadataextensioninfo);

	public void InsertMD_MaintenanceInformation(
			MD_MaintenanceInformation metadatamaintenance);

	public void InsertMD_DataIdentification(
			MD_DataIdentification identificationinfo);

	public void InsertCI_Citation(CI_Citation citation);

	public void InsertCI_Date(CI_Date dates);

	public void InsertMD_Identifier(MD_Identifier identifier);

	public void InsertMD_Keywords(MD_Keywords descriptivekeywords);

	public void InsertEX_Extent(EX_Extent extent);

	public void InsertEX_TemporalExtent(EX_TemporalExtent temporalelement);

	public void InsertEX_GeographicBoundingBox(
			EX_GeographicBoundingBox geographicelement);

	public void InsertEX_GeographicDescription(
			EX_GeographicDescription geographicelement);

	public void InsertMD_Constraints(MD_Constraints resourceconstraints);

	public void InsertMD_Distribution(MD_Distribution distributioninfo);

	public void InsertMD_Format(MD_Format distributionformat);

	public void InsertMD_Distributor(MD_Distributor formatdistributor);

	public void InsertMD_DigitalTransferOptions(
			MD_DigitalTransferOptions distributortransferoptions);

	public void InsertDQ_DataQuality(DQ_DataQuality dataqualityinfo);

	public void InsertDQ_Scope(DQ_Scope scope);

	public void InsertDQ_DomainConsistency(DQ_DomainConsistency report);

	public void InsertDQ_ConformanceResult(DQ_ConformanceResult tmp);

	public void Delete(Object obj);

	public void DeleteMD_MaintenanceInformation(Object obj);

	public void DeleteCI_ResponsibleParty(Object obj);

	public void DeleteCI_OnlineResource(Object obj);

	public void DelteCI_Address(Object obj);

	public void DelteCI_Telephone(Object obj);

	public void DeleteCI_Contact(Object obj);

	public void DeleteDQ_DataQuality(Object obj);

	public void DeleteMD_Distribution(Object obj);

	public void DeleteMD_DataIdentification(Object obj);

	public void DeleteMD_Constraints(Object obj);

	public void DeleteMD_ExtensionInformation(Object obj);

	public void DeleteDQ_Scope(Object obj);

	public void DeleteLI_Lineage(Object obj);

	public void DeleteMD_Identifier(Object obj);

	public void DeleteDQ_Element(Object obj);

	public void DeleteDQ_Result(Object obj);

	public void DeleteCI_Citation(Object obj);

	public void DeleteCI_Date(Object obj);

	public void DeleteMD_Format(Object obj);

	public void DeleteMD_Distributor(Object obj);

	public void DeleteMD_DigitalTransferOptions(Object obj);

	public void DeleteMD_Keywords(Object obj);

	public void DeleteEX_Extent(Object obj);

	public void DeleteEX_GeographicExtent(Object obj);

	public void DeleteEX_TemporalExtent(Object obj);

	public void Update(MD_Metadata md_Metadata);


}
