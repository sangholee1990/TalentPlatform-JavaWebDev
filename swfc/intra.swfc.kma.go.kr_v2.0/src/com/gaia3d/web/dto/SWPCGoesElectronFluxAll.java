package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SWPCGoesElectronFluxAll.Serializer.class)
public class SWPCGoesElectronFluxAll extends ChartData {
	Double goes13_p5;
	Double goes13_e8;
	Double goes13_e20;
	Double goes13_e40;
	Double goes15_p5;
	Double goes15_e8;
	Double goes15_e20;
	Double goes15_e40;
	
	
	public Double getGoes13_p5() {
		return goes13_p5;
	}

	public void setGoes13_p5(Double goes13_p5) {
		this.goes13_p5 = goes13_p5;
	}

	public Double getGoes13_e8() {
		return goes13_e8;
	}

	public void setGoes13_e8(Double goes13_e8) {
		this.goes13_e8 = goes13_e8;
	}
	public Double getGoes13_e20() {
		return goes13_e20;
	}
	public void setGoes13_e20(Double goes13_e20) {
		this.goes13_e20 = goes13_e20;
	}
	public Double getGoes13_e40() {
		return goes13_e40;
	}
	public void setGoes13_e40(Double goes13_e40) {
		this.goes13_e40 = goes13_e40;
	}

	public Double getGoes15_p5() {
		return goes15_p5;
	}

	public void setGoes15_p5(Double goes15_p5) {
		this.goes15_p5 = goes15_p5;
	}
	public Double getGoes15_e8() {
		return goes15_e8;
	}

	public void setGoes15_e8(Double goes15_e8) {
		this.goes15_e8 = goes15_e8;
	}

	public Double getGoes15_e20() {
		return goes15_e20;
	}




	public void setGoes15_e20(Double goes15_e20) {
		this.goes15_e20 = goes15_e20;
	}




	public Double getGoes15_e40() {
		return goes15_e40;
	}




	public void setGoes15_e40(Double goes15_e40) {
		this.goes15_e40 = goes15_e40;
	}


	


	static class Serializer extends ChartDataJsonSerializer<SWPCGoesElectronFluxAll> {
		@Override
		public void serializeBody(SWPCGoesElectronFluxAll value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getGoes13_e8());
			writeDouble(jgen, value.getGoes13_e20());
			writeDouble(jgen, value.getGoes13_e40());
			writeDouble(jgen, value.getGoes15_e8());
			writeDouble(jgen, value.getGoes15_e20());
			writeDouble(jgen, value.getGoes15_e40());
		}
	}		
}
