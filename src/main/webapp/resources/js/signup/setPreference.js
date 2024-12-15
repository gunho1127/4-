document.addEventListener("DOMContentLoaded", () => {
    const usernameInput = document.getElementById("username");
    const verifyButton = document.getElementById("verify-button");
    const usernameError = document.getElementById("username-error");
    const categoriesInput = document.getElementById("categories");
    const submitButton = document.getElementById("submit-button");
    const categoryError = document.getElementById('category-error');
    const clearIcon = document.getElementById('clear-icon');
    const badges = document.querySelectorAll('.badge');
    const resetButton = document.getElementById('reset-button');

    let isUsernameVerified = false; // 활동명 중복 확인 여부

    // 활동명 유효성 검사 함수
    function validateUsername(username) {
        const regex = /^[가-힣a-zA-Z]{2,10}$/;
        return regex.test(username);
    }

    // 활동명 중복 확인 버튼 클릭 이벤트
    verifyButton.addEventListener("click", async () => {
        const username = usernameInput.value.trim();
        clearError(usernameError);
        isUsernameVerified = false; // 중복 확인 상태 초기화

        if (!username) {
            showError(usernameError, "활동명을 입력하세요.");
            return;
        }
        if (!validateUsername(username)) {
            showError(usernameError, "활동명은 2 ~ 10자이며 한글과 영문만 입력 가능합니다.");
            return;
        }

        try {
            const response = await fetch("/signup/checkUsername", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `username=${encodeURIComponent(username)}`,
            });

            const isDuplicate = await response.json();

            if (isDuplicate) {
                showError(usernameError, "이미 사용중인 활동명입니다.");
            } else {
                showError(usernameError, "사용 가능한 활동명입니다.", false);
                isUsernameVerified = true;
            }
            usernameError.style.display = "block";
        } catch (error) {
            showError(usernameError, "활동명 중복 확인 중 문제가 발생했습니다.");
        }
    });

    // 오류 메시지 처리 함수
    function showError(errorElement, message, isError = true) {
        errorElement.classList.remove("success", "error");
        errorElement.textContent = message;
        errorElement.style.display = "block";
        // 에러 상태에 따라 클래스 추가
        if (isError) {
            errorElement.classList.add("error");
        } else {
            errorElement.classList.add("success");
        }
        errorElement.errorTimeout = setTimeout(() => {
            clearError(errorElement);
        }, 3000);
    }

    function clearError(errorElement) {
        errorElement.textContent = ''; // 텍스트 초기화
        errorElement.style.display = 'none'; // 오류 메시지 숨기기
    }

    // X 아이콘 클릭 시 입력값 지우기
    if (clearIcon) {
        clearIcon.addEventListener('click', () => {
            usernameInput.value = ''; // 입력값 비우기
            usernameInput.focus(); // 입력 필드 포커스 유지
            isUsernameVerified = false; // 중복 확인 초기화
            clearError(usernameError); // 메시지 숨기기
        });
    }

    // 입력값이 있을 때 X 아이콘 보이기
    if (usernameInput) {
        usernameInput.addEventListener('input', function () {
            clearIcon.style.display = this.value ? 'block' : 'none';
        });
    }

    // 배지 클릭 이벤트
    if (badges.length > 0) {
        badges.forEach(badge => {
            badge.addEventListener('click', () => {
                clearError(categoryError); // 초기화

                const selectedBadges = document.querySelectorAll('.badge[data-selected="true"]');

                // 선택 상태 토글
                if (badge.dataset.selected === "true") {
                    badge.dataset.selected = "false";
                } else if (selectedBadges.length < 3) {
                    badge.dataset.selected = "true";
                } else {
                    showError(categoryError, "최대 3개까지만 선택할 수 있습니다.");
                    return;
                }

                badge.classList.toggle('selected', badge.dataset.selected === "true");

                // 선택된 카테고리를 JSON 배열로 변환
                const selectedCategories = Array.from(document.querySelectorAll('.badge[data-selected="true"]'))
                    .map(badge => badge.dataset.category);

                // 숨겨진 필드에 선택된 카테고리 저장
                categoriesInput.value = JSON.stringify(selectedCategories);
            });
        });
    }

    // 배지 초기화 버튼 클릭 이벤트
    if (resetButton) {
        resetButton.addEventListener('click', () => {
            badges.forEach(badge => {
                badge.dataset.selected = "false";
                badge.classList.remove('selected');
            });
            categoriesInput.value = JSON.stringify([]);
            clearError(categoryError);
        });
    }

    // 폼 제출 시 카테고리 값 검증
//    if (submitButton) {
        submitButton.addEventListener("click", async (event) => {
            event.preventDefault();

            let hasError = false;

            clearError(usernameError);
            clearError(categoryError);

            const categories = categoriesInput.value;
            const username = usernameInput.value.trim();

            if (!categories || JSON.parse(categories).length === 0) {
                showError(categoryError, "카테고리를 최소 1개 이상 선택하세요.");
                hasError = true;
            }
            // 활동명 중복 확인 여부 검증
            if (!isUsernameVerified) {
                showError(usernameError, "활동명 중복 여부를 확인하세요.");
                hasError = true;
               }
            if (hasError) {
                return; // 폼 제출 방지
            }

            try {
                const response = await fetch("/signup/setPreference", {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: `username=${encodeURIComponent(username)}&categories=${encodeURIComponent(categories)}`,
                });

                if (response.ok) {
                    alert("회원가입을 완료했습니다!\n메인 페이지로 이동합니다.");
                    window.location.href = "/";
                } else {
                    const result = await response.text();
                    showError(categoryError, result);
                }
            } catch (error) {
                showError(categoryError, "사용자 정보 저장 중 문제가 발생했습니다.");
            }
        });
//    }
});
