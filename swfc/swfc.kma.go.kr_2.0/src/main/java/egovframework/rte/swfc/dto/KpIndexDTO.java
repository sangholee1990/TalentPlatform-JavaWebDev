package egovframework.rte.swfc.dto;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import egovframework.rte.swfc.util.ChartDataJsonSerializer;

@JsonSerialize(using=egovframework.rte.swfc.dto.KpIndexDTO.Serializer.class)
public class KpIndexDTO extends ChartData {

	Double swpc;
	Double khu;
	
	public Double getSwpc() {
		return swpc;
	}
	public void setSwpc(Double swpc) {
		this.swpc = swpc;
	}
	public Double getKhu() {
		return khu;
	}
	public void setKhu(Double khu) {
		this.khu = khu;
	}
	
	static class Serializer extends ChartDataJsonSerializer<KpIndexDTO> {
		@Override
		public void serializeBody(KpIndexDTO value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
			writeDouble(jgen, value.getSwpc());
			writeDouble(jgen, value.getKhu());
		}
	}	
}
