package egovframework.rte.swfc.dto;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;


public class ChartSummaryDTO {
	public enum DataType {
		XRAY,
		PROTON,
		KP,
		MP
	}
	
	public enum Duration {
		NOW,
		H3,
		D1,
		D3,
		H6
	}
	
	DataType dataType;
	Duration duration;
	String tm;
	Double val;
	
	public DataType getDataType() {
		return dataType;
	}
	public void setDataType(DataType dataType) {
		this.dataType = dataType;
	}
	public Duration getDuration() {
		return duration;
	}
	public void setDuration(Duration duration) {
		this.duration = duration;
	}
	public String getTm() {
		return tm;
	}
	public void setTm(String tm) {
		this.tm = tm;
	}
	public Double getVal() {
		return val;
	}
	public void setVal(Double val) {
		this.val = val;
	}
	public Integer getCode() {
		return ChartSummaryDTO.getCode(dataType, val);
	}
	public String getGrade() {
		return ChartSummaryDTO.getGrade(dataType, val);
	}
	public String getGradeText() {
		return ChartSummaryDTO.getGradeText(dataType, val);
	}
	public String getGradeTextEng() {
		return ChartSummaryDTO.getGradeTextEng(dataType, val);
	}
	
	//5단계로구성됨
		//일반, 관심, 주의, 경계, 심각
		//낮음(0)과 일반(1)을 합쳐서 일반으로 계산하여 퍼센티지를 구한다.
		public Double getPercentage() {
			if(val != null) { 
				switch(dataType) {
				case XRAY:
					if(val >= 0.002)
						return getPercentage(0.002, 0.01, val)*0.2 + 0.8;
					if(val >= 0.001)
						return getPercentage(0.001, 0.002, val)*0.2 + 0.6;
					if(val >= 0.0001)
						return getPercentage(0.0001, 0.001, val)*0.2 + 0.4;
					if(val >= 0.00005)
						return getPercentage(0.00005, 0.0001, val)*0.2 + 0.2;
					else
						return getPercentage(0.0000001, 0.00005, val)*0.2;
				case PROTON:
					if(val >= 100000)
						return getPercentage(100000, 1000000, val)*0.2 + 0.8;
					if(val >= 10000)
						return getPercentage(10000, 100000, val)*0.2 + 0.6;
					if(val >= 1000)
						return getPercentage(1000, 10000, val)*0.2 + 0.4;
					if(val >= 100)
						return getPercentage(100, 1000, val)*0.2 + 0.2;
					else
						return getPercentage(0, 100, val)*0.2;
				case KP:
					if(val >= 9)
						return getPercentage(9, 10, val)*0.2 + 0.8;
					if(val >= 8)
						return getPercentage(8, 9, val)*0.2 + 0.6;
					if(val >= 7)
						return getPercentage(7, 8, val)*0.2 + 0.4;
					if(val >= 6)
						return getPercentage(6, 7, val)*0.2 + 0.2;
					else
						return getPercentage(0, 6, val)*0.2 ;
				case MP:
					if(val >= 8.6)
						return getPercentage(8.6, 18, val)*0.2;
					if(val >= 6.6)
						return getPercentage(6.6, 8.6, val)*0.2 + 0.2;
					if(val >= 5.6)
						return getPercentage(5.6, 6.6, val)*0.2 + 0.4;
					if(val >= 4.6)
						return getPercentage(4.6, 5.6, val)*0.2 + 0.6;
					else
						return getPercentage(4.0, 4.6, val)*0.2 + 0.8;
				}
			}
			return null;		
		}
	
	private double getPercentage(double min, double max, double value) {
		double percentage = (value - min) / (max - min);
		if(percentage > 1.0)
			return 1.0;
		if(percentage < 0.0)
			return 0.0;
		return percentage;
	}
	
	public static String getGradeText(DataType dataType, Double value) {
		Integer code = ChartSummaryDTO.getCode(dataType, value);
		if(code != null) {
			switch(code) {
			case 0:
				return "낮음";
			case 1:
				return "일반";
			case 2:
				return "관심";
			case 3:
				return "주의";
			case 4:
				return "경계";
			case 5:
				return "심각";
			}
		}
		return "데이터 없음";
	}
	
	public static String getGradeTextEng(DataType dataType, Double value) {
		Integer code = ChartSummaryDTO.getCode(dataType, value);
		if(code != null) {
			switch(code) {
			case 0:
				return "Low";
			case 1:
				return "Minor";
			case 2:
				return "Moderate";
			case 3:
				return "Strong";
			case 4:
				return "Severe";
			case 5:
				return "Extreme";
			}
		}
		return "no data";
	}	
	
