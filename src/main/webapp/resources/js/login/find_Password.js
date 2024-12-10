document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("find-password-form");
    const idInput = document.getElementById("id");
    const errorElement = document.getElementById("error-message");
    const submitButton = document.getElementById("reset-password-button");
    const popup = document.getElementById("popup-message");
    const popupText = document.getElementById("popup-text");
    const popupButton = document.getElementById("popup-button");

    // 폼 제출 처리
    form.addEventListener("submit", async (event) => {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        const id = idInput.value.trim(); // 입력된 이메일
        if (!id) {
            return showError("이메일을 입력하지 않았습니다."); // 입력값 확인
        }

        clearError(); // 기존 오류 메시지 초기화

        try {
            const response = await fetchJson("/login/findPassword", { id });

            if (response.success) {
                showPopup("임시 비밀번호가 이메일로 발송되었습니다.");
                // 일정 시간 후 페이지 이동
                setTimeout(() => navigateToPasswordPage(), 5000); // 5초
            } else {
                showError(response.error || "이메일 발송 오류가 발생했습니다. 다시 시도하세요.");
            }
        } catch (error) {
            showError("서버와 통신 중 오류가 발생했습니다. 다시 시도하세요.");
        }
    });

    // 팝업 표시 함수
    function showPopup(message) {
        popupText.textContent = message; // 팝업 메시지 설정
        popup.style.display = "flex"; // 팝업 보이기
    }

     // 팝업 닫기 버튼 동작
     popupButton.addEventListener("click", () => {
         popup.style.display = "none";
         window.location.href = "/login/enterPassword";
     });

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

    // 공통 fetch 함수
    async function resetPassword(id) {
        const response = await fetch('/login/findPassword', {
            method: 'POST', // 반드시 POST 방식
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id }) // JSON 데이터 전송
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        return await response.json();
    }
});
