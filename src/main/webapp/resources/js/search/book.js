const bookMarkHandle = () => {
  const bm = $(".bookMark");

  bm.on("click", function () {
    let _this = $(this); // 현재 클릭한 북마크 버튼
    let bookId = _this.data("id"); // 북마크 버튼에 저장된 책 ID
    let cookie = getCookie("bookMark" + bookId); // 쿠키에서 현재 책의 북마크 상태 확인

    if (cookie == null) {
      // 북마크 추가 (쿠키 생성)
      setCookie("bookMark" + bookId, bookId, 1);
      _this.children("img").attr(
        "src",
        "../../../resources/images/book/book_mark_on.png"
      ); // 활성화 아이콘으로 변경
    } else {
      // 북마크 삭제 (쿠키 제거)
      deleteCookie("bookMark" + bookId);
      _this.children("img").attr(
        "src",
        "../../../resources/images/book/book_mark_off.png"
      ); // 비활성화 아이콘으로 변경
    }
  });
};

