// 아이디 입력칸에서 x 아이콘 클릭 시 입력값 지우기
document.getElementById('clear-icon').addEventListener('click', () => {
  const input = document.getElementById('id');
  input.value = ''; // 입력값 비우기
  input.focus(); // 입력 필드 포커스 유지
  document.getElementById('clear-icon').style.display = 'none'; // x 아이콘 숨기기
});

// 입력값이 있을 때 x 아이콘 보이기
document.getElementById('id').addEventListener('input', function() {
  const clearIcon = document.getElementById('clear-icon');
  if (this.value) {
      clearIcon.style.display = 'block'; // 입력값이 있으면 x 아이콘 보이기
  } else {
      clearIcon.style.display = 'none'; // 입력값이 없으면 x 아이콘 숨기기
  }
});

document.querySelectorAll('.badge').forEach(badge => {
  badge.addEventListener('click', () => {
      const selectedBadges = document.querySelectorAll('.badge[data-selected="true"]');

      // 최대 3개 제한
      if (badge.dataset.selected === "true") {
          badge.dataset.selected = "false";
      } else if (selectedBadges.length < 3) {
          badge.dataset.selected = "true";
      }
  });
});

// 폼 제출 이벤트
document.querySelector('.username-form').addEventListener('submit', (event) => {
  event.preventDefault();

  const nickname = document.getElementById('username').value.trim();
  if (!nickname) {
    alert('활동자명을 입력해주세요.');
    return;
  }

  const selectedGenres = Array.from(document.querySelectorAll('.checkbox-group input[type="checkbox"]:checked'))
    .map(checkbox => checkbox.value);

  if (selectedGenres.length === 0) {
    alert('최소 1개의 장르를 선택해주세요.');
    return;
  }

  alert(`활동자명: ${nickname}\n선호 장르: ${selectedGenres.join(', ')}\n회원가입 완료!`);
});
