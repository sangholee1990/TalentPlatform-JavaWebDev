package com.gaia3d.web.dto.wmo;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonToken;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.MappingJsonFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.schema.JsonSchema;


public class WmoJAXBEUtil {

	
	private static final String jsonFilePath= "C:\\student.json";
	private static final String filePath = "C:\\jsonTestFile.json";
	
	
	public static void main(String[] args) throws JsonParseException, IOException {
	
		jsonTest();
		
		
//		ObjectMapper mapper = new ObjectMapper();
//		JsonSchema jsonSchema = mapper.generateJsonSchema(MD_Metadata.class);
//		String schemaStr = jsonSchema.toString();
//		System.out.println(schemaStr);
//	//	bean2json();
		

	}

	public static void jsonTest() throws JsonParseException, IOException {

		
		ObjectMapper mapper = new ObjectMapper();

		try {
			File jsonFile = new File(filePath);

			MD_Metadata student = mapper.readValue(jsonFile, MD_Metadata.class);

			
			bean2json(student);
			System.out.println(student);

		} catch (JsonGenerationException e) {

			e.printStackTrace();

		} catch (JsonMappingException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		}
	}

	
	
	public static void bean2json(MD_Metadata student ) {
		ObjectMapper mapper = new ObjectMapper();

		try {

			File jsonFile = new File(jsonFilePath);

			mapper.writeValue(jsonFile, student);

			System.out.println(mapper.writeValueAsString(student));

		} catch (JsonGenerationException ex) {

			ex.printStackTrace();

		} catch (JsonMappingException ex) {

			ex.printStackTrace();

		} catch (IOException ex) {

			ex.printStackTrace();

		}
	}

	public static void bean2json() {

		MD_Metadata student = new MD_Metadata();

		student.setFileidentifier("000");
	
		EX_GeographicBoundingBox ex_GeographicBoundingBox = new EX_GeographicBoundingBox();
		ex_GeographicBoundingBox.setEastboundlongitude(10);
	
		EX_GeographicDescription ex_GeographicDescription = new EX_GeographicDescription();
		ex_GeographicDescription.setExtentseqn(1);
		
		
		List<EX_GeographicExtent> geographicelement = new ArrayList<EX_GeographicExtent>();
		geographicelement.add(ex_GeographicDescription);
		geographicelement.add(ex_GeographicBoundingBox);
		
		EX_Extent ex_Extent = new EX_Extent();
		ex_Extent.setGeographicelement(geographicelement);
		
		List<EX_Extent> extent = new ArrayList<EX_Extent>();;
		extent.add(ex_Extent);
		
		MD_DataIdentification md_DataIdentification = new MD_DataIdentification();
		md_DataIdentification.setExtent(extent);
		
		
		List<MD_DataIdentification> identificationinfos = new ArrayList<MD_DataIdentification>();
		identificationinfos.add(md_DataIdentification);
		
		
		student.setIdentificationinfo(identificationinfos );
		
		bean2json(student);
		
	}

	public static String bean2xml(MD_Metadata md_metadata ) {
		try {
			
			StringWriter stringWriter = new StringWriter();
			JAXBContext jaxbContext = JAXBContext.newInstance(MD_Metadata.class);
			Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
			
			jaxbMarshaller.setProperty(Marshaller.JAXB_SCHEMA_LOCATION, "http://www.isotc211.org/2005/gmd http://www.isotc211.org/2005/gmd/metadataEntity.xsd");
			
			// output pretty printed
			jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			jaxbMarshaller.marshal(md_metadata, stringWriter  );
			
			return stringWriter.toString();
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		return null;
	 
	}
	public static void bean2xml() {
		
		List s = new ArrayList();
		
		MD_Metadata md_metadata = new MD_Metadata();
		
		md_metadata.setFileidentifier("000");
	
		
		bean2xml(md_metadata);

	}

}
