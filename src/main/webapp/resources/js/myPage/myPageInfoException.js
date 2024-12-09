document.addEventListener("DOMContentLoaded", () => {
  let isNameChecked = false; // 이름 중복 검사 여부를 추적하는 변수
  let isNameUnique = false; // 중복되지 않은 이름 여부를 추적하는 변수

  // 이름 중복 검사 버튼 클릭 시
  document.getElementById("checkUsernameButton").addEventListener("click", () => {
    const username = document.getElementById("name").value;

    // AJAX 요청 생성
    fetch(`/myPage/checkUsername?username=${encodeURIComponent(username)}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    })
    .then(response => response.json())
    .then(data => {
      
      if (data.exists) {
        isNameUnique = true;
        isNameChecked = true;
        document.getElementById("name-exception-field").innerHTML = "사용 가능한 활동명 입니다.";
        document.getElementById("name-exception-field").style.color = "blue";
        
      } else {
        isNameUnique = false;
        document.getElementById("name-exception-field").innerHTML = "중복된 활동명 입니다.";
      }
    })
    .catch(error => console.error('Error:', error));
    
  });

  // 폼 검증을 수행하는 함수
  function validateForm() {
    const form = document.querySelector("#myInfo"); // ID가 myInfo인 폼 요소 선택
    const profileImageInput = document.querySelector("#profileImagePathForm");
    const nameInput = document.querySelector("#name");
    const pwInput = document.querySelector("#pw");
    const pwCheckInput = document.querySelector("#pw-check");

    let isValid = true; // 초기 상태는 유효함

    // 프로필 이미지 검증
    if (!validateProfileImage(profileImageInput.files[0])) {
      isValid = false;
    }

    // 이름 검증
    if (!validateName(nameInput.value)) {
      isValid = false;
    }

    // 비밀번호 검증
    if (!validatePassword(pwInput.value)) {
      isValid = false;
    }

    // 비밀번호 확인 검증
    if (!validatePasswordConfirmation(pwInput.value, pwCheckInput.value)) {
      isValid = false;
    }

    // 모든 검증이 통과되면 폼 제출
    if (isValid && isNameChecked && isNameUnique) {
      form.submit(); // 폼 제출
    } else {
      if (!isNameChecked) {
        document.getElementById("name-exception-field").textContent = "중복 검사 버튼을 눌러주세요.";
        document.getElementById("name-exception-field").style.color = "red";
      }
      console.log("폼 제출 실패: 유효성 검증 오류");
    }
  }

  // 프로필 이미지 검증 함수
  function validateProfileImage(file) {
    if (file && !file.name) {
      return false;
    }

    const allowedExtensions = ["jpg", "png"];
    const maxSizeMB = 2;

    if (file) {
      const fileName = file.name.toLowerCase();
      const fileExtension = fileName.split(".").pop();
      if (!allowedExtensions.includes(fileExtension)) {
        document.getElementById("profile-exception-field").textContent = "JPG 또는 PNG 파일만 업로드 가능합니다.";
        return false;
      }

      if (file.size > maxSizeMB * 1024 * 1024) {
        document.getElementById("profile-exception-field").textContent = `파일 용량은 ${maxSizeMB}MB 이하여야 합니다.`;
        return false;
      }

      document.getElementById("profile-exception-field").textContent = "";
      return true;
    }

    document.getElementById("profile-exception-field").textContent = "";
    return true;
  }

  // 이름 검증 함수
  function validateName(name) {
    if (name.trim() === "") {
      
      document.getElementById("name-exception-field").textContent = "활동명을 입력해주세요.";
      document.getElementById("name-exception-field").style = "color = red";
      return false;
    }

    const nameRegex = /^[a-zA-Z가-힣]{1,10}$/;
    if (!nameRegex.test(name)) {
      document.getElementById("name-exception-field").textContent = "활동명은 한글 또는 영어 10글자 이내로 작성해주세요.";
      return false;
    }

    document.getElementById("name-exception-field").textContent = "";
    return true;
  }

  // 비밀번호 검증 함수
  function validatePassword(password) {
    if (password.trim() === "") {
      document.getElementById("pw-exception-field").textContent = "비밀번호를 입력해주세요.";
      return false;
    }

    const pwRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/;
    if (!pwRegex.test(password)) {
      document.getElementById("pw-exception-field").textContent = "영문, 숫자, 특수문자를 혼용하여 8~20자로 작성해주세요.";
      return false;
    }

    document.getElementById("pw-exception-field").textContent = "";
    return true;
  }

  // 비밀번호 확인 검증 함수
  function validatePasswordConfirmation(password, passwordConfirmation) {
    if (passwordConfirmation.trim() === "") {
      document.getElementById("pw-check-exception-field").textContent = "비밀번호 확인을 입력해주세요.";
      return false;
    }

    if (password !== passwordConfirmation) {
      document.getElementById("pw-check-exception-field").textContent = "비밀번호가 일치하지 않습니다.";
      return false;
    }

    document.getElementById("pw-check-exception-field").textContent = "";
    return true;
  }

  // 폼 제출 이벤트 리스너 추가
  const form = document.querySelector("#myInfo");
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // 기본 폼 제출 동작 방지
    validateForm(); // 폼 검증 함수 호출
  });
});
