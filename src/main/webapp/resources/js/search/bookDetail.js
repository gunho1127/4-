// const isCookieSet = () => {
//   const bookId = $("#bookDetail").data("id"); // 현재 페이지의 책 ID
//   const bookFav = $(".bookFav"); // 찜 버튼
//
//   let cookie = getCookie("bookMark" + bookId); // 쿠키에서 현재 책의 북마크 상태 확인
//
//   if (cookie == bookId) {
//     // 북마크 상태일 경우 찜 활성화
//     bookFav.html("&#9829;").css({
//       color: "var(--color-0f62fe)", // 하트 색상 변경
//       background: "none", // 배경 제거
//     });
//   } else {
//     // 북마크 상태가 아닐 경우 찜 비활성화
//     bookFav.html("&#x2661;").css({
//       color: "var(--color-0f62fe)", // 하트 색상 설정
//       background: "none", // 배경 제거
//     });
//   }
//
//   // 클릭 이벤트 추가
//   bookFav.on("click", function () {
//     let cookie = getCookie("bookMark" + bookId);
//
//     if (cookie == null) {
//       // 북마크 추가
//       setCookie("bookMark" + bookId, bookId, 1);
//       bookFav.html("&#9829;").css({
//         color: "var(--color-0f62fe)", // 하트 색상 변경
//         background: "none", // 배경 제거
//       });
//     } else {
//       // 북마크 삭제
//       deleteCookie("bookMark" + bookId);
//       bookFav.html("&#x2661;").css({
//         color: "var(--color-0f62fe)", // 하트 색상 설정
//         background: "none", // 배경 제거
//       });
//     }
//   });
// };

$(document).ready(function () {
  isCookieSet(); // 쿠키 체크 후 찜 처리
  setupImageToggle(); // 상세 이미지 더보기/접기 기능
  setupImageModal(); // 이미지 클릭 시 모달 열기/닫기 기능
});

let pageNum;


const isCookieSet = () => {
  const bookId = $("#bookDetail").data("id"); // 현재 페이지의 책 ID
  const bookFav = $(".bookFav"); // 찜 버튼

  let cookie = getCookie("bookMark" + bookId); // 쿠키에서 현재 책의 북마크 상태 확인

  if (cookie == bookId) {
    // 북마크 상태일 경우 찜 활성화
    bookFav.html("찜&#9829;").css({
      color: "var(--color-white)",
      background: "var(--color-0f62fe)",
    });
  } else {
    // 북마크 상태가 아닐 경우 찜 비활성화
    bookFav.html("찜&#x2661;").css({
      color: "var(--color-0f62fe)",
      background: "var(--color-white)",
    });
  }

  // 클릭 이벤트 추가
  bookFav.on("click", function () {
    let cookie = getCookie("bookMark" + bookId);

    if (cookie == null) {
      // 북마크 추가
      setCookie("bookMark" + bookId, bookId, 1);
      bookFav.html("찜&#9829;").css({
        color: "var(--color-white)",
        background: "var(--color-0f62fe)",
      });
    } else {
      // 북마크 삭제
      deleteCookie("bookMark" + bookId);
      bookFav.html("찜&#x2661;").css({
        color: "var(--color-0f62fe)",
        background: "var(--color-white)",
      });
    }
  });
};

/**
 * 상세 이미지 더보기/접기 기능
 */
const setupImageToggle = () => {
  const toggleButton = document.getElementById("toggleButton");
  const hiddenImages = document.getElementById("hiddenImages");

  let isExpanded = false;

  toggleButton.addEventListener("click", function () {
    if (isExpanded) {
      hiddenImages.style.height = "150px"; // 축소
      toggleButton.textContent = " 상세 이미지 더보기 ";
    } else {
      hiddenImages.style.height = "auto"; // 확장
      toggleButton.textContent = " 상세 이미지 접기 ";
    }
    isExpanded = !isExpanded;
  });
};

/**
 * 이미지 클릭 시 모달 열기/닫기 기능
 */
const setupImageModal = () => {
  document.querySelectorAll(".clickable-image").forEach((image) => {
    image.addEventListener("click", function () {
      const modal = document.getElementById("imageModal");
      const modalImg = document.getElementById("modalImage");

      modal.style.display = "flex";
      modalImg.src = this.src; // 클릭된 이미지 경로 설정
    });
  });

  document.querySelector(".close").addEventListener("click", function () {
    const modal = document.getElementById("imageModal");
    modal.style.display = "none"; // 모달 숨기기
  });
};
