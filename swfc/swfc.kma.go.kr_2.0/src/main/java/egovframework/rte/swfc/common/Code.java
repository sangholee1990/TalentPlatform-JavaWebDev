package egovframework.rte.swfc.common;

import java.util.ArrayList;
import java.util.List;

public class Code {

	public static enum LANG {
		ko,en
	}
	
	public static enum AlertStaticImage {
		xflux_5m, goes13_proton, kp_index, geomag_B
	}
	
	public static enum CartType {
		PROTON_FLUX, XRAY_FLUX, KP_INDEX_SWPC, MAGNETOPAUSE_RADIUS, ELECTRON_FLUX, DST_INDEX_KYOTO, ACE_MAG, ACE_SOLARWIND_DENS, ACE_SOLARWIND_SPD, ACE_SOLARWIND_TEMP
	}
	
	/**
	 * ROLE_ADMIN 관리자
	 * ROLE_USER 
	 * ROLE_SPECIFIC_USER 특정 수요자
	 * ROLE_ANONYMOUS 일반
	 * 
	 * @author Administrator
	 *
	 */
	public enum Role {
		
		ROLE_ADMIN(3), ROLE_USER(2), ROLE_SPECIFIC_USER(1), ROLE_ANONYMOUS(0);
		
		private final int level;
		
		private Role(int level){
			this.level = level;
		}
		
		public int getLevel() {
	        return level;
	    }
	}
	
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
		
		public static List<IMAGE_CODE> availableValues() {
			List<IMAGE_CODE> codes = new ArrayList<IMAGE_CODE>();
			codes.add(SDO__01001);
			codes.add(SDO__01002);
			codes.add(SDO__01003);
			codes.add(SDO__01004);
			codes.add(SDO__01005);
			codes.add(SDO__01006);

			codes.add(SOHO_01001);
			codes.add(SOHO_01002);
			codes.add(STA__01001);
			codes.add(STA__01002);
			codes.add(STB__01001);
			codes.add(STB__01002);
			return codes;
		}
	}
}
