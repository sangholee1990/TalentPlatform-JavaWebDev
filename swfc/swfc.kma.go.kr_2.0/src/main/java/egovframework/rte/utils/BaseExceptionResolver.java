package egovframework.rte.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class BaseExceptionResolver implements HandlerExceptionResolver {
	private String view = null;

	public void setView(String view) {
		this.view = view;
	}

	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object arg2, Exception exception) {
		request.setAttribute("javax.servlet.error.exception", exception);
		return new ModelAndView(view);
	}
}