	public static String getGrade(DataType dataType, Double value) {
		Integer code = ChartSummaryDTO.getCode(dataType, value);
		if(code != null) {
			switch(dataType) {
			case XRAY:
				return "R" + code;
			case PROTON:
				return "S" + code;
			case KP:
				return "G" + code;
			case MP:
				return "MP" + code;
			}
		}
		return "";
	}
	
	//6단계로 구성
		//0, 1, 2, 3, 4, 5
		public static Integer getCode(DataType dataType, Double value) {
			if(value != null) { 
				switch(dataType) {
				case XRAY:
					if(value >= 0.002)
						return 5;
					if(value >= 0.001)
						return 4;
					if(value >= 0.0001)
						return 3;
					if(value >= 0.00005)
						return 2;
					if(value >= 0.00001)
						return 1;
					else
						return 0;
				case PROTON:
					if(value >= Math.pow(10, 6))
						return 5;
					if(value >= Math.pow(10, 5))
						return 4;
					if(value >= Math.pow(10, 4))
						return 3;
					if(value >= Math.pow(10, 3))
						return 2;
					if(value >= Math.pow(10, 2))
						return 1;
					else
						return 0;
				case KP:
					if(value >= 9)
						return 5;
					if(value >= 8)
						return 4;
					if(value >= 7)
						return 3;
					if(value >= 6)
						return 2;
					if(value >= 5)
						return 1;
					else
						return 0;
				case MP:
					if(value >= 10.6)
						return 0;
					if(value >= 8.6)
						return 1;
					if(value >= 6.6)
						return 2;
					if(value >= 5.6)
						return 3;
					if(value >= 4.6)
						return 4;
					else
						return 5;			
				}
			}
			return null;		
		}
	
	static class CodeCompare implements Comparator<ChartSummaryDTO> {
		public int compare(ChartSummaryDTO arg0, ChartSummaryDTO arg1) {
			return arg0.getCode().compareTo(arg1.getCode());
		}
	}
	
	static class PercentageCompare implements Comparator<ChartSummaryDTO> {
		public int compare(ChartSummaryDTO arg0, ChartSummaryDTO arg1) {
			return arg0.getPercentage() .compareTo(arg1.getPercentage());
		}
	}

	
	public static ChartSummaryDTO MaxCodeFor기상위성운영(Iterable<ChartSummaryDTO> from, final Duration duration) {
		List<ChartSummaryDTO> filtered = new ArrayList<ChartSummaryDTO>();
		
		boolean isKp = false;
		for(ChartSummaryDTO chart : from) {
			if(chart.getDuration() == duration){
				if(chart.getDataType() == DataType.XRAY || chart.getDataType() == DataType.PROTON||chart.getDataType() == DataType.KP ||chart.getDataType() == DataType.MP) {
					if(chart.getDataType() == DataType.KP && chart.getDuration() == Duration.H3){
						isKp = true;
					}
					filtered.add(chart);
				}
			}
		}
		
		//만약 데이터 값에 KP3시간 자료가 존재하지 않으면 6시간 자료로 대체한다.
		/*
		if(!isKp){
			for(ChartSummaryDTO chart : from) {
				if(chart.getDataType() == DataType.KP && chart.getDuration() == Duration.H6){
					filtered.add(chart);
					break;
				}
			}
		}*/
		
		//추가 2014.07.02 황명진 추가
		ChartSummaryDTO source = null;
		ChartSummaryDTO target = null;
		if(filtered == null || filtered.size() == 0) return null;
		
		for(int i = 0 ; i < filtered.size(); i++){
			if(i == 0){
				source = (ChartSummaryDTO)filtered.get(i);
			}else{
				target = (ChartSummaryDTO)filtered.get(i);
				//System.out.println(source.getCode() + "==" + target.getCode());
				//System.out.println(source.toString());
				if(source.getCode() < target.getCode()){
					source = target;
				}
			}
		}
		return source;
		/*
		Collections.sort(filtered, new CodeCompare());
		if(filtered.size() > 0) 
			return filtered.get(0);
		return null;
		*/
	}
	
