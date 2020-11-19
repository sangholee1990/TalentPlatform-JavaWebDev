package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SWPCGoesProtonFlux.Serializer.class)
public class SWPCGoesProtonFlux extends ChartData {

	Double p1;
	Double p5;
	Double p10;
	Double p30;
	Double p50;
	Double p100;
	Double avg_p5;
	Double max_p5;
	
	public Double getP1() {
		return p1;
	}
	public void setP1(Double p1) {
		this.p1 = p1;
	}
	public Double getP5() {
		return p5;
	}
	public void setP5(Double p5) {
		this.p5 = p5;
	}
	public Double getP10() {
		return p10;
	}
	public void setP10(Double p10) {
		this.p10 = p10;
	}
	public Double getP30() {
		return p30;
	}
	public void setP30(Double p30) {
		this.p30 = p30;
	}
	public Double getP50() {
		return p50;
	}
	public void setP50(Double p50) {
		this.p50 = p50;
	}
	public Double getP100() {
		return p100;
	}
	public void setP100(Double p100) {
		this.p100 = p100;
	}
	public Double getAvg_p5() {
		return avg_p5;
	}
	public void setAvg_p5(Double avg_p5) {
		this.avg_p5 = avg_p5;
	}
	public Double getMax_p5() {
		return max_p5;
	}
	public void setMax_p5(Double max_p5) {
		this.max_p5 = max_p5;
	}



	static class Serializer extends ChartDataJsonSerializer<SWPCGoesProtonFlux> {
		@Override
		public void serializeBody(SWPCGoesProtonFlux value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getP1());
			writeDouble(jgen, value.getP5());
			writeDouble(jgen, value.getP10());
			writeDouble(jgen, value.getP30());
			writeDouble(jgen, value.getP50());
			writeDouble(jgen, value.getP100());
		}
	}		
}