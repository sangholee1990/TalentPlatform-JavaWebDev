/*
 * @(#)BaseModel.java 1.0 2012/08/01
 * 
 * COPYRIGHT (C) 2008 GALLOPSYS CO., LTD.
 * ALL RIGHTS RESERVED.
 */
package egovframework.rte.swfc;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * 기본 모델 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2012/08/01 
 */
public class BaseModel extends HashMap<String, Object> {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;
    
    /**
     * 날짜 변환자를 나타내는 상수
     */
    public static final String FORMATTER_DATE = "date";
    
    /**
     * 날짜 분석 형식
     */
    public static final String PARSE_PATTERN_DATE = "yyyyMMdd";
    
    /**
     * 날짜 변환 형식
     */
    public static final String FORMAT_PATTERN_DATE = "yyyy-MM-dd";
    
    /**
     * 논리값을 반환한다.
     * 
     * @param key 키
     * @return 논리값
     */
    public boolean getBoolean(String key) {
        return getBoolean(key, false);
    }
    
    /**
     * 논리값을 반환한다.
     * 
     * @param key 키
     * @param defaultValue 디폴트 논리값
     * @return 논리값
     */
    public boolean getBoolean(String key, boolean defaultValue) {
        Object value = get(key);
        
        if (value instanceof Object) {
            return value.toString().equalsIgnoreCase("true");
        }
        
        return defaultValue;
    }
    
    /**
     * 논리값 배열을 반환한다.
     * 
     * @param key 키
     * @return 논리값 배열
     */
    public boolean[] getBooleanArray(String key) {
        Object value = get(key);
        
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;
            
            boolean[] booleanValues = new boolean[values.length];
            
            for (int i = 0; i < values.length; i++) {
                booleanValues[i] = values[i].toString().equalsIgnoreCase("true");
            }
            
            return booleanValues;
        }
        
        if (value instanceof Object) {
            return new boolean[] { value.toString().equalsIgnoreCase("true") };
        }
        
