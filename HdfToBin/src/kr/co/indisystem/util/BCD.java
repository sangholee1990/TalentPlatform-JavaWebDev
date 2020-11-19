package kr.co.indisystem.util;

/*
 * Copyright (C) 2002 Nick Galbreath.
 * All Rights Reserved.
 *
 * Orginally published in or based on works from the book
 *      Cryptography for Internet and Database Applications
 *      by Nick Galbreath
 *      Wiley Publishing, 2002
 *      ISBN 0-471-21029-3
 * See http://www.modp.com or http://www.wiley.com/compbooks/galbreath
 * for details.
 *
 * This software is provided as-is, without express or implied
 * warranty.  Permission to use, copy, modify, distribute or sell this
 * software, without fee, for any purpose and by any individual or
 * organization, is hereby granted, provided that the above copyright
 * notice, the original publication information and this paragraph
 * (i.e. this entire Java comment) appear in all copies.
 *
 */

/**
 * This class provides Binary Code Decimal encoding of a String of decimal
 * digits ("0" to "9").
 * 
 * <p>
 * For more information, see Chapter 6, pages 203-204, in <i>Cryptography for
 * Internet and Database Applications </i>
 * 
 * @author Nick Galbreath
 * @version 1.0.1
 * 
 */
public class BCD {
	private BCD() {
		// this is a pure 'static' class
	}

	/**
	 * Encodes a string containing just decimal digis 0-9 into a backed binary
	 * coded decimal array. For instance the decimal string "1234" will be
	 * encoded into two bytes 0x12 0x34.
	 * 
	 * @param s
	 *            The input string
	 * @return the BCD encoded binary array
	 */
	public static byte[] encode(String s) {
		int i = 0, j = 0;
		int max = s.length() - (s.length() % 2);
		byte[] buf = new byte[(s.length() + (s.length() % 2)) / 2];
		while (i < max) {
			buf[j++] = (byte) ((((s.charAt(i++) - '0') << 4) | (s.charAt(i++) - '0')));
		}
		if ((s.length() % 2) == 1) { // If odd, add pad char
			buf[j] = (byte) ((s.charAt(i++) - '0') << 4 | 0x0A);
		}
		return buf;
	}

	/**
	 * Decodes a BCD encoded array back into a String containing decimal digits.
	 * For instance 0x34 will be decoded as the string "34".
	 * 
	 * @param b
	 *            the input BCD encoded array
	 * @return The decoded, original string
	 * 
	 */
	public static String decode(byte[] b) {
		StringBuffer buf = new StringBuffer(b.length * 2);
		for (int i = 0; i < b.length; ++i) {
			buf.append((char) (((b[i] & 0xf0) >> 4) + '0'));
			if ((i != b.length) && ((b[i] & 0xf) != 0x0A)) // if not pad char
				buf.append((char) ((b[i] & 0x0f) + '0'));
		}
		return buf.toString();
	}
}
