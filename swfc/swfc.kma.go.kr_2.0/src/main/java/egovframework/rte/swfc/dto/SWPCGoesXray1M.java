package egovframework.rte.swfc.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import egovframework.rte.swfc.util.ChartDataJsonSerializer;


@JsonSerialize(using=egovframework.rte.swfc.dto.SWPCGoesXray1M.Serializer.class)
public class SWPCGoesXray1M extends ChartData {

	Double short_flux;
	Double long_flux;
	
	public Double getShort_flux() {
		return short_flux;
	}
	public void setShort_flux(Double short_flux) {
		this.short_flux = short_flux;
	}
	public Double getLong_flux() {
		return long_flux;
	}
	public void setLong_flux(Double long_flux) {
		this.long_flux = long_flux;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SWPCGoesXray1M> {
		@Override
		public void serializeBody(SWPCGoesXray1M value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getShort_flux());
			writeDouble(jgen, value.getLong_flux());
		}
	}	
}