        return new boolean[0];
    }
    
    /**
     * 정수값을 반환한다.
     * 
     * @param key 키
     * @return 정수값
     */
    public int getInt(String key) {
        return getInt(key, 0);
    }
    
    /**
     * 정수값을 반환한다.
     * 
     * @param key 키
     * @param defaultValue 디폴트 정수값
     * @return 정수값
     */
    public int getInt(String key, int defaultValue) {
        Object value = get(key);
        
        if (value instanceof Object) {
            return Integer.parseInt(value.toString());
        }
        
        return defaultValue;
    }
    
    /**
     * 정수값 배열을 반환한다.
     * 
     * @param key 키
     * @return 정수값 배열
     */
    public int[] getIntArray(String key) {
        Object value = get(key);
        
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;
            
            int[] intValues = new int[values.length];
            
            for (int i = 0; i < values.length; i++) {
                intValues[i] = Integer.parseInt(values[i].toString());
            }
            
            return intValues;
        }
        
        if (value instanceof Object) {
            return new int[] { Integer.parseInt(value.toString()) };
        }
        
        return new int[0];
    }
    
    /**
     * 정수값을 반환한다.
     * 
     * @param key 키
     * @return 정수값
     */
    public long getLong(String key) {
        return getLong(key, 0L);
    }
    
    /**
     * 정수값을 반환한다.
     * 
     * @param key 키
     * @param defaultValue 디폴트 정수값
     * @return 정수값
     */
    public long getLong(String key, long defaultValue) {
        Object value = get(key);
        
        if (value instanceof Object) {
            return Long.parseLong(value.toString());
        }
        
        return defaultValue;
    }
    
    /**
     * 정수값 배열을 반환한다.
     * 
     * @param key 키
     * @return 정수값 배열
     */
    public long[] getLongArray(String key) {
        Object value = get(key);
        
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;
            
            long[] longValues = new long[values.length];
            
            for (int i = 0; i < values.length; i++) {
                longValues[i] = Long.parseLong(values[i].toString());
            }
            
            return longValues;
        }
        
        if (value instanceof Object) {
            return new long[] { Long.parseLong(value.toString()) };
        }
        
        return new long[0];
    }
    
    /**
     * 실수값을 반환한다.
     * 
     * @param key 키
     * @return 실수값
     */
    public float getFloat(String key) {
        return getFloat(key, 0F);
    }
    
    /**
     * 실수값을 반환한다.
     * 
     * @param key 키
     * @param defaultValue 디폴트 실수값
     * @return 실수값
     */
    public float getFloat(String key, float defaultValue) {
        Object value = get(key);
        
        if (value instanceof Object) {
            return Float.parseFloat(value.toString());
        }
        
        return defaultValue;
    }
    
    /**
     * 실수값 배열을 반환한다.
     * 
     * @param key 키
     * @return 실수값 배열
     */
    public float[] getFloatArray(String key) {
        Object value = get(key);
        
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;
            
            float[] floatValues = new float[values.length];
            
            for (int i = 0; i < values.length; i++) {
                floatValues[i] = Float.parseFloat(values[i].toString());
            }
            
            return floatValues;
        }
        
        if (value instanceof Object) {
            return new float[] { Float.parseFloat(value.toString()) };
        }
        
        return new float[0];
    }
    
    /**
     * 실수값을 반환한다.
     * 
     * @param key 키
     * @return 실수값
     */
    public double getDouble(String key) {
        return getDouble(key, 0D);
    }
    
    /**
     * 실수값을 반환한다.
     * 
     * @param key 키
     * @param defaultValue 디폴트 실수값
     * @return 실수값
     */
    public double getDouble(String key, double defaultValue) {
        Object value = get(key);
        
        if (value instanceof Object) {
            return Double.parseDouble(value.toString());
        }
        
        return defaultValue;
    }
    
    /**
     * 실수값 배열을 반환한다.
     * 
     * @param key 키
     * @return 실수값 배열
     */
    public double[] getDoubleArray(String key) {
        Object value = get(key);
        
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;
            
            double[] doubleValues = new double[values.length];
            
            for (int i = 0; i < values.length; i++) {
                doubleValues[i] = Double.parseDouble(values[i].toString());
            }
            
            return doubleValues;
        }
        
        if (value instanceof Object) {
            return new double[] { Double.parseDouble(value.toString()) };
        }
        
        return new double[0];
    }
    
    /**
     * 문자열을 반환한다.
     * 
     * @param key 키
     * @return 문자열
     */
    public String getString(String key) {
        return getString(key, "");
    }
    
    /**
     * 문자열을 반환한다.
     * 
     * @param key 키
     * @param defaultValue 디폴트 문자열
     * @return 문자열
     */
    public String getString(String key, String defaultValue) {
        Object value = get(key);
        
        if (value instanceof Object) {
            return value.toString();
        }
        
        return defaultValue;
    }
    
    /**
     * 문자열 배열을 반환한다.
     * 
     * @param key 키
     * @return 문자열 배열
     */
    public String[] getStringArray(String key) {
        Object value = get(key);
        
        if (value instanceof Object[]) {
            Object[] values = (Object[]) value;
            
            String[] stringValues = new String[values.length];
            
            for (int i = 0; i < values.length; i++) {
                stringValues[i] = values[i].toString();
            }
            
            return stringValues;
        }
        
        if (value instanceof Object) {
            return new String[] { value.toString() };
        }
        
        return new String[0];
    }
    
    /**
     * 값을 변환한다.
     * 
     * @param key 키
     * @param formatter 변환자
     * @param parsePattern 분석형식
     * @param formatPattern 변환형식
     * @return 기존값
     */
    public Object formatValue(String key, String formatter, String parsePattern, String formatPattern) {
        Object value = get(key);
        
        if (value instanceof Object) {
            if (FORMATTER_DATE.equals(formatter)) {
                return put(key, formatDate(value.toString(), parsePattern, formatPattern));
            }
        }

        return value;
    }
    
    /**
     * 날짜를 변환한다.
     * 
     * @param sourceText 문자열
     * @param parsePattern 분석형식
     * @param formatPattern 변환형식
     * @return 변환된 문자열
     */
    private String formatDate(String sourceText, String parsePattern, String formatPattern) {
        SimpleDateFormat formatter = new SimpleDateFormat();
        
        if (parsePattern != null) {
            formatter.applyPattern(parsePattern);
        }
        else {
            formatter.applyPattern(PARSE_PATTERN_DATE);
        }

        Date date = formatter.parse(sourceText, new ParsePosition(0));

        if (formatPattern != null) {
            formatter.applyPattern(formatPattern);
        }
        else {
            formatter.applyPattern(FORMAT_PATTERN_DATE);
        }
        
        return formatter.format(date);
    }
}