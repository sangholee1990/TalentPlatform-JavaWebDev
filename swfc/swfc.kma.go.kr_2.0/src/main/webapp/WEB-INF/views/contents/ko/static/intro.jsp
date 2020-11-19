<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/jquery.jsp" />
</head>
<body>
<a name="sun"></a>
<jsp:include page="/WEB-INF/views/include/topMenu.jsp"/>
<div id="wrap_sub">
	<h2 class="intro">
    	<span>우주기상 실황</span>
    </h2>
    <div id="tab" class="tab3">
    	<a href="<c:url value="/ko/intro.do?tab=sun"/>" class="act <c:if test="${ param.tab eq 'sun' }">on</c:if>"><span>태양활동</span></a>
        <a href="<c:url value="/ko/intro.do?tab=mag"/>" class="ter <c:if test="${ param.tab eq 'mag' }">on</c:if>"><span>지자기활동</span></a>
        <a href="<c:url value="/ko/intro.do?tab=weather"/>" class="sur <c:if test="${ param.tab eq 'weather' }">on</c:if>"><span>우주기상 감시</span></a>
        <a href="<c:url value="/ko/intro.do?tab=alert"/>" class="kma <c:if test="${ param.tab eq 'alert' }">on</c:if>"><span>기상청의 우주기상 예특보</span></a>
        <a href="<c:url value="/ko/intro.do?tab=ksem"/>" class="ksem <c:if test="${ param.tab eq 'ksem' }">on</c:if>"><span>우주기상탑제체</span></a>
    </div>
    <!-- 태양활동 -->
    <c:if test="${ param.tab eq 'sun' }">
        <h3 class="acti">
            <span>태양활동</span>
        </h3>
        <p class="paragraph">
            <img src="<c:url value="/resources/ko/images/img_intro_act.png"/>" alt="태양플레어와 코로나 질량방출" />
            <h4>1. 플레어(Solar Flare)</h4>
    태양표면에서 태양대기의 자기력선에 저장된 자기에너지가 갑작스럽게 방출되는 현상을 플레어라고 한다. 플레어는 주로 태양흑점에서 발생한다. 플레어의 발생 원인은 태양활동 영역에서의 자기장이 불안정해지면서 자기장의 구조가 붕괴되어 발생하는 것으로 추정하고 있다. 때때로 고에너지 양성자 방출과 코로나 질량방출을 동반하기도 한다. 플레어가 발생하면 감마선에서부터 전파에 이르는 광범위한 전자기파가 방출되지만 플레어의 강도를 구분하기 위해 주로 X-ray 관측자료를 활용한다. 
    플레어는 전자기파를 방출하기 때문에 플레어 발생에 의한 우주기상의 피해는 주로 통신교란으로 나타난다. 예를 들면, 위성통신 장애, 항공 운항통신 장애, GPS 신호 수신장애 등이 있다.
        </p>
        <p class="paragraph">
            <h4>2. 태양 양성자 유입(Solar Proton Event)</h4>
            태양 플레어가 발생 할 때 동시에 태양대기에 있던 고에너지의 양성자들이 매우 빠른 속도로 수시간만에 지구에 도달하는 현상이 발생한다. 이를 태양 양성자 사건이라 한다. 발생원인은 플레어 발생 시 일부 양성자들이 밖으로 방출되는 것으로 추정하고 있다. 태양 양성자 사건은 주로 대규모의 플레어 발생에 동반하는 경향이 있다. 
    태양 양성자 유입에 의한 우주기상 피해는 주로 방사선량 증가로 나타난다. 고에너지의 양성자가 극지방을 따라 지구의 고층대기로 유입되면 극항로 부근에 방사선량을 증가시켜 극항로 운행이 잦은 항공기 승무원들에 영향을 줄 수 있다. 또한 극궤도 위성의 경우 양성자에 의한 피폭위험이 있다. 
        </p>
        <p class="paragraph">
            <h4>3. 코로나 질량방출(Coronal Mass Ejection: CME)</h4>
            코로나 질량방출은 태양 대기로부터 거대한 양의 태양 물질이 짧은 시간 내에 방출되는 현상을 말한다. 이 태양 물질은 전자와 양성자를 포함하는 전하를 띤 입자들로 구성되어 있고, 이들을 플라스마(Plasma)라 부른다. 빠른 속도로 방출된 코로나 질량방출의 경우 그 전면에 충격파를 형성 하기도 한다. 코로나 질량방출의 발생 원인은 태양 표면에서의 자기장과 플라스마 불안정에 기인된 것으로 생각하고 있다. 
    코로나 질량방출의 경우 플레어에 비해 더 다양한 우주기상 피해를 발생시킨다. 예를 들면, 코로나 질량방출 전면에 형성된 충격파에 의한 위성궤도 영향, 위성 오작동, 극항로 부근의 방사선량 증가, 자기폭풍 유발 등이 대표적이다.
        </p>
    <!-- END 태양활동 -->
    </c:if>
    
    <!-- 지자기활동 -->
    <c:if test="${ param.tab eq 'mag' }">
        <h3 class="terr">
            <span>지자기활동</span>
        </h3>
        <p class="paragraph">
            <img src="<c:url value="/resources/ko/images/img_intro_ter.png"/>" alt="지자기활동" />
            <h4>1. 지구 자기권(Magnetosphere)</h4>			
			지구 내부 외핵의 대류에 의해 생성된 지구 자기장은 태양으로부터 날라오는 전자기파 및 플라스마뿐만 아니라 우주공간에 분포하는 우주선(Cosmic ray)등 우주기상의 위험을 막아주는 훌륭한 방패 역할을 한다. 태양풍과 지구 자기권 사이의 경계면을 자기권계면(Magnetopause) 이라 하는데, 이 곳을 기준으로 그 안쪽으로는 우주기상에 의한 위험으로부터 보호받을 수 있다. 지구 자기권은 태양에서 날라오는 플라스마 및 행성간 자기장(Interplanetary Magnetic Field: IMF)에 의해 본래 구형의 쌍극자 형태가 아닌, 태양 쪽을 바라보는 면은 압축되고 반대쪽은 늘게 늘어진 모습을 가진다. 따라서, 태양풍 상태에 따라 지구 자기장은 매우 가변적이다. 태양으로부터 우주기상 현상이 발생하면 지구 자기권은 교란을 받는데, 대표적인 현상으로는 자기권계면 압축, 자기폭풍(Magnetic storm)이 있다.
        </p>
        <p class="paragraph">
            <h4>2. 자기권계면(Magnetopause) 압축</h4>
			태양으로부터 강한 코로나 질량방출과 고속의 태양풍이 발생하면, 우주기상의 위험을 막아주는 자기장이 평상시보다 압축된다. 자기권계면이 정지궤도보다 압축되면 정지궤도위성은 지구 자기장의 보호를 받지 못하고 태양풍의 위험에 그대로 노출된다. 위성이 자기권계면 바깥쪽에 위치하게 될 경우, 태양 고에너지입자에 의한 위성체 손상 및 통신 장애 등 위성운영의 전반적인 영역에 영향을 받을 수 있다. 
        </p>
        <p class="paragraph">
            <h4> 3. 자기폭풍(Magnetic storm)</h4>           
			자기폭풍은 전 세계에 걸쳐 대규모로 지자기 변화가 일어나는 기간을 말한다. 이런 변화는 규모에 따라 수시간에서 수일에 이른다. 자기폭풍을 일으키는 직접적인 원인은 태양으로부터 유입된 다량의 플라스마가 발생시키는 전류이다. 이 전류를 환전류(Ring current)라 부른다. 이 환전류는 지구 자기장의 수평성분 세기를 급격히 감소 시킨다. 이러한 변화를 감시하는 지수로는 대표적으로 Kp지수와 Dst지수가 있다. 
