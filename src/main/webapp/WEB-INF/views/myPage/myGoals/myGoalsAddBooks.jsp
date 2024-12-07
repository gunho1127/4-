<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
      <link rel="stylesheet" href="../../../../resources/css/myPage/myGoalsAddBooks.css">
      <link rel="stylesheet" href="../../../../resources/css/myPage/myGoalsAddBooksModal.css">
      <link rel="stylesheet" href="../../../resources/css/myPage/exceptionstyle.css">


      <style>
        a,
        button,
        input,
        select,
        h1,
        h2,
        h3,
        h4,
        h5,
        * {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
          border: none;
          text-decoration: none;
          background: none;
          -webkit-font-smoothing: antialiased;
        }

        menu,
        ol,
        ul {
          list-style-type: none;
          margin: 0;
          padding: 0;
        }

        /* 모달 스타일 */
        #modal-modal {
          display: none;
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.5);
          z-index: 1000;
          justify-content: center;
          align-items: center;
        }

        #modal-modal .group-148-modal {
          background: #fff;
          padding: 20px;
          border-radius: 10px;
          width: 90%;
          max-width: 700px;
          box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
          display: flex;
          flex-direction: column;
          align-items: center;
          /* 중앙 정렬 */
          max-height: 80vh;
          /* 최대 높이를 설정하여 스크롤 가능 영역을 만듦 */
          overflow-y: auto;
          /* 스크롤 기능 추가 */
        }

        #modal-modal .group-148-modal .label-modal {
          font-weight: bold;
          margin-bottom: 5px;
        }

        #modal-modal .group-148-modal .field-modal {
          display: flex;
          justify-content: center;
          /* 정 가운데 정렬 */
          width: 100%;
          /* 필요 시 너비 조정 */
        }

        .row {
          background-color: #f2f4f8;
        }
        
      </style>

      <title>리플렛 - 목표 추가</title>
    </head>

    <body>

      <div class="container-fluid">
        <div class="row">
          <!-- 불변 영역 -->
          <div class="col-auto sidebar d-flex flex-column align-items-start p-0">
            <jsp:include page="/WEB-INF/views/includes/mypagenav/myPageNav.jsp" />
          </div>

          <!-- 가변 영역 -->
          <div class="col content p-4">
            <!-- 가변 콘텐츠 -->
            <div class="page-content">
              <div class="table">
                <div class="form">
                  <div class="section-text">
                    <br>
                    <div class="top">
                      <div class="secondary-headline">목표 추가</div>
                    </div>
                    <div class="paragraph">
                      목표 도서를 등록하여 독서 성취를 이뤄보아요!
                    </div>
                  </div>

                  <form id="goalForm"action="/myPage/myGoals/register" method="post">
                    <div class="fields-group">
                      <div class="text-field">
                        <div class="label-and-field">
                          <div class="label">도서 명 <span class="exception-field" id="bookTitle-exception-field"></span>
                          </div>
                          <div class="field">
                            <input id="bookTitle" name="bookTitle" type="text" value="">
                            <input id="bookId" name="bookId" type="hidden" value="">
                            <input id="bookImageUrl" name="bookImageUrl" type="hidden" value="">
                          </div>

                        </div>
                      </div>

                      <!-- 모달 열기 버튼 -->
                      <a href="javascript:void(0);" onclick="openModal()">
                        <div class="button">
                          <div class="text-container">
                            <div class="button-text">도서 검색</div>
                          </div>
                        </div>
                      </a>


                      <div class="text-field">
                        <div class="label-and-field">
                          <div class="label">작가 명 <span class="exception-field" id="author-exception-field"></span>
                          </div>
                          <div class="field">
                            <input id="author" name="author" type="text" value="">
                          </div>
                        </div>
                      </div>
                    </div>
                    <br />
                    <div class="fields-group2">
                      <div class="text-field">
                        <div class="label-and-field">
                          <div class="label">시작 날짜 <span class="exception-field" id="startDate-exception-field"></span>
                          </div>
                          <div class="field">
                            <input id="startDate" name="startDate" type="text" value="" placeholder="YYYY-MM-DD">
                          </div>
                        </div>
                      </div>
                      <div class="text-field">
                        <div class="label-and-field">
                          <div class="label">목표 날짜 <span class="exception-field" id="goalDate-exception-field"></span>
                          </div>
                          <div class="field">
                            <input id="goalDate" name="goalDate" type="text" value="" placeholder="YYYY-MM-DD">
                          </div>
                        </div>
                      </div>
                    </div>
                    <br />
                    <div class="form-5-fields-checkbox-button">
                      <div class="fields-group2">
                        <div class="text-field">
                          <div class="label-and-field">
                            <div class="label">총 페이지 <span class="exception-field"
                                id="totalPage-exception-field"></span></div>
                            <div class="field2">
                              <input id="totalPage" name="totalPage" type="text" value="" placeholder="숫자만 입력하세요">
                            </div>
                          </div>
                        </div>
                      </div>
                      <label class="buttons-group" for="form-submit">
                        <div>
                          <div class="button" style="cursor: pointer;">
                            <div class="text-container">
                              <input type="hidden" name="isDelete" value="1">
                              <input id="form-submit" class="button-text" type="submit" value="추가하기">
                            </div>
                          </div>
                        </div>
                      </label>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 모달 창 -->
      <div id="modal-modal" class="hidden-modal" onclick="closeModal(event)">
        <div class="group-148-modal" onclick="event.stopPropagation()">
          <div class="section-text">
            <div class="top">
              <div class="secondary-headline">도서 검색</div>
            </div>
            <div class="paragraph">
              목표로 설정할 도서를 검색합니다.
              <br />
              만약 결과가 없다면 도서 정보를 수동으로 입력할 수 있습니다.
            </div>
          </div>
          <br><br>
          <div class="form-5-fields-checkbox-button">
            <div class="text-field-modal">
              <div class="label-and-field-modal">
                <div class="label-modal">도서 명</div>
                <div class="field-modal">
                  <input type="text" name="keyword" id="keyword" onkeydown="search(event)">
                </div>
              </div>
            </div>
          </div>
          <!-- 리스트 뷰 들어가는 곳 -->
          <br><br>
          <div class="book-list">
            <!-- Book Item 1 -->

            <!-- Book Item 1 -->
          </div>
        </div>
      </div>


      <script src="../../../../resources/js/myPage/myGaolsAddBooks.js" defer></script>
      <script src="../../../../resources/js/myPage/myGaolsAddBooksException.js" defer></script>

    </body>

    </html>