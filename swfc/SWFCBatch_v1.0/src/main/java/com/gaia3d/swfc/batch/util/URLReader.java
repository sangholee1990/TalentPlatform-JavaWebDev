package com.gaia3d.swfc.batch.util;

import static com.google.common.base.Preconditions.checkNotNull;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;

import com.google.common.base.Charsets;
import com.google.common.io.ByteSource;
import com.google.common.io.CharStreams;
import com.google.common.io.LineProcessor;

public final class URLReader {
	private URLReader() {
	}

	public static <T> T readLines(URL url, LineProcessor<T> callback) throws IOException {
		return URLReader.readLines(url, Charsets.ISO_8859_1, callback);
	}
	
	public static <T> T readLines(URL url, Charset charset, LineProcessor<T> callback) throws IOException {
		return CharStreams.readLines(new UrlByteSource(url).asCharSource(charset), callback);
	}

	private static final class UrlByteSource extends ByteSource {

		private final URL url;

		private UrlByteSource(URL url) {
			this.url = checkNotNull(url);
		}

		@Override
		public InputStream openStream() throws IOException {
			URLConnection connection = url.openConnection();
			connection.setConnectTimeout(60000);
			connection.setReadTimeout(60000);
			return connection.getInputStream();
		}

		@Override
		public String toString() {
			return "Resources.asByteSource(" + url + ")";
		}
	}
}
