//document.addEventListener("DOMContentLoaded", () => {
//    const sliders = document.querySelectorAll(".post-slider"); // 모든 슬라이더 선택
//
//    sliders.forEach(slider => {
//        const postGrid = slider.querySelector(".post-grid");
//        const prevBtn = slider.querySelector(".slider-btn.prev");
//        const nextBtn = slider.querySelector(".slider-btn.next");
//        const postCards = slider.querySelectorAll(".post-card");
//
//        // 컨테이너 및 카드 크기 계산
//        const sliderWidth = slider.clientWidth; // 슬라이더 컨테이너 너비
//        const cardWidth = postCards[0].offsetWidth  + 10 ; // 카드 너비
//        const visibleCards = Math.floor(sliderWidth / cardWidth); // 한 화면에 표시할 카드 개수
//        const totalCards = postCards.length;
//
//        let currentIndex = 0;
//
//        function updateSlider() {
//            const translateX = -(currentIndex * cardWidth);  // 슬라이드 이동 거리
//            postGrid.style.transform = `translateX(${translateX}px)`; // 이동
//        }
//
//        prevBtn.addEventListener("click", () => {
//            if (currentIndex > 0) {
//                currentIndex -= visibleCards; // 화면에 보이는 카드만큼 이동
//                if (currentIndex < 0) currentIndex = 0; // 범위 초과 방지
//                updateSlider();
//            }
//        });
//
//        nextBtn.addEventListener("click", () => {
//            if (currentIndex + visibleCards < totalCards) {
//                currentIndex += visibleCards; // 화면에 보이는 카드만큼 이동
//                if (currentIndex + visibleCards > totalCards) {
//                    currentIndex = totalCards - visibleCards; // 마지막 슬라이드 조정
//                }
//                updateSlider();
//            }
//        });
//
//        // 초기 슬라이더 위치 업데이트
//        updateSlider();
//    });
//});
//
//    // 게시글 클릭 시 URL로 이동
//    const postItems = document.querySelectorAll(".post-item, .post-card");  // .post-card와 .post-item을 모두 클릭 대상으로 추가
//
//    postItems.forEach(item => {
//        item.addEventListener("click", function() {
//            const postId = this.getAttribute("data-post-id");
//            const postType = this.getAttribute("data-post-type");
//
//            let url;
//
//            // type에 따라 URL 결정
//            if (postType === "커뮤니티") {
//                url = `/community/viewPost/${postId}`;
//            } else {
//                url = `/search/total/book/detail/${postId}`;
//            }
//
//            // URL로 이동
//            window.location.href = url;
//        });
//    });
//});
//

document.addEventListener("DOMContentLoaded", function() {
    // 슬라이더 기능
    const sliders = document.querySelectorAll(".post-slider"); // 모든 슬라이더 선택

    sliders.forEach(slider => {
        const postGrid = slider.querySelector(".post-grid");
        const prevBtn = slider.querySelector(".slider-btn.prev");
        const nextBtn = slider.querySelector(".slider-btn.next");
        const postCards = slider.querySelectorAll(".post-card");

        // 컨테이너 및 카드 크기 계산
        const sliderWidth = slider.clientWidth; // 슬라이더 컨테이너 너비
        const cardWidth = postCards[0].offsetWidth + 10; // 카드 너비
        const visibleCards = Math.floor(sliderWidth / cardWidth); // 한 화면에 표시할 카드 개수
        const totalCards = postCards.length;

        let currentIndex = 0;

        function updateSlider() {
            const translateX = -(currentIndex * cardWidth);  // 슬라이드 이동 거리
            postGrid.style.transform = `translateX(${translateX}px)`; // 이동
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

    // 게시글 클릭 시 URL로 이동
    const postItems = document.querySelectorAll(".post-item, .post-card");  // .post-card와 .post-item을 모두 클릭 대상으로 추가

    postItems.forEach(item => {
        item.addEventListener("click", function() {
            const postId = this.getAttribute("data-post-id");
            const postType = this.getAttribute("data-post-type");

            if (!postId || !postType) {
                console.error("postId 또는 postType이 설정되지 않았습니다.");
                return; // postId 또는 postType이 없으면 종료
            }

            let url;

            // type에 따라 URL 결정
            if (postType === "커뮤니티") {
                url = `/community/viewPost/${postId}`;
            } else {
                url = `/search/total/book/detail/${postId}`;
            }

            // URL로 이동
            window.location.href = url;
        });
    });
});
