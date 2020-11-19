package kr.co.indisystem.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.net.URLDecoder;
import java.text.NumberFormat;
import java.util.StringTokenizer;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * 문자열 처리 class
 * @author <a href='gate7711@nowonplay.com'><b>Kim Jin Hyug</b></a>
 * @vaersion StringUtil.java 2009. 1. 11
 */
public class StringUtil extends StringUtils {
	/**
	 * int 숫자변환
	 * @param str
	 * @return
	 */
    public static int parseInt(String str) {
    	try {
    		if(str==null){
    			return 0;
    		}
    		return Integer.parseInt(str);
    	} catch (NumberFormatException e) {
    		return 0;
    	}
    }
    
    /**
	 * int 숫자변환
	 * @param str
	 * @return
	 */
    public static int parseInt(Object obj) {
    	try {
    		if(obj==null){
    			return 0;
    		}
    		return Integer.parseInt(String.valueOf(obj));
    	} catch (NumberFormatException e) {
    		return 0;
    	}
    }

	/**
	 * long 숫자변환
	 * @param str
	 * @return
	 */
    public static long parseLong(String str) {
    	try {
    		if(str==null){
    			return 0L;
    		}
    		return Long.parseLong(str);
    	} catch (NumberFormatException e) {
    		return 0L;
    	}
    }
    
    /**
	 * long 숫자변환
	 * @param str
	 * @return
	 */
    public static long parseLong(Object obj) {
    	try {
    		if(obj==null){
    			return 0L;
    		}
    		return Long.parseLong(String.valueOf(obj));
    	} catch (NumberFormatException e) {
    		return 0L;
    	}
    }
    
	/**
	 * double 숫자변환
	 * @param str
	 * @return
	 */
    public static double parseDouble(String str) {
    	try {
    		if(str==null){
    			return 0.0d;
    		}
    		return Double.parseDouble(str);
    	} catch (NumberFormatException e) {
    		return 0.0d;
    	}
    }

	/**
	 * float 숫자변환
	 * @param str
	 * @return
	 */
    public static float parseFloat(String str) {
    	try {
    		if(str==null){
    			return 0.0f;
    		}
    		return Float.parseFloat(str);
    	} catch (NumberFormatException e) {
    		return 0.0f;
    	}
    }
    
    
    
    /**
     * int 형을 문자형으로 변환
     * @param src
     * @return
     */
    public static String toString(int src){
		  String rst="";
		  try{
			  rst=String.valueOf(src);
		  }catch(Exception e){
			  return "";
		  }
		  return rst;
	 }
	 
    /**
     * long 형을 문자열으로 변환
	 * @param src
	 * @return
	 */
	public static String toString(long src){
		 String rst="";
		 try{
			 rst=String.valueOf(src);
		 }catch(Exception e){
			 return "";
		 }
		 return rst;
	 }
	
	
	 /**
	  * double 형을 문자형으로 변환
	 * @param src
	 * @return
	 */
	public static String toString(double src){
		 String rst="";
		 try{
			 rst=String.valueOf(src);
		 }catch(Exception e){
			 return "";
		 }
		 return rst;
	 }
	
	
	 /**
	  * float형을 문자형으로 변환
	 * @param src
	 * @return
	 */
	public static String toString(float src){
		 String rst="";
		 try{
			 rst=String.valueOf(src);
		 }catch(Exception e){
			 return "";
		 }
		 return rst;
	 }
    
