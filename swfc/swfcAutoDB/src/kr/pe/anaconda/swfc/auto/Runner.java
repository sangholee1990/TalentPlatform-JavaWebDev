package kr.pe.anaconda.swfc.auto;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Runner {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		ApplicationContext ctx = new ClassPathXmlApplicationContext("config/task-context.xml");

	}

}
