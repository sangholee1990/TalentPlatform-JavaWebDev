package com.gaia3d.web.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.gaia3d.web.util.ChartDataJsonSerializer;

@JsonSerialize(using=com.gaia3d.web.dto.SWPCGoesXray1M.Serializer.class)
public class SWPCGoesXray1M extends ChartData {

	Double short_flux;
	Double long_flux;
	Double avg_long_flux;
	Double max_long_flux;
	
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
	public Double getAvg_long_flux() {
		return avg_long_flux;
	}
	public void setAvg_long_flux(Double avg_long_flux) {
		this.avg_long_flux = avg_long_flux;
	}
	public Double getMax_long_flux() {
		return max_long_flux;
	}
	public void setMax_long_flux(Double max_long_flux) {
		this.max_long_flux = max_long_flux;
	}


	static class Serializer extends ChartDataJsonSerializer<SWPCGoesXray1M> {
		@Override
		public void serializeBody(SWPCGoesXray1M value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getShort_flux());
			writeDouble(jgen, value.getLong_flux());
		}
	}	
}
