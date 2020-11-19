package com.gaia3d.web.dto.wmo;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.DeserializationContext;
import org.codehaus.jackson.map.JsonDeserializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomJsonDateDeSerializer extends JsonDeserializer<Date> {

	private static final Logger logger = LoggerFactory.getLogger(CustomJsonDateDeSerializer.class);
			
	@Override
    public Date deserialize(JsonParser jp, DeserializationContext ctxt)
            throws IOException, JsonProcessingException {
        logger.debug("JSON deserialization for " + jp.getText());
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
        try {
			return dateFormat.parse(jp.getText());
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
    }

}
