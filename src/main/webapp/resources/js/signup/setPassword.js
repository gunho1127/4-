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
    
        if (password.length==0) {
            passwordError.textContent = '';
            passwordError.style.display = 'block';
            isValid = false;
        } else {
            passwordError.style.display = 'none';
        }

        // 비밀번호가 8자 이상 20자 이하인지 체크
        if (password.length < 8 || password.length > 20) {
            passwordError.textContent = '비밀번호는 8자 이상 20자 이하로 입력해주세요.';
            passwordError.style.display = 'block';
            isValid = false;
        } else {
            passwordError.style.display = 'none';
        }
    
        // 특수문자 포함 여부 체크
        const specialCharacterRegex = /[!@#$%^&*(),.?":{}|<>]/;
        if (!specialCharacterRegex.test(password)) {
            passwordError.textContent = '비밀번호에는 특수문자가 포함되어야 합니다.';
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
        // passwordField.value = '';
        // clearIconPassword.style.display = 'none'; // 클리어 아이콘 숨기기
        validatePassword(); // 유효성 검사 다시 실행
    });

    clearIconConfirmPassword.addEventListener('click', () => {
        // confirmPasswordField.value = '';
        // clearIconConfirmPassword.style.display = 'none'; // 클리어 아이콘 숨기기
        validatePassword(); // 유효성 검사 다시 실행
    });

    // 비밀번호 입력란에 값이 있으면 클리어 아이콘 보이기
    passwordField.addEventListener('input', () => {
        // if (passwordField.value) {
        //     clearIconPassword.style.display = 'block';
        // } else {
        //     clearIconPassword.style.display = 'none';
        // }
        validatePassword(); // 유효성 검사 실행
    });

    // 비밀번호 확인 입력란에 값이 있으면 클리어 아이콘 보이기
    confirmPasswordField.addEventListener('input', () => {
        // if (confirmPasswordField.value) {
        //     clearIconConfirmPassword.style.display = 'block';
        // } else {
        //     clearIconConfirmPassword.style.display = 'none';
        // }
        validatePassword(); // 유효성 검사 실행
    });

// 비밀번호 토글 버튼 기능
    document.querySelector('#toggle-password').addEventListener('click', () => {
    const passwordField = document.getElementById('password'); // 비밀번호 입력 필드
    const passwordConfirmField = document.getElementById('password-confirm'); // 비밀번호 입력 필드
    const img = document.getElementById('toggle-password').src; // 열린 눈 이미지
    

    // 비밀번호 보이기/숨기기 처리
    if (passwordField.type === 'password') {
        passwordField.type = 'text'; // 비밀번호를 텍스트로 표시
        passwordConfirmField.type = 'text'; // 비밀번호를 텍스트로 표시
        img = "../../../resources/images/signup/closed-eye-icon.png";
    } else {
        passwordField.type = 'password'; // 비밀번호를 패스워드로 표시
        passwordConfirmField.type = 'password'; // 비밀번호를 패스워드로 표시
        img = "../../../resources/images/signup/open-eye-icon.png";
    }
});

    // 폼 제출 시 유효성 검사 후 서버로 데이터 전송
    const form = document.getElementById('password-form');
    form.addEventListener('submit', function (event) {
        

        if (!validatePassword()) {
            event.preventDefault(); // 폼의 기본 제출 동작을 막음
        }
        else { // 입력 폼 제출
            }

        
    });
});