#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "cxform.h"
#include <jni.h>

JNIEXPORT jdoubleArray JNICALL Java_com_gaia3d_swfc_batch_util_CXFormJNI_cxform (JNIEnv * env, jclass obj, jint yearJava, jint monthJava, jint dayJava, jint hourJava, jint minuteJava, jint secondJava, jdoubleArray inJava, jstring inSysJava, jstring outSysJava)
{
	jdoubleArray result;

	const char *inSys = (*env)->GetStringUTFChars(env, inSysJava, 0);
	const char *outSys = (*env)->GetStringUTFChars(env, outSysJava, 0);

	jdouble *in = (*env)->GetDoubleArrayElements(env, inJava, 0);

	int retVal;
	double out[3];
	double jd;
	int es;

	int year = (int)yearJava;
	int month = (int)monthJava;
	int day = (int)dayJava;
	int hour = (int)hourJava;
	int minute = (int)minuteJava;
	int second = (int)secondJava;

	jd = gregorian_calendar_to_jd(year, month, day, hour, minute, second);
	es = date2es(year, month, day, hour, minute, second);

	retVal = cxform(inSys, outSys, es, in, out);

	(*env)->ReleaseStringUTFChars(env, inSysJava, inSys);
	(*env)->ReleaseStringUTFChars(env, outSysJava, outSys);
	(*env)->ReleaseDoubleArrayElements(env, inJava, in, JNI_ABORT);

	if(retVal == 0)
	{
		result = (*env)->NewDoubleArray(env, 3);
		(*env)->SetDoubleArrayRegion(env, result, 0, 3, out);
		
	} else 
	{
		result = 0;
	}

	return result;
}