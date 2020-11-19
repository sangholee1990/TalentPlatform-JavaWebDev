<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
<div id="header">
    <h1>
    	<a href="<c:url value="/"/>">
        <img src="<c:url value="/resources/ko/images/logo.png"/>" alt="국가기상위성센터 우주기상 예특보 서비스" class="imgbtn" />
        </a>
    </h1>
    <div class="menu">
        <a href="<c:url value="/ko/current.do"/>" class="condition<c:if test="${menu=='current'}"> on</c:if>"><span>우주기상실황</span></a>
        <a href="<c:url value="/ko/alerts.do"/>" class="alert<c:if test="${menu=='alerts'}"> on</c:if>"><span>우주기상예특보</span></a>
        <a href="<c:url value="/ko/intro.do"/>" class="intro<c:if test="${menu=='intro'}"> on</c:if>"><span>우주기상소개</span></a>
        <a href="<c:url value="/ko/links.do"/>" class="link<c:if test="${menu=='links'}"> on</c:if>"><span>해외우주기상정보</span></a>        
    </div>
</div>-->
<div id="header">
    <h1>
    	<a href="<c:url value="/ko/index.do"/>">
        <img src="<c:url value="/resources/ko/images/logo.png"/>" alt="국가기상위성센터 우주기상 예특보 서비스" class="imgbtn" width="213"/>
        </a>
    </h1>
    
	<ul class='gmn'>
		<c:if test="${sessionScope.USERID != null && sessionScope.ROLE ne 'ROLE_ANONYMOUS'}">
			<li><a href='<c:url value="/ko/specificContent/specific.do"/>' class='bt_spcfPop' title="특정수요자용 컨텐츠"><span>특정수요자용 컨텐츠</span></a></li>
		</c:if>
		<li><a href='<c:url value="/en/index.do"/>' class='bt_genglish' title="영문 홈페이지"><span>english</span></a></li>
		<c:if test="${sessionScope.USERID == null}">
		<li><a href='<c:url value="/ko/login.do"/>' class='bt_glogin' title="로그인"><span>login</span></a></li>
		</c:if>
		<c:if test="${sessionScope.USERID != null}">
			<li><a href='<c:url value="/ko/logout.do"/>' class='bt_glogout' title="로그아웃"><span>로그아웃</span></a></li>
		</c:if>
	</ul>
	<div id="TopMenu">
		<div id="TopMenuSub">
			<ul>
				<li><a href="<c:url value="/ko/current.do"/>" role="<c:url value="/ko/current.do"/>"><img class="m" src="<c:url value="/resources/ko/images/menua_off.png"/>" alt="우주기상실황" /></a>	</li>
				<li><a href="<c:url value="/ko/alerts.do"/>" role="<c:url value="/ko/alerts.do"/>"><img class="m" src="<c:url value="/resources/ko/images/menub_off.png"/>" alt="우주기상예특보" /></a></li>
				<li><a href="<c:url value="/ko/intro.do?tab=sun"/>" role="<c:url value="/ko/intro.do"/>"><img class="m" src="<c:url value="/resources/ko/images/menuc_off.png"/>" alt="우주기상소개" /></a>	</li>
				<li><a href="<c:url value="/ko/links.do?tab=sub1"/>" role="<c:url value="/ko/links.do"/>"><img class="m" src="<c:url value="/resources/ko/images/menud_off.png"/>" alt="해외 우주기상 정보" /></a></li>
				<li class='nav_fin'><a href="<c:url value="/ko/board/notice_list.do"/>" role="<c:url value="/ko/board/"/>"><img class="m" src="<c:url value="/resources/ko/images/menue_off.png"/>" alt="정보마당" /></a></li>
			</ul>
		</div>
		<div class="TopSubMenu">
			<dl class="menu1">
				<dd><a href="<c:url value="/ko/current.do" />" role="<c:url value="/ko/current.do"/>">우주기상실황</a></dd>
			</dl>
			<dl class="menu2">
				<dd><a href="<c:url value="/ko/alerts.do"/>" role="<c:url value="/ko/alerts.do"/>">우주기상예특보</a></dd>
			</dl>				
			<dl class="menu3">
				<dd><a href="<c:url value="/ko/intro.do?tab=sun"/>" role="<c:url value="/ko/intro.do?tab=sun"/>">태양활동</a></dd>
				<dd><a href="<c:url value="/ko/intro.do?tab=mag"/>" role="<c:url value="/ko/intro.do?tab=mag"/>">지자기 활동</a></dd>
				<dd><a href="<c:url value="/ko/intro.do?tab=weather"/>" role="<c:url value="/ko/intro.do?tab=weather"/>">우주기상 감시</a></dd>
				<dd><a href="<c:url value="/ko/intro.do?tab=alert"/>" role="<c:url value="/ko/intro.do?tab=alert"/>">기상청의 우주기상 예특보</a></dd>
				<dd><a href="<c:url value="/ko/intro.do?tab=ksem"/>" role="<c:url value="/ko/intro.do?tab=ksem"/>">우주기상탑제체</a></dd>
			</dl>
			<dl class="menu4"> 
				<dd><a href="<c:url value="/ko/links.do?tab=sub1"/>" role="<c:url value="/ko/links.do?tab=sub1"/>">극항로 항공기상</a></dd>
				<dd><a href="<c:url value="/ko/links.do?tab=sub2"/>" role="<c:url value="/ko/links.do?tab=sub2"/>">위성운영</a></dd>
				<dd><a href="<c:url value="/ko/links.do?tab=sub3"/>" role="<c:url value="/ko/links.do?tab=sub3"/>">해외 관련기관</a></dd>
				<dd><a href="http://www.wmo-sat.info/product-access-guide/domain/space" target="_blank">WMO Product Access Guide (Space)</a></dd>
			</dl>
			<dl class="menu5">
				<dd><a href="<c:url value="/ko/board/notice_list.do"/>" role="<c:url value="/ko/board/notice_"/>">공지사항</a></dd>
				<dd><a href="<c:url value="/ko/board/archives_list.do"/>" role="<c:url value="/ko/board/archives_"/>">자료실</a></dd>
				<dd><a href="<c:url value="/ko/board/faq_list.do"/>" role="<c:url value="/ko/board/faq_"/>">FAQ</a></dd>
				<dd><a href="http://web.kma.go.kr/notify/epeople/proposal05.jsp#epeopleFrameFocus" target="_blank">Q&A</a></dd>
			</dl>
		</div>
	</div>
