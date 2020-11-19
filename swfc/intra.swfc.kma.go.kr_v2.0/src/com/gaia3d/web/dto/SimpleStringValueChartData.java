package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SimpleStringValueChartData.Serializer.class)
public class SimpleStringValueChartData extends ChartData {

	String value;

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SimpleStringValueChartData> {
		@Override
		public void serializeBody(SimpleStringValueChartData value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			jgen.writeString(value.getValue());
		}
	}	
}
