document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("login-form");
    const idInput = document.getElementById("id");
    const errorElement = document.getElementById("email-error");
    const clearIcon = document.getElementById("clear-icon");
    const submitButton = document.getElementById("start-button");

    form.addEventListener("submit", async (event) => {
        event.preventDefault();

        const id = idInput.value.trim();
        if (!id) return showError("이메일을 입력하지 않았습니다.");
        if (!validateEmail(id)) return showError("올바른 이메일 형식이 아닙니다.");

        clearError();
        submitButton.disabled = true;

        try {
            const data = await fetchJson('/login/enterEmail', { id });

            if (data.error) {
                // 서버에서 전달받은 에러 메시지 출력
                showError(data.error);
            } else if (data.isRegistered) {
                // 등록된 이메일
                window.location.href = '/login/enterPassword';
            } else if (data.canSendVerification) {
                // 인증코드 발송
                await sendVerificationCode(id);
            } else {
                showError("유효한 이메일 주소가 아닙니다. 다시 입력하세요.");
            }
        } catch (error) {
            showError("서버와 통신 중 오류가 발생했습니다. 다시 시도하세요.");
        } finally {
            submitButton.disabled = false;
        }
    });

    // 유효성 검사 함수
    function validateEmail(id) {
        const emailRegex = /^(?!.*\.\.)(?!\.)[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
        return emailRegex.test(id);
    }

    // 인증코드 발송 함수
    async function sendVerificationCode(id) {
        try {
            await fetchJson('/send-verification-code', { id });
            window.location.href = '/signup/verifyEmail';
        } catch {
            showError("인증코드 발송 중 오류가 발생했습니다. 다시 시도하세요.");
        }
    }

    // 오류 메시지 처리 함수
    function showError(message) {
        errorElement.textContent = message;  // 오류 메시지 설정
        errorElement.style.display = 'block'; // 요소 보이기
        setTimeout(() => {
            clearError(); // 3초 후 clearError 호출
        }, 3000);
    }

    function clearError() {
        errorElement.textContent = ''; // 텍스트 초기화
        errorElement.style.display = 'none'; // 오류 메시지 숨기기
    }

    // X 아이콘 클릭 시 입력값 비우기
    clearIcon.addEventListener("click", () => {
        idInput.value = "";
        clearIcon.style.display = "none";
        clearError();
    });

    idInput.addEventListener("input", () => {
        clearIcon.style.display = idInput.value ? "block" : "none";
    });
/*
    // 네이버 로그인 초기화
    const naverLogin = new naver.LoginWithNaverId({
        clientId: "YOUR_CLIENT_ID", // 발급받은 Client ID
        callbackUrl: "http://yourdomain.com/callback", // 설정한 콜백 URL
        isPopup: false, // 팝업 형태로 로그인 진행 여부
        loginButton: {color: "green", type: 3, height: 40} // 버튼 스타일
    });

    naverLogin.init();

    // 네이버 로그인 버튼 클릭 시 이벤트
    document.getElementById("naver-login").addEventListener("click", (event) => {
        event.preventDefault(); // 기본 동작 방지
    });

    // 네이버 로그인 처리 함수
    async function handleNaverLogin() {
        const user = naverLogin.getProfileData();
        const id = user.id;

        try {
            const data = await fetchJson('/verifyEmail', { id });

            if (data.isRegistered) {
                window.location.href = '/index';
            } else {
                await fetchJson('/login/register-naver', { id });
                window.location.href = '/signup/setPreferences';
            }
        } catch {
            showError("네이버 로그인 처리 중 문제가 발생했습니다.");
        }
    }
    */
});

// 공통 fetch 함수
async function fetchJson(url, body) {
    console.log("전송 데이터:", body); // 요청 데이터 확인
    try {
        const response = await fetch('/login/enterEmail', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(body),
        });

        console.log("응답 상태 코드:", response.status); // 상태 코드 확인
        if (!response.ok) {
            throw new Error('서버 응답 오류');
        }

        return await response.json();
    } catch (error) {
        throw new Error("서버와의 연결에 문제가 발생했습니다. 다시 시도해주세요.");
    }
}