</div>
	<!-- 
<div id="header">
    <h1>
    	<a href="<c:url value="/"/>">
        <img src="<c:url value="/resources/ko/images/logo.png"/>" alt="국가기상위성센터 우주기상 예특보 서비스" class="imgbtn" />
        </a>
    </h1>
	<ul class='gmn'>
		<li><a href='<c:url value="/ko/current.do"/>' class='bt_genglish'><span>english</span></a></li>
		<li><a href='<c:url value="/ko/login.do"/>' class='bt_glogin'><span>login</span></a></li>
	</ul>
	<div id="TopMenu">
		<div id="TopMenuSub">
			<ul>
				<li>
					<a href="<c:url value="/ko/current.do"/>"><img class="m" src="<c:url value="/resources/ko/images/bg_gnb.png"/>" alt="우주기상실황" /></a>
					<div class="TopSubMenu">
						<div class="menu1">
							<strong class='txt_hidden'>우주기상실황</strong>
							<ul>
								<li><a href="<c:url value="/ko/current.do"/>">우주기상실황</a></li>
							</ul>
						</div>
						<div class="menu2">
							<strong class='txt_hidden'>우주기상예특보</strong>
							<ul class="">
								<li><a href="<c:url value="/ko/alerts.do"/>">우주기상예특보</a></li>
							</ul>
						</div>
						<div class="menu3">
							<strong class='txt_hidden'>우주기상소개</strong>
							<ul class="">
								<li><a href="<c:url value="/ko/intro.do#sub1"/>">태양활동</a></li>
								<li><a href="<c:url value="/ko/intro.do#sub2"/>">지자기 활동</a></li>
								<li><a href="<c:url value="/ko/intro.do#sub3"/>">우주기상 감시</a></li>
								<li><a href="<c:url value="/ko/intro.do#sub4"/>">기상청의 우주기상 예특보</a></li>
							</ul>
						</div>
						<div class="menu4">
							<strong class='txt_hidden'>해외 우주기상 정보</strong>
							<ul class="">
								<li><a href="<c:url value="/ko/link.do#sub1"/>">극항로 항공기상</a></li>
								<li><a href="<c:url value="/ko/link.do#sub2"/>">위성운영</a></li>
								<li><a href="<c:url value="/ko/link.do#sub3"/>">해외 관련기관</a></li>
							</ul>
						</div>
						<div class="menu5">
							<strong class='txt_hidden'>정보마당</strong>
							<ul class="">
								<li><a href="<c:url value="/ko/board/notice_list.do"/>">공지사항</a></li>
								<li><a href="<c:url value="/ko/board/faq_list.do"/>">FAQ</a></li>
								<li><a href="<c:url value="/ko/board/archives_list.do"/>">자료실</a></li>
								<li><a href="http://web.kma.go.kr/notify/epeople/proposal05.jsp#epeopleFrameFocus">Q&A</a></li>
							</ul>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>-->