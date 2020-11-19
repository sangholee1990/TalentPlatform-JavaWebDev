package egovframework.rte.swfc.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import egovframework.rte.swfc.util.ChartDataJsonSerializer;

@JsonSerialize(using=egovframework.rte.swfc.dto.SimpleIntegerValueChartData.Serializer.class)
public class SimpleIntegerValueChartData extends ChartData {

	Integer value;

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SimpleIntegerValueChartData> {
		@Override
		public void serializeBody(SimpleIntegerValueChartData value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeInteger(jgen, value.getValue());
		}
	}	
}
