package com.gaia3d.web.code;

import java.util.Iterator;

import com.google.common.base.Predicate;
import com.google.common.collect.Iterators;

public enum IMAGE_CODE {
	SDO__01001("SDO","AIA 0131"),
	SDO__01002("SDO","AIA 0171"),
	SDO__01003("SDO","AIA 0193"),
	SDO__01004("SDO","AIA 0211"),
	SDO__01005("SDO","AIA 0304"),
	SDO__01006("SDO","AIA 1600"),
	SDO__01007("SDO","AIA 0335"),
	SDO__01008("SDO","AIA 1700"),
	SDO__01009("SDO","AIA 4500"),
	SDO__01010("SDO","AIA 0094"),
	SOHO_01001("SOHO","LASCO C2"),
	SOHO_01002("SOHO","LASCO C3"),
	STA__01001("STEREO-A","COR1"),
	STA__01002("STEREO-A","COR2"),
	STB__01001("STEREO-B","COR1"),
	STB__01002("STEREO-B","COR2");
	
	private IMAGE_CODE(final String group, final String text) {
		this.group = group;
		this.text = text;
	}
	private String group;
	private String text;
	
	public String getGroup() {
		return this.group;
	}

	public String getText() {
		return this.text;
	}
	
	public static Iterator<IMAGE_CODE> availableValues() {
		return Iterators.filter(Iterators.forArray(IMAGE_CODE.values()), new Predicate<IMAGE_CODE>() {
			@Override
			public boolean apply(IMAGE_CODE imageCode) {
				switch (imageCode) {
				case SDO__01001:
				case SDO__01002:
				case SDO__01003:
				case SDO__01004:
				case SDO__01005:
				case SDO__01006:

				case SOHO_01001:
				case SOHO_01002:
				case STA__01001:
				case STA__01002:
				case STB__01001:
				case STB__01002:
					return true;
				default:
					return false;
				}
			}
		});
	}
}
