package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SWPCGoesElectronFlux.Serializer.class)
public class SWPCGoesElectronFlux extends ChartData {
	Double p5;
	Double e8;
	Double e20;
	Double e40;
	
	public Double getP5() {
		return p5;
	}
	public void setP5(Double p5) {
		this.p5 = p5;
	}
	public Double getE8() {
		return e8;
	}
	public void setE8(Double e8) {
		this.e8 = e8;
	}
	public Double getE20() {
		return e20;
	}
	public void setE20(Double e20) {
		this.e20 = e20;
	}
	public Double getE40() {
		return e40;
	}
	public void setE40(Double e40) {
		this.e40 = e40;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SWPCGoesElectronFlux> {
		@Override
		public void serializeBody(SWPCGoesElectronFlux value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getE8());
			writeDouble(jgen, value.getE20());
			writeDouble(jgen, value.getE40());
		}
	}		
}
