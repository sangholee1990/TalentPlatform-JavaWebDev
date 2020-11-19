package egovframework.rte.swfc.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import egovframework.rte.swfc.util.ChartDataJsonSerializer;

@JsonSerialize(using=egovframework.rte.swfc.dto.SWPCAceMag.Serializer.class)
public class SWPCAceMag extends ChartData {
	Double bx;
	Double by;
	Double bz;
	Double bt;
	
	public Double getBx() {
		return bx;
	}
	public void setBx(Double bx) {
		this.bx = bx;
	}
	public Double getBy() {
		return by;
	}
	public void setBy(Double by) {
		this.by = by;
	}
	public Double getBz() {
		return bz;
	}
	public void setBz(Double bz) {
		this.bz = bz;
	}
	public Double getBt() {
		return bt;
	}
	public void setBt(Double bt) {
		this.bt = bt;
	}

	static class Serializer extends ChartDataJsonSerializer<SWPCAceMag> {
		@Override
		public void serializeBody(SWPCAceMag value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getBx());
			writeDouble(jgen, value.getBy());
			writeDouble(jgen, value.getBz());
			writeDouble(jgen, value.getBt());
		}
	}	
}
