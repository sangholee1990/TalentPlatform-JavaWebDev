package com.gaia3d.web.dto.wmo;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomJsonDateSerializer extends JsonSerializer<Date> {

	private static final Logger logger = LoggerFactory.getLogger(CustomJsonDateSerializer.class);
			
	@Override
    public void serialize(Date aDate, JsonGenerator aJsonGenerator, SerializerProvider aSerializerProvider)
            throws IOException, JsonProcessingException {

		
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
        String dateString = dateFormat.format(aDate);
        
        logger.debug("DateSerializer" + dateString);
        aJsonGenerator.writeString(dateString);
    }

}
