document.addEventListener("DOMContentLoaded", function () {
    const searchForm = document.getElementById("searchForm");
    const searchInput = document.getElementById("searchInput");
    const searchButton = document.getElementById("searchButton");
  
    // 검색 버튼 클릭 이벤트
    searchButton.addEventListener("click", function () {
      performSearch();
    });
  
    // Enter 키 이벤트 처리
    searchForm.addEventListener("submit", function (event) {
      event.preventDefault(); // 기본 폼 제출 동작 방지
      performSearch();
    });
  
    // 검색 실행 함수
    function performSearch() {
      const keyword = searchInput.value.trim(); // 검색어 입력값
  
      if (!keyword) {
        alert("검색어를 입력해주세요."); // 검색어가 없을 때 경고
        return;
      }
  
      // 검색 결과 페이지로 이동
      window.location.href = `../../../search/searchMain.html?keyword=${encodeURIComponent(
        keyword
      )}`;
    }
  });  