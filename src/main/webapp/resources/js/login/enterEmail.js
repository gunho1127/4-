const form = document.getElementById("login-form");

const errorElement = document.getElementById("email-error");
const clearIcon = document.getElementById("clear-icon");
const submitButton = document.getElementById("start-button");

form.addEventListener("submit", async (event) => {         
    event.preventDefault(); // 폼 기본 제출 동작 방지            

    const idInput = document.getElementById("id").value.trim();
    let message = ""; // 메세지 초기화
    

    let plag = false; // TRUE 일 때 폼이 제출됩니다.
    let loginTypeCheck = false; // TRUE 일 때 폼이 제출됩니다.                        

    // 아무 값도 입력하지 않았을 때
    if (idInput == '') {
        
        message = "이메일을 입력하지 않았습니다.";                        
        showError(message);            
    } 

    // 입력 유효성 검사에서 벗어났을 때
    else if (idInput !== '' && !validateEmail(idInput)) {
        
        message = "올바른 이메일 형식이 아닙니다.";                            
        showError(message);
    }
    else {
        plag = true;        
    }
    
    // else if (idInput !== '' && validateEmail(idInput)) {
    //     alert("이메일 형식이 올바릅니다."); // 이메일 형식이 올바른 경우 알림
    //     plag = true;
    // }


    // 네이버 회원 체크
    if (!loginTypeCheck && plag==true) {
        // alert("네이버 회원 체크를 시작합니다."); // 네이버 회원 체크 시작 알림
        try {
            const url = `/login/loginTypeCheck?id=${encodeURIComponent(idInput)}`;
            // alert("URL 요청: " + url); // 요청 URL 알림
            const response = await fetch(url, {
                method: "GET",
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            // alert("서버 응답 데이터: " + JSON.stringify(data)); // 서버 응답 알림
            loginTypeCheck = data.isNaver; // 서버에서 네이버 회원 여부 반환

            if (loginTypeCheck) {
                // alert("네이버 회원입니다."); // 네이버 회원일 때 알림
                message = "소셜 가입자입니다. 네이버로 로그인하세요.";
                showError(message);
            } else {
                // alert("네이버 회원이 아닙니다."); // 네이버 회원이 아닐 때 알림
                loginTypeCheck = true; // 네이버 회원이 아닌 경우
            }
        } catch (error) {
            console.error("AJAX 요청 중 오류 발생:", error);
            //alert("서버 요청 중 오류가 발생했습니다."); // 오류 발생 시 알림
            //message = "서버와의 통신 중 문제가 발생했습니다.";
            //showError(message);            
        }
    }                    

    if (plag && loginTypeCheck) {
        // alert("모든 검사를 통과하여 폼이 제출됩니다."); // 폼 제출 조건이 충족되었음을 알림
        form.submit(); // 폼 제출
    }
});

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

// X 아이콘 클릭 시 입력값 비우기
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
