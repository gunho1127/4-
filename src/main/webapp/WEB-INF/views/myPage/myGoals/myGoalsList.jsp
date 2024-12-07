<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>리플렛 - 내 목표</title>

      <link rel="stylesheet" href="../../../../../resources/css/myPage/myGolasListstyle.css">
      <link rel="stylesheet" href="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.css">

      <style>
        a,
        button,
        input,
        select,
        h1,
        h2,
        h3,
        h4,
        h5,
        h6,
        * {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
          border: none;
          text-decoration: none;
          background: none;
          -webkit-font-smoothing: antialiased;
        }

        menu,
        ol,
        ul {
          list-style-type: none;
          margin: 0;
          padding: 0;
        }        
      </style>
    </head>

    <body>
      <div class="div">
        <!-- Navigation -->
        <jsp:include page="/WEB-INF/views/includes/mypagenav/myPageNav.jsp" />
        <!-- End of Navigation -->

        <div class="page-content">
          <!-- Calendar Section -->
          <div class="table">
            <div class="header">
              <div class="div4">
                <span>
                  <span class="div-4-span">캘린더<br></span>
                  <span class="div-4-span2">목표를 설정하면 캘린더에 일정이 등록됩니다 !</span>
                </span>
              </div>
            </div>

            <div class="table2">
              <div class="calendar-controls">
                <button id="prevMonth">저번 달</button>
                <span id="currentMonth" class="current-month"></span>
                <button id="nextMonth">다음 달</button>
              </div>
              <div class="calendar" id="calendar"></div>
            </div>
          </div>

          <!-- Goal Book Section -->
          <div class="table3">
            <div class="header2">
              <div class="auto-layout-vertical2">
                <div class="div5">
                  <span>
                    <span class="div-5-span">목표 도서<br></span>
                    <span class="div-5-span2">목표를 설정하고 독서 습관을 길러보아요 !<br>좌우로 스크롤 할 수 있습니다.</span>
                  </span>
                </div>
              </div>
              <a href="/myPage/myGoals/AddBooks">
                <div class="type-primary-size-large-status-enable">
                  <div class="button">도서 추가</div>
                </div>
              </a>
            </div>

            <div class="auto-layout-horizontal">
              <div class="frame-2">
                <!-- Book Card Views -->
                <div class="auto-layout-horizontal4">
                  <c:forEach var="goal" items="${goalList}">
                    <a href="/myPage/myGoals/bookInfo?id=${goal.id}&bookId=${goal.bookId}">
                      <div class="book-card-view">
                        <img class="style-square" src="${goal.bookImageUrl}" />
                        <div class="auto-layout-vertical3">
                          <div class="div6">
                            <span>
                              <span class="div-6-span">${goal.bookTitle}<br></span>
                              <span class="div-6-span2">${goal.author}</span>
                            </span>
                          </div>
                          <div class="div7" data-pages-read="${goal.pagesRead}" data-total-page="${goal.totalPage}">
                          </div>
                        </div>
                      </div>
                      <br><br>
                    </a>
                  </c:forEach>
                </div>
                <!-- End of Book Card Views -->
              </div>
            </div>
          </div>
        </div>
      </div>

      <script src="../../../../resources/js/myPage/myGoalsList.js" defer></script>
      <script src="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.js"></script>

      <script>
        document.addEventListener('DOMContentLoaded', function () {

          // 캘린더 초기화
          const calendar = new tui.Calendar('#calendar', {
            defaultView: 'month',
            taskView: false,
            scheduleView: ['allday'],
            useCreationPopup: false,
            useDetailPopup: false,
            isReadOnly: true,
            collapseDuplicateEvents: false
          });


          // 현재 월 표시
          const currentMonthElement = document.getElementById('currentMonth');

          // 캘린더 인스턴스가 이미 초기화되어 있다고 가정
          const currentDate = calendar.getDate();

          function updateCurrentMonth() {
            // 현재 년도와 월을 가져옴

            const currentDate = calendar.getDate();

            const year = currentDate.getFullYear();
            const month = currentDate.getMonth() + 1; // 월은 0부터             
            currentMonthElement.innerHTML = year + '년 ' + month + '월';
          }

          // 월 탐색을 위한 이벤트 리스너
          document.getElementById('prevMonth').addEventListener('click', function () {
            calendar.prev();
            updateCurrentMonth();
          });

          document.getElementById('nextMonth').addEventListener('click', function () {
            calendar.next();
            updateCurrentMonth();
          });

          // JSP 데이터를 사용하여 일정 생성 및 추가
          const schedules = [];
          const backgroundColors = [
            '#2C3E50',  // 다크 블루
            '#4A4A4A',  // 진한 회색
            '#3B3B98',  // 어두운 파란색
            '#5D6D7E',  // 청회색
            '#283747',  // 짙은 남색
            '#1A1A2E',  // 어두운 보라색
            '#1B4F72',  // 다크 블루
            '#2E4053',  // 진한 청록색
            '#34495E'   // 블루-그레이
          ];
          let i = 0;

          <c:forEach var="goal" items="${goalList}">

            schedules.push({
              id: '${goal.bookId}',
            calendarId: '1',
            title: '${goal.bookTitle}',
            category: 'allday',
            dueDateClass: '',
            start: '${goal.startDate}T00:00:00',
            end: '${goal.goalDate}T23:59:59',
            isReadOnly: true,
            color : 'white',
            backgroundColor: (i < backgroundColors.length) ? backgroundColors[i++] : (i = 0, backgroundColors[i++])
              });
          </c:forEach>

          // 일정 캘린더에 추가
          calendar.createEvents(schedules);

          // 초기화 시 현재 월 업데이트
          updateCurrentMonth();
        });

        
      </script>

    </body>

    </html>