자기폭풍으로 인하여 지구 자기장의 세기가 급격히 감소되면 위성운영 궤도에서의 전자기 변화를 일으켜 위성체 및 위성운영에 영향을 줄 수 있고, 극항로 부근에 방사선을 유입시키는 원인이 되기도 한다. 자기장 변화의 영향이 전리층에 전달되어 GPS 위치 오차 발생 및 통신교란에 영향을 주어 위성통신, 항공운항 통신 등에 장애를 일으키기도 한다.
        </p>
    </c:if>
    <!-- END 지자기활동 -->
    
    <!-- 우주기상감시 -->
    <c:if test="${ param.tab eq 'weather' }">
        <h3 class="surv">
            <span>우주기상감시</span>
        </h3>
        <p class="paragraph">
            <img src="<c:url value="/resources/ko/images/img_intro_sur.png"/>" alt="우주기상 감시위성의 실시간 자료" />
            <h4>우주기상 변화 감시</h4>			
			우주기상의 변화 감시하기 위해 주로 태양활동과 지구자기장 변화를 감시하고 있다. 우주기상에 영향을 주는 대표적인 태양활동으로는 플레어와 코로나 질량방출이 있다. 태양활동 감시는 주로 위성의 관측을 통해 이루어 진다. 플레어를 관측하는 주요 위성은 GOES 13, 15위성이 있고, 코로나 질량방출을 관측하는 주요 위성은 STERO A, B위성과 SOHO위성이 있다. 또한 코로나 질량방출과 고속태양풍에 의한 태양풍 변화를 감시하기 위해 ACE위성이 태양풍과 행성간 자기장을 관측한다. 
