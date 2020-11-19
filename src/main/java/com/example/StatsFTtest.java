package com.example;

import org.apache.commons.math3.distribution.AbstractRealDistribution;
import org.apache.commons.math3.distribution.FDistribution;
import org.apache.commons.math3.distribution.TDistribution;
import org.apache.commons.math3.exception.NotStrictlyPositiveException;
import org.apache.commons.math3.exception.OutOfRangeException;
import org.apache.commons.math3.special.Beta;
import org.apache.commons.math3.stat.descriptive.SummaryStatistics;
import org.apache.commons.math3.stat.descriptive.moment.Variance;
import org.apache.commons.math3.stat.inference.OneWayAnova;
import org.apache.commons.math3.stat.inference.TestUtils;
import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;
import org.springframework.util.Assert;
import smile.stat.hypothesis.FTest;
import smile.stat.hypothesis.TTest;
import ucar.units.Test;

import java.text.Format;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Math.abs;
import static java.lang.Math.exp;

public class StatsFTtest {

    public static void main(String[] args) {


        // 테스트 설정
        double[] refer = new double[]{-0.007, -0.007, -0.007, -0.008, -0.008};
        double[] sample = new double[]{-0.005, -0.006, -0.006, -0.006, -0.007};

        /*
        double[] diff = new double[refer.length];

        for (int i = 0; i < refer.length; i++) {
            diff[i] = refer[i] - sample[i];
        }
        */

        SummaryStatistics referStat = new SummaryStatistics();
        for (double val : refer) {
            referStat.addValue(val);
        }

        SummaryStatistics sampleStat = new SummaryStatistics();
        for (double val : sample) {
            sampleStat.addValue(val);
        }


//        List<double[]> threeClasses = new ArrayList();
//        threeClasses.add(refer);
//        threeClasses.add(sample);
//
//        OneWayAnova testStatistic = new OneWayAnova();
//
//        Assert.assertEquals("ANOVA F-value",  24.67361709460624,
//                testStatistic.anovaFValue(threeClasses), 1E-12);

        /***********************************************
         * 임시 F 테스트
         ***********************************************/
        // F값

        double dd = TestUtils.pairedT(refer, sample);
        System.out.println("dd : " + dd);

        double dd2 = TestUtils.pairedTTest(refer, sample);
        System.out.println("dd2 : " + dd2);

//        System.out.println(FTest.test(refer, sample));

        FTest aa = FTest.test(refer, sample);

        System.out.println(aa.df1);
        System.out.println(aa.df2);
        System.out.println(aa.pvalue);
        System.out.println(aa.f);
        System.out.println(aa);


        // 자유도
        // double df = lengthA + lengthB - 2;

        smile.stat.distribution.FDistribution td = new smile.stat.distribution.FDistribution(aa.df1, aa.df2);


        // double td0025 = td.inverseCumulativeProbability(0.025);
        // double td0975 = td.inverseCumulativeProbability(0.975);
        System.out.println(td.p(0.025));
        System.out.println(td.p(0.975));

        // td.mean() - (td.sd() / Math.sqrt(td.length())) * td.quantile(0.025)

        System.out.println(td.quantile(0.025));
        System.out.println(td.quantile(0.975));
        System.out.println(td.cdf(0.025));
        System.out.println(td.cdf(0.975));


        org.apache.commons.math3.distribution.FDistribution tdd = new org.apache.commons.math3.distribution.FDistribution(aa.df1, aa.df2);
        System.out.println(tdd.cumulativeProbability(0.025));
        System.out.println(tdd.cumulativeProbability(0.975));


        // refer - sample


        TTest bb = TTest.test(refer, sample);

        System.out.println(bb);

        smile.stat.distribution.TDistribution td2 = new smile.stat.distribution.TDistribution((int) bb.df);

        System.out.println(td2.p(0.025));
        System.out.println(td2.p(0.975));
        System.out.println(td2.quantile(0.025));
        System.out.println(td2.quantile(0.975));
        System.out.println(td2.cdf(0.025));
        System.out.println(td2.cdf(0.975));






//        aa



        /***********************************************
         * F 테스트
         ***********************************************/
        // 현재 통계 R 프로그래밍의 다른 결과 (참고문헌 참조)
        // 참고문헌 : https://stackoverflow.com/questions/35398918/is-there-an-equivalent-function-for-anova-lm-in-java

        System.out.println("======================== F 테스트 ====================");

        List classes = new ArrayList();

        classes.add(refer);
        classes.add(sample);

//        double varA = referStat.getVariance();
//        double varB = sampleStat.getVariance();

        // 분산
        double varA = referStat.getVariance();
        double varB = sampleStat.getVariance();

        // 자료 개수
        double lengthA = referStat.getN();
        double lengthB = sampleStat.getN();



//        int n1 = x.length;
//        int n2 = y.length;

//        double var1 = MathEx.var(x);
//        double var2 = MathEx.var(y);

        int df1, df2;
        double f;

        // Make F the ratio of the larger variance to the smaller one.
        if (varA > varB) {
            f = varA / varB;
            df1 = (int) (lengthA - 1);
            df2 = (int) (lengthB - 1);
        } else {
            f = varB / varA;
            df1 = (int) (lengthB - 1);
            df2 = (int) (lengthA - 1);
        }

//        double p = 2.0 * Beta.regularizedIncompleteBetaFunction(0.5 * df2, 0.5 * df1, df2 / (df2 + df1 * f));
//        if (p > 1.0) {
//            p = 2.0 - p;
//        }



        double fVal = TestUtils.oneWayAnovaFValue(classes);
        double pValForFtest = TestUtils.oneWayAnovaPValue(classes);

        System.out.println("fVal : " + fVal);
        System.out.println("pValForFtest : " + pValForFtest);

        Map<Object, Object> result = confInv95(referStat, sampleStat, true);

        // 95% 신뢰구간
        System.out.println("leftConvInv95 : " + result.get("leftConvInv95"));
        System.out.println("rightConvInv95 : " + result.get("rightConvInv95"));

        // x/y축 T 분포
        System.out.println("xAxisList : " + result.get("xAxisList"));
        System.out.println("yAxisList : " + result.get("yAxisList"));

        /*********************************************************
         * T 테스트 (등분산 O) : F 테스트의 P값이 0.05 클 경우
         *********************************************************/

        System.out.println("======================== T 테스트 ====================");

        // F값
        double tVal = TestUtils.homoscedasticT(refer, sample);
        System.out.println("fVal : " + tVal);

        // P값
        double pValForTtest = TestUtils.homoscedasticTTest(refer, sample);
        System.out.println("pValForTtest : " + pValForTtest);


        /*********************************************************
         * T 테스트 (등분산 X) : F 테스트의 P값이 0.05 작을 경우
         *********************************************************/
//        double tVal = TestUtils.t(refer, sample);
//        System.out.println("tVal : " + tVal);

        // P 값
//        double pVal = TestUtils.tTest(refer, sample);
//        System.out.println("pVal : " + pVal);


        // Apache Commons Math는 신뢰 구간을 직접 지원하지 않습니다.
        // 따라서 별도로 메서드 (신뢰구간95%) 작성
        result = confInv95(referStat, sampleStat, false);

        // 95% 신뢰구간
        System.out.println("leftConvInv95 : " + result.get("leftConvInv95"));
        System.out.println("rightConvInv95 : " + result.get("rightConvInv95"));

        // x/y축 T 분포
        System.out.println("xAxisList : " + result.get("xAxisList"));
        System.out.println("yAxisList : " + result.get("yAxisList"));

        // 0.05 이하의 경우 (귀무가설 기각)
        if (pValForTtest < 0.05) {
            System.out.println("2 그룹의 평균은 차이가 있다.");
        } else {
            System.out.println("2 그룹의 평균은 차이가 없다.");
        }
    }


