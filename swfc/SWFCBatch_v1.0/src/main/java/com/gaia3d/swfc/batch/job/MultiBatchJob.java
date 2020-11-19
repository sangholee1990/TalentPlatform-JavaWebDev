package com.gaia3d.swfc.batch.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class MultiBatchJob implements IBatchJob {

	static final Logger logger = LogManager.getLogger(MultiBatchJob.class.getName());

	List<IBatchJob> jobs = new ArrayList<IBatchJob>();

	@Override
	public void run(final Calendar calenar) {
		for (IBatchJob job : jobs) {
			try {
				job.run(calenar);
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
		}
	}

	public void addJob(IBatchJob job) {
		jobs.add(job);
	}
}