지구자기장의 변화 감시는 위성관측과 지상 자기장 관측을 동반한다. 정지궤도에서의 변화를 감시하기 위해 GOES 13, 15위성의 관측자료를 활용하고, 지상에서의 자기장 변화는 지자기폭풍을 관측하는 지수인 Kp지수와 Dst지수를 활용한다. 
        </p>
    <!-- END 우주기상감시 -->
    </c:if>
    
     <!-- 기상청의 우주기상예특보 -->
     <c:if test="${ param.tab eq 'alert' }">
        <h3 class="fore">
            <span>기상청의 우주기상 예특보</span>
        </h3>
        <p class="paragraph">
        <img src="<c:url value="/resources/ko/images/img_intro_kma.png"/>" alt="" />
        	기상청에서는 태양활동과 지구 자기권의 변화를 상시 감시함으로써 우주기상 위험에 대비하고 있다. 기상청에서 주요하게 감시하는 우주기상 요소는 기상위성운영, 극항로 항공기상, 전리권기상이다.   
        </p>
       
        <p class="paragraph">
            
            <h4>1. 기상위성운영</h4>
            기상위성운영은 우주기상의 영향으로부터 천리안위성 및 후속 기상위성의 안정적 운영지원을 위한 우주기상 예특보 요소이다. 기상위성운영에 영향을 주는 우주기상 인자로는 통신교란의 발생 원인인 플레어와 위성체 및 위성운영궤도에 영향을 주는 자기폭풍과 자기권계면 위치가 있다. 기상위성운영에 우주기상 특보 발령 시 기상위성의 안정적 운영을 위하여 위성궤도 모니터링 및 조정, 태양 전지판 운용각도 조정, 위성수신 장애 감시 등의 대응을 하고 있다.
        </p>
        <p class="paragraph">
            <h4>2. 극항로 항공기상</h4>
            극항로 항공기상은 세계기상기구의 우주기상 서비스 지원 결정 및 국제민간항공기구 우주기상 항행기준 준비를 지원하기 위한 우주기상 예특보 요소이다. 극항로 항공기상에 영향을 주는 우주기상 인자로는 항행통신에 영향을 주는 플레어와 극항로 부근에 방사선량을 증가시키는 태양 고에너지입자 발생 및 자기폭풍이 있다. 극항로 항공기상에 우주기상 특보 발령 시 항공기 운항고도 조정 및 북극항로 우회운항 제시, GPS 신호오차 감시 및 통신장애 감시 등의 대응을 하고 있다.
        </p>
        <p class="paragraph">
            <h4>3. 전리권기상</h4>
            전리권기상은 전지구 위성항법시스템(GNSS) 관측자료를 활용한 전자밀도 및 가강수량 산출지원을 위한 우주기상 예•특보 요소이다. 태양 플레어 및 자기폭풍이 발생할 시 지구의 초고층대기인 전리권에 전자밀도를 증가시킨다. 지구의 초고층대기 변화를 감시하기 위해 위성측위시스템을 이용하여 전자밀도를 산출하고, 이와 더불어 가강수량을 산출하여 기상청의 수치예보에도 활용하고 있다.  전리권기상에 우주기상 특보 발령 시 기상•기후 예측에 영향을 줄 수 있는 기상요소들의 변화 및 수치모델 결과 감시 등의 대응을 하고 있다. 
        </p>
		<br/><br/>
		<a name="newsflashHelp1"></a>
		<div>
			<h4 align="center">&lt;기상청 우주기상 예특보 기준&gt;</h4>
			<table border="2" align="center" width="100%">
				<tr>
					<td align="center" rowspan="2">항목</td>
					<td align="center" colspan="3">상황 기준</td>
					<td align="center" rowspan="2">상황 해제 기준</td>
				</tr>
				<tr>
					<td align="center" bgcolor="#BCF5A9">보통</td>
					<td align="center" bgcolor="#F4A9F2">주의보</td>
					<td align="center" bgcolor="#F4A9F2">경보</td>
				</tr>
				<tr>
					<td align="center">기상위성 운영</td>
					<td align="center" bgcolor="#BCF5A9">
						R2 이하<br/>
						S2 이하<br/>
						G2 이하<br/>
						자기권계면 위치 > 정지궤도
					</td>
					<td align="center" bgcolor="#F4A9F2">
						R3<br/>
						S3<br/>
						G3<br/>
						자기권계면 위치 > 정지궤도
					</td>
					<td align="center" bgcolor="#F4A9F2">
						R4 이상<br/>
						S4 이상<br/>
						G4 이상<br/>
						자기권계면 위치 =< 정지궤도
					</td>
					<td align="center" rowspan="3">
						최소 3시간 해제 상황 유지<br/>
						(NOAA등급 기준 2등급 이하 상황으로 3시간 지속)
					</td>
				</tr>
				<tr>
					<td align="center">극항로 항공기상</td>
					<td align="center" bgcolor="#BCF5A9">
						R2 이하<br/>
						S2 이하<br/>
						G2 이하
					</td>
					<td align="center" bgcolor="#F4A9F2">
						R3<br/>
						S3<br/>
						G3
					</td>
					<td align="center" bgcolor="#F4A9F2">
						R4 이상<br/>
						S4 이상<br/>
						G4 이상
					</td>
				</tr>
				<tr>
					<td align="center">전리권 기상</td>
					<td align="center" bgcolor="#BCF5A9">
						R2 이하<br/>
						G2 이하
					</td>
					<td align="center" bgcolor="#F4A9F2">
						R3<br/>
						G3
					</td>
					<td align="center" bgcolor="#F4A9F2">
						R4 이상<br/>
						G4 이상
					</td>
				</tr>
			</table>
		</div>
		<br/><br/>		
		<div>
			<h4 align="center">&lt;우주기상 예상피해&gt;</h4>
			<table border="2" align="center" width="100%">
				<tr>
					<td align="center" rowspan="2">상황<br/>구분</td>
					<td align="center" rowspan="2">관측<br/>등급</td>
					<td align="center" colspan=3>예상피해</td>
					</tr>
				<tr>
					<td align="center">기상위성운영</td>
					<td align="center">극항로 항공기상</td>
					<td align="center">전리권기상</td>
				</tr>
				<tr>
					<td align="center" rowspan=3 bgcolor="#BCF5A9">보통</td>
					<td align="center" bgcolor="#BCF5A9">낮음</td>
					<td align="left" rowspan="2" bgcolor="#BCF5A9">
						- 영향 없음
					</td>
					<td align="left" rowspan="2" bgcolor="#BCF5A9">
						- 영향 없음
					</td>
					<td align="left" rowspan="2" bgcolor="#BCF5A9">
						- 영향 없음
					</td>
				</tr>				
				<tr>
					<td align="center" bgcolor="#BCF5A9">일반</td>
				</tr>
				<tr>
					<td align="center" bgcolor="#BCF5A9">관심</td>
					<td align="left" bgcolor="#BCF5A9">
						- 위성운영에 대한 지상국의 조정 필요<br/>
						- 저궤도 위성의 궤도변화 가능성
					</td>
					<td align="left" bgcolor="#BCF5A9">
						- 극항로 항공기 승무원 및 승객의 방사능 노출<br/>
						- 극지방에서 HF통신 및 항해 영향
					</td>
					<td align="left" bgcolor="#BCF5A9">
						- HF통신 가능 한계<br/>
						- 저주파통신 10여분간 품질 저하
					</td>
				</tr>
				<tr>
					<td align="center" bgcolor="#F4A9F2">주의보</td>
					<td align="center" bgcolor="#F4A9F2">주의</td>
					<td align="left" bgcolor="#F4A9F2">
						- 위성궤도 오차 증가<br/>
						- 위성 통신 신호 감쇄<br/>
						- 저궤도 위성 궤도끌림 현상 발생
					</td>
					<td align="left" bgcolor="#F4A9F2">
						- 극지방 HF통신 효율 저하<br/>
						- 극항로 항공기 방사능 노출
					</td>
					<td align="left" bgcolor="#F4A9F2">
						- GPS 신호 감쇄
					</td>
				</tr>
				<tr>
					<td align="center" rowspan="2" bgcolor="#F4A9F2">경보</td>
					<td align="center" bgcolor="#F4A9F2">경계</td>
					<td align="left" bgcolor="#F4A9F2">
						- 위성 표면대전 및 위치추적 문제<br/>
						- 저궤도 위성 궤도끌림 현상 발생<br/>
						- 메모리 장치 문제로 인한 관측영상 에러값 발생<br/>
						- 인공위성 직접훼손<br/>
						- 위성통신, 위치추적 장애
					</td>
					<td align="left" bgcolor="#F4A9F2">
						- 극지방 HF통신 장애<br/>
						- 극항로 항공기 방사능 노출
					</td>
					<td align="left" bgcolor="#F4A9F2">
						- GPS통신 장애
					</td>
				</tr>
				<tr>
					<td align="center" bgcolor="#F4A9F2">심각</td>
					<td align="left" bgcolor="#F4A9F2">
						- 위성 표면대전 및 위치추적 문제<br/>
						- 저궤도 위성 궤도끌림 현상 발생<br/>
						- 메모리 장치 문제로 인한 관측영상 에러값 발생<br/>
						- 인공위성 직접훼손<br/>
						- 위성통신, 위치추적 장애
					</td>
					<td align="left" bgcolor="#F4A9F2">
						- 수 시간동안 태양방면의 반구에서 HF통신 불가능<br/>
						- 극항로 항공기 방사능 노출
					</td>
					<td align="left" bgcolor="#F4A9F2">
						- GPS통신 장애
					</td>
				</tr>
			</table>
		</div>
		</c:if>
    <!-- END 기상청의 우주기상예특보 -->
    <!-- START 우주기상 탑제체 -->
    <c:if test="${ param.tab eq 'ksem' }">
	    <div>
	    	<h3 class="kse"><span>우주기상 탑제체</span></h3>
	    	<!-- -우주기상 탑제체 정보 -->
	    	<p>
	    	기상청은 2010년 발사된 국내 최초 정지궤도 기상관측위성인 천리안위성을 2011년 정규운영으로 전환하는데 성공하였다.<br/>
	    	이에 따라 천리안 위성의 안정적인 임무 수행을 위한 위성 주변의 우주기상 관측과 예측정보의 필요성이 대두되어
	    	2018년 발사 예정인 후속 정지궤도 기상위성에<br/>
	    	우주기상 관측센서를 탑재하여 안정적인 기상관측임무가 수행되도록 지원할 예정이다.<br/>
	    	우주위험기상은 발생 빈도수는 적으나 발생시 고위험을 초래할 수 있어 잠재적 재해에 대비하기 위한 상시감시 기반을 구축하여
	    	우주위험기상의 조기탐지 및<br/>
	    	분석기술, 재해예측 기술을 확보할 필요가 있다.
	    	</p>
	    	
			<p>
			이를 위해 기상청은 한국형 우주기상 감시기(KSEM : Korean Space Environment Monitor)를 개발 중에 있다.
			</p>
			
			<p>
			KSEM은 중에너지 입자측정기(Energetic Particle Detector), 자력계(Magnetometer), 위성대전 감시기(Satellite Charging Monitor)로
			구성되어<br/>
			정지궤도 상의 근지구 환경을 관측할 예정이다.
			</p>
			
			<p>
			중에너지 입자측정기는 100KeV에서 2MeV사이의 에너지 대역의 전자와 100keV에서 20MeV 에너지 대역의 양성자를
			각 6개의 방향에 대해 측정할 예정으로<br/>
			정지궤도에서의 고 에너지 입자 환경정보를 제공할 예정이다.
			</p>
			
			<p>
			자력계는  지구 자기장을 측정하는 장비로서 지자기폭풍(Geomagnetic Storm)에 따른 지자기 변화량을 측정할 예정이다.
			</p>
			
			<p>
			위성대전감시기(Satellite Charging Monitor)는 –3pA/cm<sup>2</sup>에서 3pA/cm<sup>2</sup> 사이의 대전 전류량을 측정하는 장비로서,<br/>
			위성시스템에 영향을 주는 대전 현상을 분석하는데 사용될 것이다.
			</p>
			
			<p>
			KSEM은 2018년 발사예정인 차세대 한국형 다목적위성(Geo-KOMSAT-2A)에 탑재되어 국내 최초로 정지궤도에서의 우주기상 감시를 수행할 계획이다.
			</p>
	    </div>
	</c:if>
    <!-- END 우주기상 탑제체 -->
</div>    
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
