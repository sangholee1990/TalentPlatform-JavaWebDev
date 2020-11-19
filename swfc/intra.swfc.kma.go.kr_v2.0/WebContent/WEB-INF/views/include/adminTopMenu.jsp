<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<div class="row" style="margin-top: 10px;">		
	<div class="col-sm-12 col-md-12 left">
		<header>
			<a href="<c:url value="/"/>"><img src="<c:url value="/images/logo.png"/>"/></a>
		</header>			
	</div>
</div>	
<div class="row">		
		<div class="col-sm-12 col-md-12 left">
			<div class="navbar navbar-default" role="navigation" style="font-weight: bold; ">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
							<span class="sr-only">toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#"></a>
					</div>
				<div class="navbar-collapse collapse">
					<ul id="topMenuList" class="nav navbar-nav navbar-right">
						<security:authorize ifAnyGranted="ROLE_ADMIN">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">사용자관리<span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">						
								<li pattern="/admin/user/user_"><a href="<c:url value='/admin/user/user_list.do'/>" >사용자관리</a></li>
								<li pattern="/admin/spcf/spcf_contents_"><a href="<c:url value='/admin/spcf/spcf_contents_list.do'/>" >특정수요자용<br />컨텐츠관리</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">프로그램관리<span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">						
								<li pattern="/admin/reportdata/program_"><a href="<c:url value="/admin/reportdata/program_list.do"/>">프로그램관리</a></li>
							</ul>
						</li>	
						
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">MetaData<span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">						
								<li pattern="/admin/meta/"><a href="<c:url value='/admin/meta/sat_grp_list.do'/>" >기본정보</a></li>
								<li pattern="/admin/data/domain_"><a href="<c:url value='/admin/data/domain_list.do'/>" >자료정보</a></li>
								<li pattern="/admin/master/datamaster_"><a href="<c:url value="/admin/master/datamaster_list.do"/>" >마스터정보</a></li>								
								<li pattern="/admin/wmo/wmometa_"><a href="<c:url value="/admin/wmo/wmometa_list.do"/>" >WMO Meta 정보</a></li>
								<li pattern="/admin/program/mp_"><a href="<c:url value="/admin/program/mp_ctl_data_list.do"/>">수집프로그램관리</a></li>								
							</ul>
						</li>
						</security:authorize>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">보고서<span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">						
								<li pattern="/admin/report/"><a href="<c:url value="/admin/report/report_list.do"/>">보고서</a></li>
								<li pattern="/admin/report/"><a href="<c:url value="/admin/report/daily_situation_report_form.do"/>">일일상황보고 작성</a></li>
								<li pattern="/admin/report/"><a href="<c:url value="/admin/report/report_form.do?rpt_type=FCT&rpt_kind=O"/>">구통보문 작성</a></li>
								<li pattern="/admin/report/"><a href="<c:url value="/admin/report/report_form.do?rpt_type=FCT&rpt_kind=N"/>">신통보문 작성</a></li>
								<li pattern="/admin/report/"><a href="<c:url value="/admin/report/report_form.do?rpt_type=WRN&rpt_kind=O"/>">구특보문 작성</a></li>
								<li pattern="/admin/report/"><a href="<c:url value="/admin/report/report_form.do?rpt_type=WRN&rpt_kind=N"/>">신특보문 작성</a></li>
							</ul>
						</li>
						<security:authorize ifAnyGranted="ROLE_ADMIN">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">커뮤니티관리<span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">						
								<li pattern="/admin/board/notice_"><a href="<c:url value="/admin/board/notice_list.do"/>">공지사항</a></li>
								<li pattern="/admin/board/archives_"><a href="<c:url value="/admin/board/archives_list.do"/>">자료실</a></li>
								<li pattern="/admin/board/faq_"><a href="<c:url value="/admin/board/faq_list.do"/>">FAQ</a></li>
							</ul>
						</li>	
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">통계<span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
								<li pattern="/admin/stats/stat_"><a href="<c:url value="/admin/stats/stat_list.do"/>">월간통계</a></li>
								<li pattern="/admin/statistics/grade_"><a href="<c:url value="/admin/statistics/grade_list.do"/>">등급별 발현 횟수</a></li>
								<li pattern="/admin/export/data_export_"><a href="<c:url value="/admin/export/data_export_search_form.do"/>">기간별 위성자료 데이타 다운로드</a></li>
							</ul>
						</li>	
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">시스템관리<span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">			
								<li pattern="/admin/system/dbinfo_"><a href="<c:url value="/admin/system/dbinfo_list.do"/>">데이터베이스관리</a></li>			
								<li pattern="/admin/sms/sms"><a href="<c:url value="/admin/sms/sms_list.do"/>">SMS 관리</a></li>
								<li role="presentation" class="divider"></li>
								<li pattern="/admin/gnss/gnss_station_"><a href="<c:url value="/admin/gnss/gnss_station_list.do"/>">GNSS지점 관리</a></li>
								<li role="presentation" class="divider"></li>
								<li pattern="/admin/code/code_"><a href="<c:url value="/admin/code/code_list.do"/>">공통코드관리</a></li>
								<li pattern="/admin/dic/dictionary_"><a href="<c:url value="/admin/dic/dictionary_list.do"/>">단어사전</a></li>
							</ul>
  						</li>
  						</security:authorize>
  						<li><a href="<c:url value="/j_spring_security_logout" />"><span class="glyphicon glyphicon-off"></span></a></li>
					</ul>			 
				</div>				
			</div>
		</div>
	</div>
</div>