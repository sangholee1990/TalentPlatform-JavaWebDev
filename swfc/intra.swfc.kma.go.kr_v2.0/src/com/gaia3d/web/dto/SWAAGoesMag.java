package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SWAAGoesMag.Serializer.class)
public class SWAAGoesMag extends ChartData {
	Double goes13_hp;
	Double p_he;
	Double p_hn;
	Double p_t_fld;
	Double goes15_hp;
	Double s_he;
	Double s_hn;
	Double s_t_fld;
	
	public Double getGOES13_HP() {
		return goes13_hp;
	}
	public void setGOES13_HP(Double goes13_hp) {
		this.goes13_hp = goes13_hp;
	}
	public Double getP_HE() {
		return p_he;
	}
	public void setP_HE(Double p_he) {
		this.p_he = p_he;
	}
	public Double getP_HN() {
		return p_hn;
	}
	public void setP_HN(Double p_hn) {
		this.p_hn = p_hn;
	}
	public Double getP_T_FLD() {
		return p_t_fld;
	}
	public void setP_T_FLD(Double p_t_fld) {
		this.p_t_fld = p_t_fld;
	}
	
	public Double getGOES15_HP() {
		return goes15_hp;
	}
	public void setGOES15_HP(Double goes15_hp) {
		this.goes15_hp = goes15_hp;
	}
	public Double getS_HE() {
		return s_he;
	}
	public void setS_HE(Double s_he) {
		this.s_he = s_he;
	}
	public Double getS_HN() {
		return s_hn;
	}
	public void setS_HN(Double s_hn) {
		this.s_hn = s_hn;
	}
	public Double getS_T_FLD() {
		return s_t_fld;
	}
	public void setS_T_FLD(Double s_t_fld) {
		this.s_t_fld = s_t_fld;
	}
	
	static class Serializer extends ChartDataJsonSerializer<SWAAGoesMag> {
		@Override
		public void serializeBody(SWAAGoesMag value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getGOES13_HP());
			writeDouble(jgen, value.getGOES15_HP());
		}
	}		
}
