package com.gaia3d.web.util;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class StringServletResponseWrapper extends HttpServletResponseWrapper {
	  protected CharArrayWriter charWriter;

	  protected PrintWriter writer;

	  protected boolean getOutputStreamCalled;

	  protected boolean getWriterCalled;

	  public StringServletResponseWrapper(HttpServletResponse response) {
	    super(response);

	    charWriter = new CharArrayWriter();
	  }

	  public ServletOutputStream getOutputStream() throws IOException {
	    if (getWriterCalled) {
	      throw new IllegalStateException("getWriter already called");
	    }

	    getOutputStreamCalled = true;
	    return super.getOutputStream();
	  }

	  public PrintWriter getWriter() throws IOException {
	    if (writer != null) {
	      return writer;
	    }
	    if (getOutputStreamCalled) {
	      throw new IllegalStateException("getOutputStream already called");
	    }
	    getWriterCalled = true;
	    writer = new PrintWriter(charWriter);
	    return writer;
	  }

	  public String toString() {
	    String s = null;

	    if (writer != null) {
	      s = charWriter.toString();
	    }
	    return s;
	  }
}