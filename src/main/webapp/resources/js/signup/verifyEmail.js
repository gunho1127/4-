    const verifyButton = document.getElementById("verify-button");
    const submitButton = document.getElementById("start-button"); // 스타트 버튼을 submitButton으로 변경
    
    const errorElement = document.getElementById("verification-error");
    
    const timerElement = document.getElementById("timer");

    const clearIcon = document.getElementById("clear-icon");

    const verifyEmailMsg = document.getElementById("verify-email-msg"); // 인증코드 발송 메시지


    // 재전송을 하면, 이 부분도 새로 초기화 해줘야 합니다.
    let verificationCode = document.getElementById("verificationCode").value;

    let codeField = document.getElementById("verification-code");

    const signupButton = document.getElementById("signup-button");


    let timerInterval;
    let verifyCheck = false;

    startTimer(60);

    // 타이머 시작
    function startTimer(duration) {
        let timeRemaining = duration;

        if (timerInterval) clearInterval(timerInterval);

        timerInterval = setInterval(() => {
            const minutes = Math.floor(timeRemaining / 60);
            const seconds = timeRemaining % 60;
            timerElement.textContent = `${minutes}:${seconds < 10 ? "0" : ""}${seconds}`;
            timeRemaining--;

            if (timeRemaining < 0) {
                clearInterval(timerInterval);
                switchToResendButton(); // 인증코드 만료 후 버튼 변경
            }
        }, 1000);
    }

    // 확인 버튼을 재전송 버튼으로 변경
    function switchToResendButton() {
        verificationCode = "NULL : : !";
        verifyButton.textContent = "재발송";
        showError("인증번호가 만료되었습니다.", true);
        verifyButton.classList.remove("btn-primary");
        verifyButton.classList.add("btn-warning");
        verifyButton.disabled = false;
    }

    // 확인 버튼으로 복귀
    function switchToVerifyButton() {
        verifyButton.textContent = "확인";
        verifyButton.classList.remove("btn-warning");
        verifyButton.classList.add("btn-primary");
        verifyButton.disabled = false;
    }

    

    // 인증코드 확인 버튼 클릭 시
    function verifyChecking() {
    
        const code = document.getElementById("verification-code").value.trim();
        if (verifyButton.textContent === "재발송") {            
            location.reload(true);
            return;
        }

        // 인증코드가 비어 있으면 예외 메시지 표시
        if (!code) {
            showError("인증번호를 입력하지 않았습니다.", true);
            return;
        }        
        
        if(verificationCode == code) {
            verifyCheck = true;                   
            showError("인증을 성공했습니다.", false);
        }
        else { showError("유효한 인증번호가 아닙니다.", true); }
                                
    };
    
    // 입력란에 값이 있을 때 클리어 아이콘 보이기
    codeField.addEventListener("input", () => {        
        clearIcon.style.display = codeField.value ? "block" : "none";
    });


    // 클리어 아이콘 클릭 시 입력란 초기화
    clearIcon.addEventListener("click", () => {
        
        codeField.value = "";
        clearIcon.style.display = "none";
    });


    

    // 오류 메시지 표시 함수
    function showError(message, isError) {
        errorElement.textContent = message;
        errorElement.style.display = "block";
        errorElement.style.color = isError ? "#DA1E28" : "#0F62FE";
        // setTimeout(() => {
        //     errorElement.style.display = "none";
        // }, 3000);
    }

    // 예외 처리 함수
    function handleException(message, error) {
        console.error(message, error);
        showError(`${message}: ${error.message}`, true);
    }

    

// 인증번호 입력란에 포커스가 가면 클리어 아이콘 보이기
document.getElementById('verification-code').addEventListener('focus', () => {
    const clearIcon = document.getElementById('clear-icon');
    clearIcon.style.display = 'block'; // 포커스 시 클리어 아이콘 보이기
});

// 인증번호 입력란에 포커스가 벗어나면 클리어 아이콘 숨기기
document.getElementById('verification-code').addEventListener('blur', () => {
    const clearIcon = document.getElementById('clear-icon');
    if (document.getElementById('verification-code').value === '') {
        clearIcon.style.display = 'none'; // 입력란이 비어있으면 클리어 아이콘 숨기기
    }
});


document.getElementById("verify-form").addEventListener("submit", function(event) {
     
        if (!verifyCheck) {
            codeField            
            showError("인증번호를 인증하지 않았습니다.", true);
            event.preventDefault(); // 폼 제출 방지
        } else {
            // 폼 제출
        }
    });