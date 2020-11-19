var calendar = new controller();
calendar.init();

function controller(target) {

     var that = this;  
     var m_oMonth = new Date();
     m_oMonth.setDate(1);
     var s_oMonth = new Date();
     this.init = function() {
          that.renderCalendar();
          that.initEvent();
     }

    /* 달력 UI 생성 */
     this.renderCalendar = function() {
          var arrTable = [];

          arrTable.push('<table><colgroup>');
          for(var i=0; i<7; i++) {
               arrTable.push('<col width="100">');
          }         
          arrTable.push('</colgroup><thead><tr>');

          var arrWeek = "일월화수목금토".split("");

          for(var i=0, len=arrWeek.length; i<len; i++) {
               var sClass = '';
               sClass += i % 7 == 0 ? 'sun' : '';
               sClass += i % 7 == 6 ? 'sat' : '';
               arrTable.push('<th class="'+sClass+'">' + arrWeek[i] + '</th>');
          }
          arrTable.push('</tr></thead>');
          arrTable.push('<tbody class="days">');

          var oStartDt = new Date(m_oMonth.getTime());
        // 1일에서 1일의 요일을 빼면 그 주 첫번째 날이 나온다.
          oStartDt.setDate(oStartDt.getDate() - oStartDt.getDay());

          for(var i=0; i<100; i++) {
               if(i % 7 == 0) {
                    arrTable.push('<tr>');
               }

               var sClass = 'date-cell '
            sClass += m_oMonth.getMonth() != oStartDt.getMonth() ? 'not-this-month ' : '';
               sClass += i % 7 == 0 ? 'sun' : '';
               sClass += i % 7 == 6 ? 'sat' : '';

               arrTable.push('<td class="'+sClass+'" data-days="' + oStartDt.getDate() + '"><span class="day">' + oStartDt.getDate() + '</span><span class="cnt"></span></td>');
               oStartDt.setDate(oStartDt.getDate() + 1);

               if(i % 7 == 6) {
                    arrTable.push('</tr>');
                    if(m_oMonth.getMonth() != oStartDt.getMonth()) {
                         break;
                    }
               }
          }
          arrTable.push('</tbody></table>');

          $('#calendar').html(arrTable.join(""));

          that.changeMonth();
     }

    /* Next, Prev 버튼 이벤트 */
     this.initEvent = function() {
          $('.prevBtn').click(that.onPrevCalendar);
          $('.nextBtn').click(that.onNextCalendar);
          $('.year').click(that.onYearCalendar);
     }
     
     this.onYearCalendar = function(e){
    	 e.preventDefault();
    	 m_oMonth.setYear($(this).val());
    	 that.renderCalendar();
    	 getData();
     }
     
    /* 이전 달력 */
     this.onPrevCalendar = function(e) {
    	  e.preventDefault();
          m_oMonth.setMonth(m_oMonth.getMonth() - 1);
          that.renderCalendar();
          getData();
     }

    /* 다음 달력 */
     this.onNextCalendar = function(e) {
    	  e.preventDefault();
    	  var c_oMonth = new Date(m_oMonth);
    	  if(s_oMonth < c_oMonth.setMonth(c_oMonth.getMonth() + 1)) return;
          m_oMonth.setMonth(m_oMonth.getMonth() + 1);
          that.renderCalendar();
          getData();
     }

    /* 달력 이동되면 상단에 현재 년 월 다시 표시 */
     this.changeMonth = function() {
          $('#currentDate').text(that.getYearMonth(m_oMonth).substr(0,9));
     }
     
    /* 날짜 객체를 년 월 문자 형식으로 변환 */
     this.getYearMonth = function(oDate) {
    	  $('.year').val($.format.date(oDate, 'yyyy'));
    	  $('.month').val($.format.date(oDate, 'MM'));
          return (oDate.getMonth() + 1) + '월';
     }
}