document.addEventListener('DOMContentLoaded', function () {
    // 비밀번호 필드와 확인 필드 가져오기
    const passwordField = document.getElementById('password');
    const confirmPasswordField = document.getElementById('password-confirm');
    const passwordError = document.getElementById('password-error');
    const confirmPasswordError = document.getElementById('confirm-password-error');
    const clearIconPassword = document.getElementById('clear-icon');
    const clearIconConfirmPassword = document.getElementById('clear-icon-confirm');
    const togglePassword = document.getElementById('toggle-password');
    const toggleConfirmPassword = document.getElementById('toggle-confirm-password');

    // 비밀번호 유효성 검사 및 일치 여부 확인
    function validatePassword() {
        const password = passwordField.value;
        const confirmPassword = confirmPasswordField.value;

        let isValid = true;

        // 비밀번호가 8자 이상 20자 이하인지 체크
        if (password.length < 8 || password.length > 20) {
            passwordError.textContent = '비밀번호는 8자 이상 20자 이하로 입력해주세요.';
            passwordError.style.display = 'block';
            isValid = false;
        } else {
            passwordError.style.display = 'none';
        }

        // 비밀번호 확인란과 일치 여부 확인
        if (password !== confirmPassword) {
            confirmPasswordError.textContent = '비밀번호가 일치하지 않습니다.';
            confirmPasswordError.style.display = 'block';
            isValid = false;
        } else {
            confirmPasswordError.style.display = 'none';
        }

        return isValid;
    }

    // 클리어 아이콘 클릭 시 입력값 지우기
    clearIconPassword.addEventListener('click', () => {
        passwordField.value = '';
        clearIconPassword.style.display = 'none'; // 클리어 아이콘 숨기기
        validatePassword(); // 유효성 검사 다시 실행
    });

    clearIconConfirmPassword.addEventListener('click', () => {
        confirmPasswordField.value = '';
        clearIconConfirmPassword.style.display = 'none'; // 클리어 아이콘 숨기기
        validatePassword(); // 유효성 검사 다시 실행
    });

    // 비밀번호 입력란에 값이 있으면 클리어 아이콘 보이기
    passwordField.addEventListener('input', () => {
        if (passwordField.value) {
            clearIconPassword.style.display = 'block';
        } else {
            clearIconPassword.style.display = 'none';
        }
        validatePassword(); // 유효성 검사 실행
    });

    // 비밀번호 확인 입력란에 값이 있으면 클리어 아이콘 보이기
    confirmPasswordField.addEventListener('input', () => {
        if (confirmPasswordField.value) {
            clearIconConfirmPassword.style.display = 'block';
        } else {
            clearIconConfirmPassword.style.display = 'none';
        }
        validatePassword(); // 유효성 검사 실행
    });

// 비밀번호 토글 버튼 기능
document.querySelector('#toggle-password').addEventListener('click', () => {
    const passwordField = document.getElementById('password'); // 비밀번호 입력 필드
    const openEyeImg = document.querySelector('.open-eye-img'); // 열린 눈 이미지
    const closedEyeImg = document.querySelector('.closed-eye-img'); // 감춰진 눈 이미지

    // 비밀번호 보이기/숨기기 처리
    if (passwordField.type === 'password') {
        passwordField.type = 'text'; // 비밀번호를 텍스트로 표시
        openEyeImg.style.display = 'block'; // 열린 눈 이미지 보이기
        closedEyeImg.style.display = 'none'; // 감춰진 눈 이미지 숨기기
    } else {
        passwordField.type = 'password'; // 비밀번호를 다시 숨기기
        openEyeImg.style.display = 'none'; // 열린 눈 이미지 숨기기
        closedEyeImg.style.display = 'block'; // 감춰진 눈 이미지 보이기
    }
});

    // 폼 제출 시 유효성 검사 후 서버로 데이터 전송
    const form = document.getElementById('password-form');
    form.addEventListener('submit', function (event) {
        event.preventDefault(); // 폼의 기본 제출 동작을 막음

        if (!validatePassword()) {
            return; // 유효성 검사 실패 시 아무 동작도 하지 않음
        }

        // 유효성 검사 통과 시 폼 데이터를 서버로 전송 (AJAX)
        const formData = new FormData(form); // 폼 데이터 가져오기

        fetch('/회원가입-서버-처리-경로', {  // 실제 서버 처리 URL로 변경해야 함
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            const errorMessageElement = document.getElementById('server-error-message'); // 오류 메시지를 표시할 요소

            if (data.success) {
                // 서버에서 회원가입 성공 응답을 받으면 취향 설정 페이지로 이동
                window.location.href = '/setPreferences'; // 취향 설정 페이지로 이동
            } else {
                // 서버 응답에서 에러가 발생한 경우
                errorMessageElement.textContent = data.message || '회원가입 중 오류가 발생했습니다.';
                errorMessageElement.style.display = 'block'; // 오류 메시지를 보이게 설정
            }
        })
        .catch(error => {
            console.error('서버와의 통신 오류:', error);

            const errorMessageElement = document.getElementById('server-error-message');
            errorMessageElement.textContent = '서버와의 통신 중 문제가 발생했습니다.';
            errorMessageElement.style.display = 'block'; // 오류 메시지를 보이게 설정
        });
    });
});