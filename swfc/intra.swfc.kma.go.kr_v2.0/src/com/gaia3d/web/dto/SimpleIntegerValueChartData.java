package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SimpleIntegerValueChartData.Serializer.class)
public class SimpleIntegerValueChartData extends ChartData {

	Integer value;
	Double avg_value;
	Integer max_value;
	
	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
	
	public Double getAvg_value() {
		return avg_value;
	}

	public void setAvg_value(Double avg_value) {
		this.avg_value = avg_value;
	}

	public Integer getMax_value() {
		return max_value;
	}

	public void setMax_value(Integer max_value) {
		this.max_value = max_value;
	}

	static class Serializer extends ChartDataJsonSerializer<SimpleIntegerValueChartData> {
		@Override
		public void serializeBody(SimpleIntegerValueChartData value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeInteger(jgen, value.getValue());
		}
	}	
}
