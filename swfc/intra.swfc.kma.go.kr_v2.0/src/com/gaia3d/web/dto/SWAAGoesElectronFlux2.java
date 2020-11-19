package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SWAAGoesElectronFlux2.Serializer.class)
public class SWAAGoesElectronFlux2 extends ChartData {
	Double e_2MeV;
	
	public Double getE_2MeV() {
		return e_2MeV;
	}
	public void setE_2MeV(Double e_2MeV) {
		this.e_2MeV = e_2MeV;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SWAAGoesElectronFlux2> {
		@Override
		public void serializeBody(SWAAGoesElectronFlux2 value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getE_2MeV());
		}
	}		
}
