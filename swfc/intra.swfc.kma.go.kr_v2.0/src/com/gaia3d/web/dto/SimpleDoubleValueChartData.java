package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SimpleDoubleValueChartData.Serializer.class)
public class SimpleDoubleValueChartData extends ChartData {

	Double value;
	Double avg_value;
	Double max_value;
	
	public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}
	
	public Double getAvg_value() {
		return avg_value;
	}

	public void setAvg_value(Double avg_value) {
		this.avg_value = avg_value;
	}

	public Double getMax_value() {
		return max_value;
	}

	public void setMax_value(Double max_value) {
		this.max_value = max_value;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SimpleDoubleValueChartData> {
		@Override
		public void serializeBody(SimpleDoubleValueChartData value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getValue());
		}
	}	
}
