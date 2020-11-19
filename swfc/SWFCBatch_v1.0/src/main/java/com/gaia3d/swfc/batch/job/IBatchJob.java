package com.gaia3d.swfc.batch.job;

import java.util.Calendar;

/**
 * Batch job interface
 * 
 */
public interface IBatchJob {
	
	/** 
	 * Execute Job 
	 */
	void run(Calendar calenar);
}