	public static ChartSummaryDTO MaxCodeFor극항로항공기상(Iterable<ChartSummaryDTO> from, final Duration duration) {
		
		boolean isKp = false;
		
		List<ChartSummaryDTO> filtered = new ArrayList<ChartSummaryDTO>();
		for(ChartSummaryDTO chart : from) {
			if(chart.getDuration() == duration){
				if(chart.getDataType() == DataType.XRAY || chart.getDataType() == DataType.PROTON||chart.getDataType() == DataType.KP) {
					if(chart.getDataType() == DataType.KP && chart.getDuration() == Duration.H3){
						isKp = true;
					}
					filtered.add(chart);
				}
			}
		}
		
		//만약 데이터 값에 KP3시간 자료가 존재하지 않으면 6시간 자료로 대체한다.
		/*
		if(!isKp){
			for(ChartSummaryDTO chart : from) {
				if(chart.getDataType() == DataType.KP && chart.getDuration() == Duration.H6){
					filtered.add(chart);
					break;
				}
			}
		}*/
		
		//추가 2014.07.02 황명진 추가
		ChartSummaryDTO source = null;
		ChartSummaryDTO target = null;
		if(filtered == null || filtered.size() == 0) return null;
		
		for(int i = 0 ; i < filtered.size(); i++){
			if(i == 0){
				source = (ChartSummaryDTO)filtered.get(i);
			}else{
				target = (ChartSummaryDTO)filtered.get(i);
				if(source.getCode() < target.getCode()){
					source = target;
				}
			}
		}
		return source;
		
		/*
		Collections.sort(filtered, new CodeCompare());
		if(filtered.size() > 0) 
			return filtered.get(0);
		return null;
		*/
	}
	
	public static ChartSummaryDTO MaxCodeFor전리권기상(Iterable<ChartSummaryDTO> from, final Duration duration) {
		boolean isKp = false;
		List<ChartSummaryDTO> filtered = new ArrayList<ChartSummaryDTO>();
		for(ChartSummaryDTO chart : from) {
			if(chart.getDuration() == duration){
				if(chart.getDataType() == DataType.XRAY || chart.getDataType() == DataType.KP) {
					if(chart.getDataType() == DataType.KP && chart.getDuration() == Duration.H3){
						isKp = true;
					}
					filtered.add(chart);
				}
			}
		}
		
		//만약 데이터 값에 KP3시간 자료가 존재하지 않으면 6시간 자료로 대체한다.
		/*
		if(!isKp){
			for(ChartSummaryDTO chart : from) {
				if(chart.getDataType() == DataType.KP && chart.getDuration() == Duration.H6){
					filtered.add(chart);
					break;
				}
			}
		}*/
		
		//추가 2014.07.02 황명진 추가
		ChartSummaryDTO source = null;
		ChartSummaryDTO target = null;
		if(filtered == null || filtered.size() == 0) return null;
		
		for(int i = 0 ; i < filtered.size(); i++){
			if(i == 0){
				source = (ChartSummaryDTO)filtered.get(i);
			}else{
				target = (ChartSummaryDTO)filtered.get(i);
				if(source.getCode() < target.getCode()){
					source = target;
				}
			}
		}
		return source;
		
		/*
		Collections.sort(filtered, new CodeCompare());
		if(filtered.size() > 0) 
			return filtered.get(0);
		return null;
		 */
	}		
	
	public static ChartSummaryDTO 기상위성운영최대비율(Iterable<ChartSummaryDTO> from, final Duration duration) {
		List<ChartSummaryDTO> filtered = new ArrayList<ChartSummaryDTO>();
		for(ChartSummaryDTO chart : from) {
			if(chart.getDuration() == duration){
				if(chart.getDataType() == DataType.XRAY || chart.getDataType() == DataType.PROTON||chart.getDataType() == DataType.KP ||chart.getDataType() == DataType.MP) {
					filtered.add(chart);
				}
			}
		}
		Collections.sort(filtered, new PercentageCompare());
		if(filtered.size() > 0) 
			return filtered.get(0);
		return null;
	}
	
	public static ChartSummaryDTO 극항로항공기상최대비율(Iterable<ChartSummaryDTO> from, final Duration duration) {
		List<ChartSummaryDTO> filtered = new ArrayList<ChartSummaryDTO>();
		for(ChartSummaryDTO chart : from) {
			if(chart.getDuration() == duration){
				if(chart.getDataType() == DataType.XRAY || chart.getDataType() == DataType.PROTON||chart.getDataType() == DataType.KP) {
					filtered.add(chart);
				}
			}
		}
		Collections.sort(filtered, new PercentageCompare());
		if(filtered.size() > 0) 
			return filtered.get(0);
		return null;
	}
	
	public static ChartSummaryDTO 전리권기상최대비율(Iterable<ChartSummaryDTO> from, final Duration duration) {
		List<ChartSummaryDTO> filtered = new ArrayList<ChartSummaryDTO>();
		for(ChartSummaryDTO chart : from) {
			if(chart.getDuration() == duration){
				if(chart.getDataType() == DataType.XRAY || chart.getDataType() == DataType.KP) {
					filtered.add(chart);
				}
			}
		}
		Collections.sort(filtered, new PercentageCompare());
		if(filtered.size() > 0) 
			return filtered.get(0);
		return null;
	}		
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("DataType=");
		builder.append(dataType);
		builder.append(", Duration=");
		builder.append(duration);
		builder.append(", TM=");
		builder.append(tm);
		builder.append(", Value=");
		builder.append(val);
		builder.append(getCode());
		return builder.toString();
	}
}
