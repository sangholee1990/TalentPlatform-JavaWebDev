package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SWAAGoesElectronFlux.Serializer.class)
public class SWAAGoesElectronFlux extends ChartData {
	Double e_40keV;
	
	public Double getE_40keV() {
		return e_40keV;
	}
	public void setE_40keV(Double e_40keV) {
		this.e_40keV = e_40keV;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SWAAGoesElectronFlux> {
		@Override
		public void serializeBody(SWAAGoesElectronFlux value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getE_40keV());
		}
	}		
}
