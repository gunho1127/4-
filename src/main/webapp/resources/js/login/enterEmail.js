const form = document.getElementById("login-form");
const errorElement = document.getElementById("email-error");
const clearIcon = document.getElementById("clear-icon");
const submitButton = document.getElementById("start-button");
const naverButton = document.getElementById("naver-button");
const idInput = document.getElementById("id").value;

//// 공통된 이메일 유효성 검사 및 서버 확인 함수
//async function handleEmailValidation() {
//    const idInputValue = idInput.value.trim();
//
//    console.log('이메일 값:', idInputValue);  // 이메일 값 확인
//
//    // 이메일 입력 여부 확인
//    if (!idInputValue) {
//        showError("이메일을 입력하지 않았습니다.");
//        return { valid: false };
//    }
//
//    // 이메일 형식 확인
//    if (!validateEmail(idInputValue)) {
//        showError("올바른 이메일 형식이 아닙니다.");
//        return { valid: false };
//    }
//
//    // 서버에 이메일 확인 요청
//    try {
//        const url = `/login/loginTypeCheck?id=${encodeURIComponent(idInputValue)}`;
//        const response = await fetch(url, { method: "GET" });
//
//        if (!response.ok) {
//            throw new Error("AJAX 요청 실패");
//        }
//
//        const data = await response.json();
//        console.log("Server Response:", data); // 서버 응답 확인
//        return { valid: true, data }; // 유효성 검사 통과 및 서버 데이터 반환
//    } catch (error) {
//        console.error("AJAX 요청 중 오류 발생:", error);
//        showError("서버와의 통신 중 문제가 발생했습니다. 다시 시도해주세요.");
//        return { valid: false };
//    }
//}
//
//// 서브밋 버튼 동작
//form.addEventListener("submit", async (event) => {
//    event.preventDefault(); // 폼 기본 제출 동작 방지
//
//    const validation = await handleEmailValidation();
//    if (!validation.valid) return;
//
//    // 일반 사용자는 폼 제출
//    if (!validation.data.isNaver) {
//        form.submit();
//    } else {
//        showError("네이버 계정으로 가입한 사용자입니다. 네이버 로그인으로 진행하세요.");
//    }
//});
//
//naverButton.addEventListener("click", async () => {
//    const validation = await handleEmailValidation();
//    if (!validation.valid) return;
//
//    console.log("validation data:", validation.data);
//
//    // 네이버 로그인 사용자 처리
//    if (validation.data.isNaver) {
//        window.location.href = "/login/naver";
//    } else {
//        showError("일반 계정으로 가입한 사용입니다. 시작하기 버튼을 눌러 진행하세요.");
//    }
//});

//// 네이버 로그인 버튼 동작
//naverButton.addEventListener("click", async () => {
//    const idInputValue = idInput.value.trim();
//
//    console.log('이메일 값:', idInputValue); // 이메일 값 확인
//
//    // 이메일 입력 여부 확인
//    if (!idInputValue) {
//        showError("이메일을 입력하지 않았습니다.");
//        return;
//    }
//
//    // 서버에 이메일 확인 요청
//    const validation = await handleEmailValidation();
//    if (!validation.valid) return;
//
//    console.log("Validation data:", validation.data); // 추가된 디버깅 메시지
//
//    // 네이버 로그인 처리
//    try {
//        if (validation.data.isNaver) {
//            // 네이버 가입자라면 네이버 로그인 리디렉션
//            window.location.href = "/login/naver";
//        } else {
//            // 로컬 가입자 또는 비회원 확인
//            const userCheckUrl = `/login/getUserById?id=${encodeURIComponent(idInputValue)}`;
//            const userResponse = await fetch(userCheckUrl, { method: "GET" });
//            if (!userResponse.ok) throw new Error("사용자 조회 요청 실패");
//
//            const userData = await userResponse.json();
//            console.log("User data:", userData); // 사용자 데이터 확인
//
//            if (userData.exists) {
//                // 로컬 가입자인 경우 예외 문구 출력
//                showError("일반 계정으로 가입한 사용자입니다. 시작하기 버튼을 눌러 진행하세요.");
//            } else {
//                // 비회원이라면 네이버 로그인 리디렉션
//                window.location.href = "/login/naver";
//            }
//        }
//    } catch (error) {
//        console.error("네이버 로그인 처리 중 오류 발생:", error);
//        showError("서버와의 통신 중 문제가 발생했습니다.");
//    }
//});

