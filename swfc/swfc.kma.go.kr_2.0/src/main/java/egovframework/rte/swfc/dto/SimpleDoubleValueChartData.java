package egovframework.rte.swfc.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import egovframework.rte.swfc.util.ChartDataJsonSerializer;

@JsonSerialize(using=egovframework.rte.swfc.dto.SimpleDoubleValueChartData.Serializer.class)
public class SimpleDoubleValueChartData extends ChartData {

	Double value;

	public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SimpleDoubleValueChartData> {
		@Override
		public void serializeBody(SimpleDoubleValueChartData value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getValue());
		}
	}	
}
