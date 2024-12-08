document.getElementById('transcription-from').addEventListener('submit', function (event) {
    event.preventDefault(); // 폼 제출 방지
  
    const sentence = document.getElementById('transcriptionSentence');
    const content = document.getElementById('transcriptionContent');
    const date = document.getElementById('transcriptionDate');
  
    const sentenceError = document.getElementById('transcriptionSentence-exception-field');
    const contentError = document.getElementById('transcriptionContent-exception-field');
    const dateError = document.getElementById('transcriptionDate-exception-field');
  
    let isValid = true;
  
    // 초기화
    sentenceError.innerHTML = '';
    contentError.innerHTML = '';
    dateError.innerHTML = '';
  
    // 필사 문장 검증
    if (!sentence.value.trim()) {
      sentenceError.innerHTML = '을 입력해주세요.';
      isValid = false;
    } else if (sentence.value.length > 100) {
      sentenceError.innerHTML = '은 100자를 넘을 수 없습니다.';
      isValid = false;
    }
  
    // 나의 생각 검증
    if (!content.value.trim()) {
      contentError.innerHTML = '을 입력해주세요.';
      isValid = false;
    } else if (content.value.length > 100) {
      contentError.innerHTML = '은 100자를 넘을 수 없습니다.';
      isValid = false;
    }
  
    // 날짜 검증
    const datePattern = /^\d{4}-\d{2}-\d{2}$/;
    if (!date.value.trim()) {
      dateError.innerHTML = '를 입력해주세요.';
      isValid = false;
    } else if (!datePattern.test(date.value)) {
      dateError.innerHTML = '는 YYYY-MM-DD 형태로 입력해주세요.';
      isValid = false;
    }
  
    // 모든 검증 통과 시 폼 제출
    if (isValid) {
      this.submit();
    }
  });
  