form.addEventListener("submit", async (event) => {
    event.preventDefault(); // 폼 기본 제출 동작 방지

    const idInput = document.getElementById("id").value.trim();
    if (!idInput) {
        showError("이메일을 입력하지 않았습니다.");
        return;
    }

    if (!validateEmail(idInput)) {
        showError("올바른 이메일 형식이 아닙니다.");
        return;
    }

    try {
        const url =`/login/loginTypeCheck?id=${encodeURIComponent(idInput)}`;
        const response = await fetch(url, { method: "GET" });

        if (!response.ok) {
            throw new Error("AJAX 요청 실패");
        }

        const data = await response.json();
        if (data.isNaver) {
            showError("네이버 계정으로 가입한 사용자입니다. 네이버 로그인으로 진행하세요.");
        } else {
            form.submit(); // 폼 제출
        }
    } catch (error) {
        console.error("AJAX 요청 중 오류 발생:", error);
    }
});

// 네이버 로그인 버튼 클릭 이벤트 처리
//document.getElementById("naver-button").addEventListener("click", () => {
//    window.location.href = "/login/naver";
//});

naverButton.addEventListener("click", async () => {
    const idInput = document.getElementById("id").value.trim();

    if (!idInput) {
        showError("이메일을 입력하지 않았습니다.");
        return;
    }

    if (!validateEmail(idInput)) {
        showError("올바른 이메일 형식이 아닙니다.");
        return;
    }

    try {
        const url =`/login/loginTypeCheck?id=${encodeURIComponent(idInput)}`;
        const response = await fetch(url, { method: "GET" });

        if (!response.ok) {
            throw new Error("AJAX 요청 실패");
        }

        const data = await response.json();
        console.log("Server Response:", data); // 디버깅 메시지

         if (!data.exists || data.isNaver) {
            window.location.href = "/login/naver"; // 네이버 로그인 리디렉션
        } else {
            // 일반 사용자
            showError("일반 계정으로 가입한 사용자입니다. 시작하기 버튼을 눌러 진행하세요.");
        }
    } catch (error) {
        // AJAX 요청 오류 처리
        console.error("AJAX 요청 중 오류 발생:", error);
        showError("서버와의 통신 중 문제가 발생했습니다. 다시 시도해주세요.");
    }
});

/*
form.addEventListener("submit", async (event) => {
    event.preventDefault(); // 폼 기본 제출 동작 방지

    const idInput = document.getElementById("id").value.trim();
    let message = ""; // 메세지 초기화
    let plag = false;
    let loginTypeCheck = false;

    if (idInput == '') {
        message = "이메일을 입력하지 않았습니다.";
        showError(message);
    }
    else if (idInput !== '' && !validateEmail(idInput)) {
        message = "올바른 이메일 형식이 아닙니다.";
        showError(message);
    }
    else {
        plag = true;
    }

    // 네이버 회원 체크
    if (!loginTypeCheck && plag == true) {
        try {
            const url = `/login/loginTypeCheck?id=${encodeURIComponent(idInput)}`;
            const response = await fetch(url, {
                method: "GET",
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const data = await response.json();
            loginTypeCheck = data.isNaver; // 서버에서 네이버 회원 여부 반환

            if (loginTypeCheck) {
                message = "네이버 계정으로 가입한 사용자입니다. 네이버 로그인으로 진행하세요.";
                showError(message);
            } else {
                loginTypeCheck = true; // 네이버 회원이 아닌 경우
            }
        } catch (error) {
            console.error("AJAX 요청 중 오류 발생:", error);
        }
    }

    if (plag && loginTypeCheck) {
        form.submit(); // 폼 제출
    }
});
*/

// 유효성 검사 함수
function validateEmail(id) {
    const emailRegex = /^(?!.*\.\.)(?!\.)[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
    return emailRegex.test(id);
}

// 오류 메시지 처리 함수
function showError(message) {
    errorElement.innerHTML = message;  // 오류 메시지 설정
    setTimeout(() => {
        clearError(); // 3초 후 clearError 호출
    }, 3000);
}

// 클리어 아이콘 클릭 시 입력값 비우기
clearIcon.addEventListener("click", () => {
    idInput.value = "";
    clearIcon.style.display = "none";
    clearError();
});

function clearError() {
    errorElement.textContent = ''; // 텍스트 초기화
}

idInput.addEventListener("input", () => {
    clearIcon.style.display = idInput.value ? "block" : "none";
});


//document.getElementById("naver-button").addEventListener("click", async () => {
//    try {
//        const response = await fetch("/login/naver"); // 네이버 로그인 URL 요청
//        if (!response.ok) {
//            throw new Error("네이버 로그인 URL 요청 실패");
//        }
//        window.location.href = response.url; // 서버의 리디렉션 처리
//    } catch (error) {
//        console.error("네이버 로그인 요청 중 오류:", error);
//        alert("네이버 로그인 요청 중 문제가 발생했습니다. 다시 시도해주세요.");
//    }
//});


