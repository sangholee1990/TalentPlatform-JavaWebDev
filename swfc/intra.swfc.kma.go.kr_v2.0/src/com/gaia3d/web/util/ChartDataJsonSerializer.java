package com.gaia3d.web.util;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

import com.gaia3d.web.dto.ChartData;

abstract public class ChartDataJsonSerializer<T extends ChartData> extends JsonSerializer<T> {

	abstract public void serializeBody(T value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException;

	@Override
	public void serialize(T value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
		jgen.writeStartArray();
		jgen.writeString(value.getTm());

		serializeBody(value, jgen, provider);

		jgen.writeEndArray();
	}

	public void writeInteger(JsonGenerator jgen, Integer value) throws JsonGenerationException, IOException {
		if (value == null)
			jgen.writeNull();
		else
			jgen.writeNumber((int) value);
	}
	
	public void writeDouble(JsonGenerator jgen, Double value) throws JsonGenerationException, IOException {
		if (value == null)
			jgen.writeNull();
		else
			jgen.writeNumber((double) value);
	}
}