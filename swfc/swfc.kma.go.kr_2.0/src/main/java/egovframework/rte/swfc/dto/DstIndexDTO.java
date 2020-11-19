package egovframework.rte.swfc.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import egovframework.rte.swfc.util.ChartDataJsonSerializer;

@JsonSerialize(using=egovframework.rte.swfc.dto.DstIndexDTO.Serializer.class)
public class DstIndexDTO extends ChartData {

	Integer kyoto;
	Double khu;
	
	public Integer getKyoto() {
		return kyoto;
	}
	public void setKyoto(Integer kyoto) {
		this.kyoto = kyoto;
	}
	public Double getKhu() {
		return khu;
	}
	public void setKhu(Double khu) {
		this.khu = khu;
	}
	
	static class Serializer extends ChartDataJsonSerializer<DstIndexDTO> {
		@Override
		public void serializeBody(DstIndexDTO value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeInteger(jgen, value.getKyoto());
			writeDouble(jgen, value.getKhu());
		}
	}	

}
