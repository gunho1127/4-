// 이메일을 URL 파라미터로 받아오기
window.onload = function() {
    const email = new URLSearchParams(window.location.search).get('email');
    if (email) {
        document.getElementById('id').value = email;
    }
};

// 공통 fetch 함수
async function fetchJson(url, body) {
    const response = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
    });

    if (!response.ok) throw new Error();
    return response.json();
}

// 타이머 설정
let timerInterval;
function startTimer() {
    let timeRemaining = 300; // 5분 (300초)

    if (timerInterval) {
        clearInterval(timerInterval);  // 기존 타이머 초기화
    }

    timerInterval = setInterval(() => {
        const minutes = Math.floor(timeRemaining / 60);
        const seconds = timeRemaining % 60;
        document.getElementById('timer').textContent = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
        timeRemaining--;  // 시간 감소

        if (timeRemaining < 0) {
            clearInterval(timerInterval);
            showError("인증코드 유효 시간이 초과되었습니다. 다시 요청하세요.");
            document.getElementById('verification-section').disabled = true;
            document.getElementById('signup-button').disabled = false;
            toggleVerifyButton(true);
        }
    }, 1000);
}

// 인증코드 확인 버튼 동작
document.getElementById('verify-button').addEventListener('click', async () => {
    const button = document.getElementById('verify-button');
    const code = document.getElementById('verification-code').value.trim();

    // 인증코드가 비어 있으면 예외 메시지 표시
    if (!code) {
        showError("인증코드를 입력하지 않았습니다.", true);
        return;
    }

    // 인증코드가 숫자가 아닌 값일 경우 예외 처리
    if (!/^\d+$/.test(code)) {
        showError("인증코드는 숫자만 입력 가능합니다.", true);
        return;
    }

    if (button.textContent === "재발송") {
        // 이메일 재발송 버튼이 클릭된 경우
        const email = document.getElementById('id').value.trim();
        clearError();

        try {
            // 이메일 발송 API 호출
            const data = await fetchJson('/check-email', { email });

            if (data.canSendVerification) {
                startTimer();  // 타이머 시작
                toggleVerifyButton(false); // 확인 버튼으로 되돌리기
                document.getElementById('verify-email-msg').style.display = 'block';
            } else {
                showError("이메일 발송에 실패했습니다. 다시 시도해주세요.");
            }
        } catch (error) {
            showError("이메일 발송 중 문제가 발생했습니다. 다시 시도하세요.");
        }
    } else {
        // 기존 동작: 인증코드 확인
        try {
            const data = await fetchJson('/verify-code', { code });

            if (data.isValid) {
                // 인증코드가 유효하면 회원가입 버튼 활성화
                document.getElementById('signup-button').disabled = false;
                showError("인증코드가 유효합니다.");
                toggleVerifyButton(true); // 확인 버튼에서 회원가입 버튼으로 변경
            } else {
                showError("인증코드가 유효하지 않습니다. 다시 입력하세요.");
            }
        } catch {
            showError("인증코드 확인 중 문제가 발생했습니다. 다시 시도하세요.");
        }
    }
});

// 확인 버튼을 이메일 재발송 버튼으로 변경하는 함수
function toggleVerifyButton(isResend) {
    const verifyButton = document.getElementById('verify-button');

    if (isResend) {
        verifyButton.textContent = "재발송";  // 버튼 텍스트를 재발송으로 변경
    } else {
        verifyButton.textContent = "확인";  // 버튼 텍스트를 확인으로 변경
    }
}

// 회원가입 버튼 클릭 시 처리
document.getElementById('signup-button').addEventListener('click', async (event) => {
    const verificationCode = document.getElementById('verification-code').value.trim();

    // 인증번호가 비어있으면 오류 메시지 표시
    if (!verificationCode) {
        showError("인증번호 확인을 먼저 해주세요.");
        return; // 인증번호가 없으면 함수 종료
    }

    // 인증번호가 유효한지 확인
    const isValid = await checkVerificationCode(verificationCode);  // 유효성 검증 함수 호출
    if (!isValid) {
        showError("인증번호 확인이 완료되지 않았습니다.");
        return;  // 인증번호가 유효하지 않으면 회원가입 진행 안함
    }

    // 인증번호가 유효하면 회원가입 처리
    try {
        console.log("회원가입 진행 중...");
        // 실제 회원가입 처리 (예: form.submit() 또는 API 호출)
    } catch (error) {
        showError("회원가입 중 문제가 발생했습니다.");
    }
});

// 공통 오류 메시지 표시 함수
function showError(message, isVerificationError = false) {
    const errorElement = isVerificationError
        ? document.getElementById('verification-error')  // 인증 관련 오류 메시지
        : document.getElementById('verification-msg');   // 일반 오류 메시지

    errorElement.textContent = message;
    errorElement.style.display = 'block';  // 오류 메시지 표시
}

// 인증번호 유효성 검증 함수 (예시)
async function checkVerificationCode(code) {
    try {
        const response = await fetch('/verify-code', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ code })
        });
        const data = await response.json();
        return data.isValid;  // 인증번호 유효성 반환
    } catch (error) {
        showError("인증번호 확인 중 문제가 발생했습니다. 다시 시도하세요.");
        return false;
    }
}

// 인증번호 입력칸 초기화 버튼 동작
document.getElementById('clear-icon').addEventListener('click', () => {
    const verificationCodeInput = document.getElementById('verification-code');
    verificationCodeInput.value = ''; // 입력란을 비움
    verificationCodeInput.focus(); // 다시 포커스
    document.getElementById('clear-icon').style.display = 'none'; // 클리어 아이콘 숨기기
});

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