    /**
     * BASE64 Encoder
     *
     * @param str
     * @return
     * @throws java.io.IOException
     */
    public static String base64Encode(String str) {
    	String result = "";
    	if (str != null && !"".equals(str)) {
	    	sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
	    	byte[] b1 = str.getBytes();
	    	result = encoder.encode(b1);
    	}
    	return result;
    }
    
    
    public static String URLEncode(String src){
    	try {
			return URLEncoder.encode(src, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return src;
		}
    }
    
    public static String URLDecode(String src){
    	try {
			return URLDecoder.decode(src, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return src;
		}
    }
    
    /**
     * BASE64 Decoder
     *
     * @param str
     * @return
     * @throws java.io.IOException
     */
    
    public static String base64Decode(String str) {
      String result = "";
      try {
      		if (str != null && !"".equals(str)) {
      			sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
      			byte[] b1 = decoder.decodeBuffer(str);
      			result = new String(b1);
      		}
      } catch (IOException ex) {
    	  System.out.println("decode io exception");
    	  //ex.printStackTrace();
      }
      return result;
    }
    
    /**
     * 스트링내의 임의의 문자열을 새로운 문자열로 대치하는 메소드
     *
     * @param source    스트링
     * @param before    바꾸고자하는 문자열
     * @param after     바뀌는 문자열
     * @return 변경된 문자열
     */
    public static String change(String source, String before, String after) {
        int i = 0;
        int j = 0;
        if(source==null){
        	return "";
        }
        StringBuffer sb = new StringBuffer();

        while ((j = source.indexOf(before, i)) >= 0) {
            sb.append(source.substring(i, j));
            sb.append(after);
            i = j + before.length();
        }

        sb.append(source.substring(i));
        return sb.toString();
    }
    
    
    public static String getStringNoTag(String src,int len,String tail){
    	String rst=getStringNoTag( src, len);
    	return rst+=tail;
    }
    
    /**
     * Tag 제거 후 자르기
     * @param src
     * @param len
     * @return
     */
    public static String getStringNoTag(String src,int len){
        float rstLen=0;
        String rst="";
        char b[]=src.toCharArray();
        int i=0;
        float tmplen=0;
        String tmpRst="";
        boolean tmpb=true;
        for (i = 0; i < b.length; i++) {
            if (b[i] == '<') { /* < 시작하는거 체크*/
                tmplen=rstLen;
                tmpRst=rst;
                tmpb=false;
            } else if (b[i] == '>') { /* >끝나는거 체크*/
                rstLen=tmplen;
                rst=tmpRst;
                tmpb=true;
            } else if ((int) src.charAt(i) >255) { /* 한글로 시작하는 부분 체크 */
                rstLen += 1.21;
                rst+=src.substring(i,i+1);

            } else if ((byte)b[i] >= 97 && (byte)b[i] <= 122) { /* 영문(소문자)으로 시작하는 부분 체크 */
                rstLen += 0.71;
                rst+=src.substring(i,i+1);
            } else if ((byte)b[i] >= 65 && (byte)b[i] <= 90) { /* 영문(대문자)으로 시작하는 부분 체크 */
                rstLen += 0.82;
                rst+=src.substring(i,i+1);
            } else if ((byte)b[i] >= 48 && (byte)b[i] <= 57) { /* 숫자 인지 체크 */
                rstLen += 0.61;
                rst+=src.substring(i,i+1);
            } else { /* 특수 문자 기호값 */
                rstLen += 0.71;
                rst+=src.substring(i,i+1);
            }
            if ((int)rstLen >= len) {
                if(tmpb){
                    rst+="..";
                    break;
                }
            }
        }
        return rst;
    }
    
    public static String addBr(String src){
    	return change(src, "\n", "<BR>");
    }
    
    /**
	 * 문자열에 있는 태그를 제거하여 반환한다.
	 * @param str
	 * @return
	 */
	public static String removeTagScript(String str) {
		return str.replaceAll("\\<.*?\\>", "");
	}
	
	
	
	/**
	 * 스트링 잘라내기
	 * @param s 잘라낼 문자열
	 * @param len 잘라낼 길이
	 * @param tail 잘라낸 문자열 뒤에 붙일 문자열
	 * @return
	 */
	public static String cutString(String s, int len, String tail) {

		if (s == null) {
			return null;
		}

		int srcLen = realLength(s);
		if (srcLen < len) {
			return s;
		}

		String tmpTail = tail;
		if (tail == null) {
			tmpTail = "";
		}

		int tailLen = realLength(tmpTail);
		if (tailLen > len) {
			return "";
		}

		char a;
		int i = 0;
		int realLen = 0;
		for (i = 0; i < len - tailLen && realLen < len - tailLen; i++) {
			a = s.charAt(i);

			if ((a & 0xFF00) == 0) {
				realLen += 1;
			}
			else {
			realLen += 2;
			}
		}

		while (realLength(s.substring(0, i)) > len - tailLen) {
			i--;
		}

		return s.substring(0, i) + tmpTail;
	}

	/**
	 *문자열의 바이트를 반환한다.
	 * @param s
	 * @return
	 */
	public static int realLength(String s) {
		return s.getBytes().length;
	}

	/**
	 * 메일 유효성 검증
	 * @param email
	 * @return
	 */
	public static boolean isEmail(String email) {
	     if (email == null) {
	    	 return false;
	     }

	     boolean b = Pattern.matches(
	         "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+",
	         email.trim());

	     return b;
	 }


	/**
	 * 핸드폰 번호 Validate
	 * @param mobile
	 * @return
	 */
	public static boolean isMobile(String mobile) {
	     if (mobile == null) {
	    	 return false;
	     }

	     boolean b = Pattern.matches(
	         "01[016789]\\-\\d{2,4}\\-\\d{3,4}",
	         mobile.trim());

	     return b;
	 }
	
	
	
     /**
      * 
      * 특수 문자 와 영문 한글 체크 해서 길이 를 가지고 온다.
     * @param src
     * @param len
     * @param tail
     * @return
     */
    public static String getString(String src,int len, String tail){
     	if(src==null){
     		return "";
     	}
         float rstLen=0;
         String rst="";
         char c[]=src.toCharArray();
         int i=0;
         for (i = 0; i < c.length; i++) {
             if (c[i] == 60) { /* < 시작하는거 체크*/
                 rstLen += 1;
                 rst+=src.substring(i,i+1);
             } else if ((byte)c[i] == 62) { /* >끝나는거 체크*/
                 rstLen += 1;
                 rst+=src.substring(i,i+1);
             } else if ((int) src.charAt(i) >255) { /* 한글로 시작하는 부분 체크 */
                 rstLen += 1.21;
                 rst+=src.substring(i,i+1);
             } else if ((byte)c[i] >= 97 && (byte)c[i] <= 122) { /* 영문(소문자)으로 시작하는 부분 체크 */
                 rstLen += 0.71;
                 rst+=src.substring(i,i+1);
             } else if ((byte)c[i] >= 65 && (byte)c[i] <= 90) { /* 영문(대문자)으로 시작하는 부분 체크 */
                 rstLen += 0.82;
                 rst+=src.substring(i,i+1);
             } else if ((byte)c[i] >= 48 && (byte)c[i] <= 57) { /* 숫자 인지 체크 */
                 rstLen += 0.61;
                 rst+=src.substring(i,i+1);
             } else { /* 특수 문자 기호값 */
                 rstLen += 0.71;
                 rst+=src.substring(i,i+1);
             }
             // System.out.println((int) src.charAt(i));
             if (rstLen >= len) {
                 rst+=tail;
                 break;
             }
         }
         return rst;
     }
     
     
     /**
      * 특수 문자 와 영문 한글 체크 해서 길이 를 가지고 온다.
     * @param src
     * @return
     */
    public static int getStringLength(String src){
     	if(src==null){
     		return 0;
     	}
         float rstLen=0;
         String rst="";
         char c[]=src.toCharArray();
         int i=0;
         for (i = 0; i < c.length; i++) {
             if (c[i] == 60) { /* < 시작하는거 체크*/
                 rstLen += 1;
                 rst+=src.substring(i,i+1);
             } else if ((byte)c[i] == 62) { /* >끝나는거 체크*/
                 rstLen += 1;
                 rst+=src.substring(i,i+1);
             } else if ((int) src.charAt(i) >255) { /* 한글로 시작하는 부분 체크 */
                 rstLen += 1.21;
                 rst+=src.substring(i,i+1);
             } else if ((byte)c[i] >= 97 && (byte)c[i] <= 122) { /* 영문(소문자)으로 시작하는 부분 체크 */
                 rstLen += 0.71;
                 rst+=src.substring(i,i+1);
             } else if ((byte)c[i] >= 65 && (byte)c[i] <= 90) { /* 영문(대문자)으로 시작하는 부분 체크 */
                 rstLen += 0.82;
                 rst+=src.substring(i,i+1);
             } else if ((byte)c[i] >= 48 && (byte)c[i] <= 57) { /* 숫자 인지 체크 */
                 rstLen += 0.61;
                 rst+=src.substring(i,i+1);
             } else { /* 특수 문자 기호값 */
                 rstLen += 0.71;
                 rst+=src.substring(i,i+1);
             }
         }
         return Math.round(rstLen);
     }
     
     /**
      * 문자열이 서로 같은지 확인한다.
     * @param a
     * @param b
     * @return
     */
    public static boolean isEquals(String a,String b){
 		if(a==null)
 			return false;
 		if(b==null)
 			return false;
 		return a.equals(b);
 	}
 	
 	
    /**
     * 같으문자면 지정한 문자열(success) 반환
     * 문자가 서로 같지 않으면 문자열(fail) 반환
     * @param a
     * @param b
     * @param success
     * @param fail
     * @return
     */
    public static String isEquals(String a,String b,String success,String fail){
 		if(StringUtil.isEquals(a, b)){
 			return success;
 		}else{
 			return fail;
 		}
 	}
    
    
 	/**
 	 * a , b 문자가 서로 같으면 selected 를 반환.
 	 * @param a
 	 * @param b
 	 * @return
 	 */
 	public static String isSelected(String a,String b){
 		return StringUtil.isEquals(a, b, "selected", "");
 	}
 	
 	public static String isSelected(String a,String b, String c){
 		return StringUtil.isEquals(a, b, "selected", c);
 	}
 	
 	/**
 	 * a , b 문자가 서로 같으면 checked 를 반환.
 	 * @param a
 	 * @param b
 	 * @return
 	 */
 	public static String isChecked(String a,String b){
 		return StringUtil.isEquals(a, b, "checked", "");
 	}
 	
    /**
     *  3자리마다 콤바찍기
     * @param n
     * @return
     */
    public static String format(long n)
    {
        NumberFormat nf = NumberFormat.getNumberInstance();
        try {
            return nf.format(n);
        } catch(Exception e) {
        	return "0";
        }
    }
    
    /**
     *  3자리마다 콤바찍기
     * @param n
     * @return
     */
    public static String format(String n) {
    	n=isEmpty(n,"0");
    	NumberFormat nf = NumberFormat.getNumberInstance();
    	long l=parseLong(n);
    	try {
    		return nf.format(l);
    	} catch (Exception e) {
    		return "0";
    	}
   }
    
    /**
     * chkStr 문자열이 Null이거나 빈문자열이면 rst를 반환한다.
     * @param chkStr
     * @param rst
     * @return
     */
    public static String isEmpty(String chkStr,String rst){
    	if(chkStr==null) return rst;
    	if(isEmpty(chkStr)){
    		return rst;
    	}else{
    		return chkStr;
    	}
    }
    public static String isEmpty(Object chkObj,String rst){
    	if(chkObj==null) return rst;
    	String chkStr=(String)chkObj;
    	if(isEmpty(chkStr)){
    		return rst;
    	}else{
    		return chkStr;
    	}
    }
    
    /**
     * chkStr 문자열이 Null이거나 빈문자열이면 rst를 반환하고 빈문자열이 아니면 dst를 반환한다.
     * @param chkStr null 값인지 체크할 문자열
     * @param rst null일경우 반환될 문자열
     * @param dst 변경된 문자열
     * @return
     */
    public static String isEmpty(String chkStr, String rst, String dst){
    	if(isEmpty(chkStr)){
    		return rst;
    	}else{
    		return dst;
    	}
    }
    
    /**
     * str.lastIndexOf(div)
     * @param str
     * @param div
     * @return
     */
    public static String lastWord(String str, String div)
    {
        if(isEmpty(str) || isEmpty(div))
            return "";
        int idx = str.lastIndexOf(div);
        if(idx == -1)
        {
            return "";
        } else
        {
            String s = str.substring(idx + 1);
            return s;
        }
    }

    public static String lastWord(String str)
    { 
    	return lastWord(str, ".");
    }
    
    public static String firstWord(String str,String div){
    	if(isEmpty(str) || isEmpty(div))
            return "";
        int idx = str.indexOf(div);
        if(idx == -1)
        {
            return "";
        } else
        {
            String s = str.substring(idx + 1);
            return s;
        }
    }
    
    public static String lastWordLeft(String str, String div)
    {
        if(isEmpty(str) || isEmpty(div))
            return "";
        int idx = str.lastIndexOf(div);
        if(idx == -1)
        {
            return "";
        } else
        {
            String s = str.substring(0,idx);
            return s;
        }
    }
    
    public static String firstWordLeft(String str, String div)
    {
        if(isEmpty(str) || isEmpty(div))
            return "";
        int idx = str.indexOf(div);
        if(idx == -1)
        {
            return "";
        } else
        {
            String s = str.substring(0,idx);
            return s;
        }
    }

   /**
    *     배열에 해당 문자열이 있는지 확인   있으면 True를 반환	
	 * @param src
	 * @param dest
	 * @return
	 */
    public static boolean matchArray(String src[],String dest){
       for(int i=0;i<src.length;i++){
           if(src[i]!=null){
               if (src[i].equalsIgnoreCase(dest)) {
                   return true;
               }
           }
       }
       return false;
   }
    
    /**
     * PHP의 explode 기능의 메소드
     * @param : 비교할 문자열
     * @param : delim Token
     * @return : 배열
     */
    public static String[] explode(String src,String delim){
    	if(src==null || src.length()==0) return new String[0];
    	if(delim.length()>=2){
    		src=change(src, delim, "\27");
    		delim="\27";
    	}
        StringTokenizer stk=new StringTokenizer(src,delim);
        int size=stk.countTokens();
        String rst[]=new String[size];
        int i=0;
        while(stk.hasMoreTokens()){
            rst[i]=stk.nextToken();
            i++;
        }
        return rst;
    }
    /**
     * PHP의 implode 기능의 메소드
     * @param : 배열
     * @param :  삽입될 토큰
     * @return : 문자열
     */
    public static String implode(String src[],String delim){
    	if(src==null || src.length==0) return "";
        int size=src.length;
        String rst="";
        for(int i=0;i<size;i++){
            if(i!=size-1){
                rst += src[i] + delim;
            }else{
                rst+=src[i];
            }
        }
        return rst;
    }
    
    /**
     * 문자열 자르기
     * @param str
     * @param st
     * @param end
     * @return
     */
    public static String substring(String str,int st,int end){
    	if(str==null) return "";
    	if(str.length()<end){
    		return StringUtils.substring(str,st);
    	}
    	return StringUtils.substring(str, st, end);
    }
    
    /**
     * 문자열 자르기
     * @param str
     * @param st
     * @return
     */
    public static String substring(String str,int st){
    	if(str==null) return "";
    	if(str.length()<st){
    		return "";
    	}
    	return StringUtils.substring(str, st);
    }
    
    /**
	 * {@link BASE64Encoder}를 이용한 문자열 암호화
	 * @param str : 암호화 처리할 문자열
	 * @return String : 암호화 된 문자열
	 */
	public static String getBASE64EncoderString(String str) {
		if(isEmpty(str)) return "";
		BASE64Encoder encoder = new BASE64Encoder();
		byte[] bStr = str.getBytes();
		String encodeStr = encoder.encode(bStr);
		return encodeStr;
	}

	/**
	 * {@link BASE64Decoder}를 이용하여 암호화 문자열 복구 시킴
	 * @param secureStr : 암호화 문자열
	 * @return String : 복구된 문자열
	 * @throws IOException
	 */
	public static String getBASE64DecoderString(String secureStr) throws IOException{
		if(isEmpty(secureStr)) return "";
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] dbpasswd = decoder.decodeBuffer(secureStr);
	    String recovered = new String( dbpasswd );
	    return recovered;
	}  
	
	/**
	 * javascript에 들어가는 문자열을 변환해준다.
	 * @param src
	 * @return
	 */
	public static String toJS(String src){
		if(isEmpty(src)) return "";
		return 
			src.replace("\\", "\\\\")
				.replace("\'", "\\\'")
				.replace("\"", "")
				.replace("\r\n", "\\n")
				.replace("\n", "\\n");
	}
	
	/**
	 * source문자열에서 '\n'(개행)문자를 '<br>'로 치환
	 * 부가적으로 transSpaceNbsp, transTabNbsp 메서드 호출
	 * @param source
	 * @return String
	 */
	public static String replaceEnterBr(String str) {
		if(str == null) return str;
		if(str != null && "".equals(str)) return str;
		String returnString= str;
		String[] argsCode =  { "\n"};
		String[] argsHtml =  { "<br />" };
		for(int i =0; i <argsCode.length; i++) {
	        returnString = returnString.replaceAll("(?i)" + argsCode[i] ,argsHtml[i] );
	    }
		return returnString;
	}
}