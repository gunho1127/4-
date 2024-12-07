function previewProfileImage() {
  const fileInput = document.getElementById('profileImagePathForm');
  const preview = document.getElementById('profilePreview');
  const hiddenInput = document.getElementById('profileImagePath');

  if (fileInput.files && fileInput.files[0]) {
      const reader = new FileReader();

      reader.onload = function (e) {
          preview.src = e.target.result; // 선택한 파일을 미리보기로 표시
          document.getElementById('profilePathTest').innerHTML = fileInput.files[0].name;
      };

      reader.readAsDataURL(fileInput.files[0]);

      // 파일 선택 시 hidden input을 비워야 함
      hiddenInput.value = "";
  }
}

function deleteProfilePreview(event) {
  if (event) {
      event.preventDefault();
  }

  const defaultImagePath = "../../../resources/images/myPage/icon-jam-icons-outline-logos-user1.svg";
  const preview = document.getElementById('profilePreview');
  const hiddenInput = document.getElementById('profileImagePath');

  // 기본 이미지로 되돌림
  preview.src = defaultImagePath;
  hiddenInput.value = defaultImagePath;
  document.getElementById('profilePathTest').innerHTML=defaultImagePath;
}

// 이벤트 리스너 등록
document.getElementById('deleteProfileLink').addEventListener('click', deleteProfilePreview);

function showPw() {
  const pwToggle = document.getElementById('pwToggle');
  const pw = document.getElementById('pw');
  const pwCheck = document.getElementById('pw-check');

  if (pw.type === "password") {
      // 비밀번호가 숨겨져 있을 때
      pw.type = "text";
      pwCheck.type = "text";
      pwToggle.innerHTML = "숨기기";
  } else {
      // 비밀번호가 보일 때
      pw.type = "password";
      pwCheck.type = "password";
      pwToggle.innerHTML = "보기";
  }
}


