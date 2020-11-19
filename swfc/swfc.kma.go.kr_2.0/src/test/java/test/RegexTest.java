package test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexTest {

	public static void main(String[] args) {
		String text = "ㄹㅇㅁㄹㅇㅁㄹㅇㄴㅁㄹㅇㄴㅁㄹㄴㅇㅁㄹㅇㄴㅁㄹㄹㄴㅇㅁㄹ http://swfc.kma.go.kr http://naver.com?test=fdafdafdaf";

		
		//text = "ㄹㅇㅁㄹㅇㅁㄹㅇㄴㅁㄹㅇㄴㅁㄹㄴㅇㅁㄹㅇㄴㅁㄹㄹㄴㅇㅁㄹ";
		
		// System.out.println(test.matches("(?i)(https?|ftp)://.*$"));
/*
		String regex = "\\(?\\b(http://|www[.])[-A-Za-z0-9+&amp;@#/%?=~_()|!:,.;]*[-A-Za-z0-9+&amp;@#/%=~_()|]";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(text);
		while (m.find()) {
			String urlStr = m.group();
			System.out.println("::"+urlStr + "::");
		}
		*/
		String firstTxt = text;
		if(text.indexOf("http://") != -1){
			firstTxt = text.substring(0, text.indexOf("http://"));
		}
		System.out.println(firstTxt);
	}
}
