document.addEventListener("DOMContentLoaded", () => {
    const sliders = document.querySelectorAll(".post-slider"); // 모든 슬라이더 선택

    sliders.forEach(slider => {
        const postGrid = slider.querySelector(".post-grid");
        const prevBtn = slider.querySelector(".slider-btn.prev");
        const nextBtn = slider.querySelector(".slider-btn.next");
        const postCards = slider.querySelectorAll(".post-card");

        // 컨테이너 및 카드 크기 계산
        const sliderWidth = slider.clientWidth; // 슬라이더 컨테이너 너비
        const cardWidth = postCards[0].offsetWidth + 10; // 카드 너비 + 간격
        const visibleCards = Math.floor(sliderWidth / cardWidth); // 한 화면에 표시할 카드 개수
        const totalCards = postCards.length;

        let currentIndex = 0;

        function updateSlider() {
            const translateX = -(currentIndex * cardWidth);
            postGrid.style.transform = `translateX(${translateX}px)`;
        }

        prevBtn.addEventListener("click", () => {
            if (currentIndex > 0) {
                currentIndex -= visibleCards; // 화면에 보이는 카드만큼 이동
                if (currentIndex < 0) currentIndex = 0; // 범위 초과 방지
                updateSlider();
            }
        });

        nextBtn.addEventListener("click", () => {
            if (currentIndex + visibleCards < totalCards) {
                currentIndex += visibleCards; // 화면에 보이는 카드만큼 이동
                if (currentIndex + visibleCards > totalCards) {
                    currentIndex = totalCards - visibleCards; // 마지막 슬라이드 조정
                }
                updateSlider();
            }
        });

        // 초기 슬라이더 위치 업데이트
        updateSlider();
    });
});
