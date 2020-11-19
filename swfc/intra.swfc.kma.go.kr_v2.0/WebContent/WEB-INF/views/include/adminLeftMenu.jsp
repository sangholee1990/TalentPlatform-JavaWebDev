<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-sm-2 col-md-2" id="leftMenuArea">
    <h4 id="subMenuTitle"></h4>
	<!-- 사용자 관리 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="사용자관리" style="display: none;">
		<li pattern="/admin/user/user_"><a href="<c:url value='/admin/user/user_list.do'/>">사용자 관리</a></li>
		<li pattern="/admin/spcf/spcf_contents_"><a href="<c:url value='/admin/spcf/spcf_contents_list.do'/>">특정수요자용<br />컨텐츠 관리</a></li>
	</ul>
	
	<!-- 프로그램 관리 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="프로그램관리" style="display: none;">
		<li pattern="/admin/reportdata/program_"><a href="<c:url value='/admin/reportdata/program_list.do'/>">프로그램 관리</a></li>
	</ul>
	
	<!-- 메타 기본정보 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="기본정보 " style="display: none;">
		<li pattern="/admin/meta/sat_grp_"><a href="<c:url value='/admin/meta/sat_grp_list.do'/>">수집대상 그룹 정보</a></li>
		<li pattern="/admin/meta/sat_"><a href="<c:url value='/admin/meta/sat_list.do'/>">수집대상 정보</a></li>
		<li pattern="/admin/meta/sensor_"><a href="<c:url value='/admin/meta/sensor_list.do'/>">수집대상 센서 정보</a></li>
		<li pattern="/admin/meta/band_grp_"><a href="<c:url value='/admin/meta/band_grp_list.do'/>">수집대상 밴드 그룹 정보</a></li>
		<li pattern="/admin/meta/band_"><a href="<c:url value='/admin/meta/band_list.do'/>">수집대상 밴드 정보</a></li>
		<li pattern="/admin/meta/sensorband_"><a href="<c:url value='/admin/meta/sensorband_mapping_list.do'/>">수집대상 센서 밴드 매핑 정보</a></li>
		<li pattern="/admin/meta/satsensor_"><a href="<c:url value='/admin/meta/satsensor_mapping_list.do'/>">수집대상 센서 매핑 정보</a></li>
	</ul>
	
	<!-- 특보 및 예보 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="보고서" style="display: none;">
		<li pattern="/admin/report/"><a href="<c:url value='/admin/report/report_list.do'/>">보고서</a></li>
	</ul>
	
	<!-- 게시판 관리 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="커뮤니티관리" style="display: none;">
		<li pattern="/admin/board/notice_"><a href="<c:url value='/admin/board/notice_list.do'/>">공지사항</a></li>
		<li pattern="/admin/board/archives_"><a href="<c:url value='/admin/board/archives_list.do'/>">자료실</a></li>
		<li pattern="/admin/board/faq_"><a href="<c:url value='/admin/board/faq_list.do'/>">FAQ</a></li>
	</ul>
	
	<!-- 통계 관리 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="통계관리" style="display: none;">
		<li pattern="/admin/stats/stat_"><a href="<c:url value='/admin/stats/stat_list.do'/>">월간통계관리</a></li>
		<li pattern="/admin/statistics/grade_"><a href="<c:url value="/admin/statistics/grade_list.do"/>">등급별 발현 횟수</a></li>
		<li pattern="/admin/export/data_export_"><a href="<c:url value="/admin/export/data_export_search_form.do"/>">기간별 위성자료<br/>데이타 다운로드</a></li>
	</ul>
	
	<!-- 수집프로그램 관리 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="수집프로그램관리" style="display: none;">
	<!-- 
		<li pattern="/admin/program/ctl_prog_"><a href="<c:url value="/admin/program/ctl_prog_list.do"/>">수집프로그램관리</a></li>
		<li pattern="/admin/program/frct_prog_"><a href="<c:url value="/admin/program/frct_prog_list.do"/>">예측모델프로그램관리</a></li>
		<li pattern="/admin/program/ctl_data_"><a href="<c:url value="/admin/program/ctl_data_list.do"/>">수집자료관리</a></li>
	 -->
		<li pattern="/admin/program/mp_ctl_data_"><a href="<c:url value="/admin/program/mp_ctl_data_list.do"/>">수집자료매핑관리</a></li>
		<li pattern="/admin/program/mp_frct_prog_"><a href="<c:url value="/admin/program/mp_frct_prog_list.do"/>">예측모델프로그램매핑관리</a></li>
	</ul>
	
	<!-- 자료 정보 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="자료정보 " style="display: none;">
		<li pattern="/admin/data/domain_"><a href="<c:url value='/admin/data/domain_list.do'/>">도메인 정보</a></li>
		<li pattern="/admin/data/domainsub_"><a href="<c:url value='/admin/data/domainsub_list.do'/>">도메인 서브 정보</a></li>
		<li pattern="/admin/data/datakind_"><a href="<c:url value='/admin/data/datakind_list.do'/>">자료종류 정보</a></li>
		<li pattern="/admin/data/datakindinside_"><a href="<c:url value='/admin/data/datakindinside_list.do'/>">자료종류 내부 정보</a></li>
		<li pattern="/admin/data/domainlayer_"><a href="<c:url value='/admin/data/domainlayer_list.do'/>">도메인 레이어 정보</a></li>
		<li pattern="/admin/data/domaindatamapping_"><a href="<c:url value='/admin/data/domaindatamapping_list.do'/>">도메인 레이어 자료종류 매핑 정보</a></li>
		<li pattern="/admin/meta/coverage_"><a href="<c:url value='/admin/meta/coverage_list.do'/>">범위 정보</a></li>
	</ul>
	

	<!-- 마스터 정보 -->	
	<ul class="nav nav-pills nav-stacked leftNav" title="마스터정보 " style="display: none;">
		<li pattern="/admin/master/datamaster_"><a href="<c:url value="/admin/master/datamaster_list.do"/>" >마스터정보</a></li>
	</ul>
	
	<!-- WMO 정보 -->	
	<ul class="nav nav-pills nav-stacked leftNav" title="WMO Meta 정보 " style="display: none;">
		<li pattern="/admin/wmo/wmometa_"><a href="<c:url value="/admin/wmo/wmometa_list.do"/>" >WMO Meta</a></li>
	</ul>
	

	<!-- 자료 정보 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="통계 " style="display: none;">
	</ul>
	
	<!-- 자료 정보 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="시스템관리 " style="display: none;">
		<li pattern="/admin/dbinfo_"><a href="/admin/dbinfo_list.do">데이터베이스 정보</a></li>
	</ul>
	
	<!-- 자료 정보 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="시스템관리 " style="display: none;">
		<li pattern="/admin/system/dbinfo_"><a href="<c:url value='/admin/system/dbinfo_list.do'/>">데이터베이스 정보</a></li>
		<li role="presentation" class="divider"></li>
		<li pattern="/admin/gnss/gnss_station_"><a href="<c:url value='/admin/gnss/gnss_station_list.do'/>">GNSS지점관리</a></li>
		<li pattern="/admin/code/code_"><a href="<c:url value='/admin/code/code_list.do'/>">공통코드관리</a></li>
		<li pattern="/admin/dic/dictionary_"><a href="<c:url value="/admin/dic/dictionary_list.do"/>">단어사전</a></li>
	</ul>
	
	<!-- 자료 정보 -->		
	<ul class="nav nav-pills nav-stacked leftNav" title="SMS 관리 " style="display: none;">
		<li pattern="/admin/sms/sms_threshold"><a href="<c:url value='/admin/sms/sms_threshold_list.do'/>">실황통보관리</a></li>
		<li pattern="/admin/sms/sms_"><a href="<c:url value='/admin/sms/sms_list.do'/>">SMS 관리</a></li>
		<li pattern="/admin/sms/user_"><a href="<c:url value='/admin/sms/user_list.do'/>">SMS 사용자 관리</a></li>
		<li pattern="/admin/sms/sms"><a href="<c:url value='/admin/sms/smsLog_list.do'/>">SMS 발송 로그</a></li>
	</ul>
	
</div>
