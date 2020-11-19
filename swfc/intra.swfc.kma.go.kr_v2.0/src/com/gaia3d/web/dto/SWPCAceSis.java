package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

@JsonSerialize(using=com.gaia3d.web.dto.SWPCAceSis.CustomSerializer.class)
public class SWPCAceSis extends ChartData {

	int integ_10_s;
	double integ_10;
	int intteg_30_s;
	double integ_30;
	
	public int getInteg_10_s() {
		return integ_10_s;
	}
	public void setInteg_10_s(int integ_10_s) {
		this.integ_10_s = integ_10_s;
	}
	public double getInteg_10() {
		return integ_10;
	}
	public void setInteg_10(double integ_10) {
		this.integ_10 = integ_10;
	}
	public int getIntteg_30_s() {
		return intteg_30_s;
	}
	public void setIntteg_30_s(int intteg_30_s) {
		this.intteg_30_s = intteg_30_s;
	}
	public double getInteg_30() {
		return integ_30;
	}
	public void setInteg_30(double integ_30) {
		this.integ_30 = integ_30;
	}
	
	class CustomSerializer extends JsonSerializer<SWPCAceSis> {
		@Override
		public void serialize(SWPCAceSis arg0, JsonGenerator arg1, SerializerProvider arg2) throws IOException, JsonProcessingException {
			// TODO Auto-generated method stub
			
		}
	}
}
