document.addEventListener('DOMContentLoaded', () => {
  const div7Elements = document.querySelectorAll('.div7');

  div7Elements.forEach(div7 => {
    const pagesRead = parseInt(div7.getAttribute('data-pages-read'), 10);
    const totalPage = parseInt(div7.getAttribute('data-total-page'), 10);

    if (isNaN(pagesRead) || isNaN(totalPage) || totalPage === 0) {
      return; // 데이터가 올바르지 않으면 계산하지 않음
    }

    // 진행률 계산
    const progress = (pagesRead / totalPage) * 100;

    // 진행률에 따른 색상 설정 함수
    function getColorFromProgress(progress) {
      if (progress <= 24) {
        return '#d9d9d9'; // 회색
      } else if (progress <= 49) {
        return '#a0c4e4'; // 옅은 파란색
      } else if (progress <= 74) {
        return '#6592e8'; // 중간 파란색
      } else {
        return '#2a6cb1'; // 진한 파란색
      }
    }

    // 막대의 길이 설정 (최소 5% 길이를 보여줌)
    const width = progress <= 5 ? 5 : progress;

    // 디버깅용 확인
    console.log(`pagesRead: ${pagesRead}, totalPage: ${totalPage}, progress: ${progress}%, width: ${width}rem`);

    // div7의 스타일 조정
    div7.style.background = getColorFromProgress(progress);
    div7.style.width = `${width}%`;
  });
});


//달력 부분


// document.addEventListener('DOMContentLoaded', function() {
//     const calendar = new tui.Calendar('#calendar', {
//         defaultView: 'month',
//         useCreationPopup: false,
//         useDetailPopup: false,
//         isReadOnly: true // 읽기 전용 모드로 설정
//     });

//     const currentMonthElement = document.getElementById('currentMonth');

//     function updateCurrentMonth() {
//         const viewDate = calendar.getDate();
//         const year = viewDate.getFullYear();
//         const month = viewDate.getMonth() + 1; // 월은 0부터 시작하므로 +1
//         currentMonthElement.textContent = `${year}년 ${month}월`;
//     }

//     document.getElementById('prevMonth').addEventListener('click', function() {
//         calendar.prev();
//         updateCurrentMonth();
//     });

//     document.getElementById('nextMonth').addEventListener('click', function() {
//         calendar.next();
//         updateCurrentMonth();
//     });

//     // 초기화 시 현재 월 업데이트
//     updateCurrentMonth();
// });