    public static Map<Object, Object> confInv95(SummaryStatistics referStat, SummaryStatistics sampleStat, boolean isFtest) {

        Map<Object, Object> result = new HashMap<>();

        try {
            // 평균
            double maenA = referStat.getMean();
            double maenB = sampleStat.getMean();

            // 분산
            double varA = referStat.getVariance();
            double varB = sampleStat.getVariance();

            // 자료 개수
            double lengthA = referStat.getN();
            double lengthB = sampleStat.getN();

            // 자유도
            double dfA = lengthA - 1;
            double dfB = lengthB - 1;


            double p0025, p0975;

            FDistribution fd = new FDistribution(dfA, dfB);
            TDistribution td = new TDistribution(dfA + dfB);

            // F 테스트 유무
            if (isFtest) {
                p0025 = fd.inverseCumulativeProbability(0.025);
                p0975 = fd.inverseCumulativeProbability(0.975);
            } else {
                p0025 = td.inverseCumulativeProbability(0.025);
                p0975 = td.inverseCumulativeProbability(0.975);
            }




            System.out.println("p0025 : " + p0025);
            System.out.println("p0975 : " + p0975);

            double conInv = Math.sqrt((varA / lengthA) + (varB / lengthB));

            double leftConvInv95 = (maenA - maenB) + (p0025 * conInv);
            double rightConvInv95 = (maenA - maenB) + (p0975 * conInv);

//            System.out.println("leftConvInv95 : " + leftConvInv95);
//            System.out.println("rightConvInv95 : " + rightConvInv95);

            double srtNum = -10.0;
            double endNum = 10.0;
            double invNum = 0.1;

            List<Object> xAxisList = new ArrayList();
            List<Object> yAxisList = new ArrayList();

            for (double i = srtNum; i < endNum; i += invNum) {

                double after, before;

                if (isFtest) {
                    after = fd.cumulativeProbability(i + invNum);
                    before = fd.cumulativeProbability(i);
                } else {
                    after = td.cumulativeProbability(i + invNum);
                    before = td.cumulativeProbability(i);
                }

                double diff = (after - before) * 10.0;

                xAxisList.add(i);
                yAxisList.add(diff);
            }

            result.put("leftConvInv95", leftConvInv95);
            result.put("rightConvInv95", rightConvInv95);
            result.put("xAxisList", xAxisList);
            result.put("yAxisList", yAxisList);

        } catch (NotStrictlyPositiveException e) {
            System.out.println("[ERROR] NotStrictlyPositiveException : " + e.getMessage());
        } catch (OutOfRangeException e2) {
            System.out.println("[ERROR] OutOfRangeException : " + e2.getMessage());
        } catch (Exception e3) {
            System.out.println("[ERROR] Exception : " + e3.getMessage());
        }

        return result;
    }
}
