// 엔터 키를 눌렀을 때 실행될 동작
      
      // 컨트롤러로 요청 전송
      // /myPage/myGoals/search URL 전송
      

      // 컨트롤러에서 요청 받아서 네이버 keyword를 추출하여 원하는 정보 API를 통해 검색
      // JSON 형태로 받는다.

      // JSON 형태로 받아서 모달 창에 다시 뿌려주는 작업.
      // 원하는 JSP 에 페이지 새로고침 없이 비동기적으로 JSON List를
      // 원하는 요소 값에 반복적으로 뿌려줄 수 있는 작업.


      
      function search(event) {
        // 엔터 키를 눌렀는지 확인
        if (event.key === "Enter") {
            // 입력 필드의 값을 가져오기
            const keyword = document.querySelector('#keyword').value;
    
            // URLSearchParams 객체를 사용하여 쿼리 매개변수 생성
            const params = new URLSearchParams({ keyword: keyword });
    
            // 컨트롤러로 요청 전송
            fetch(`/myPage/myGoals/search?${params.toString()}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => response.json())
            .then(data => {
                // JSON 형태로 받아서 모달 창에 다시 뿌려주는 작업
                if (data.length > 0) {
                    // 검색 결과가 있는 경우 모달에 표시
                    
                    showResultsInModal(data);
                }
            })
            .catch(error => {
                // 요청 중 오류가 발생한 경우 알림
                console.error('Error:', error);
            });
        }
    }
    
      
      
      // 모달에 JSON 데이터를 표시하는 함수
      function showResultsInModal(data) {
        // 모달 콘텐츠 영역을 선택하고 기존 내용을 초기화
        const bookList = document.querySelector('.book-list');
        bookList.innerHTML = '';
      
        // 받아온 데이터를 반복하여 새로운 요소 생성
        data.forEach(item => {
          const itemElement = document.createElement('div');
          itemElement.classList.add('book-item');
          itemElement.innerHTML = `
            <img src="${item.bookImageUrl}" alt="${item.bookTitle}" class="book-image">
            <div class="book-info">
              <div class="title">${item.bookTitle}</div>
              <div class="author">${item.author}</div>
            </div>
            <input type="hidden" name="bookId" value="${item.bookId}">
            <button class="select-button" onclick="selectGoal(${JSON.stringify(item).replace(/"/g, '&quot;')})">선택하기</button>
                    `;
          // 생성된 요소를 bookList에 추가
          bookList.appendChild(itemElement);
        });
      
        // 모달을 표시
        const modal = document.querySelector('#modal-modal');
        modal.style.display = 'flex';
      }

function selectGoal(item) {
    
    // 프론트 페이지로 item의 정보들을 넘겨주기
    document.getElementById("bookId").value=item.bookId;
    document.getElementById("bookTitle").value=item.bookTitle;
    document.getElementById("author").value=item.author;
    document.getElementById("bookImageUrl").value=item.bookImageUrl;

    document.getElementById("modal-modal").style.display = "none";
}

function openModal() {
    document.getElementById("modal-modal").style.display = "flex";
  }

  function closeModal(event) {
    if (event.target.id === "modal-modal") {
      document.getElementById("modal-modal").style.display = "none";
    }
  }