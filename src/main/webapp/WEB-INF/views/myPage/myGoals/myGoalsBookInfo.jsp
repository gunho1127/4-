<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link rel="stylesheet" href="../../../../../resources/css/myPage/myGoalsBookInfostyle.css">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
      <link rel="stylesheet" href="../../../../../resources/css/myPage/MyGoalsWriteTranscriptionstyle.css">
      <link rel="stylesheet" href="../../../../resources/css/myPage/exceptionstyle.css">

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

        .field input {
          width: 100%;
          height: 100%;
        }

        .modal {
          display: none;
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.5);
          z-index: 1000;
          text-align: center;
        }

        .modal-content {
          position: fixed;
          /* 수정: 고정 위치로 설정 */
          top: 50%;
          /* 수정: 화면의 중간 높이 */
          left: 50%;
          /* 수정: 화면의 중간 너비 */
          transform: translate(-50%, -50%);
          /* 중앙 정렬을 위한 변환 */
          background-color: #fff;
          padding: 20px;
          border-radius: 8px;
          width: 50%;
          /* 필요에 따라 크기 조정 */
          box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }


        .close {
          position: absolute;
          top: 10px;
          right: 10px;
          font-size: 20px;
          cursor: pointer;
        }

        .row {
          background-color: #f2f4f8;
        }

        .exception-field {
          color: red;
        }
      </style>
      <title>리플렛 - 도서 정보</title>
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
            <div class="page-content">
              <div class="page-content2">
                <img class="placeholder-picture" src="${goal.bookImageUrl}" />
                <div class="right-column">
                  <div class="section-text">
                    <div class="top">
                      <div class="secondary-headline">${goal.bookTitle}</div>

                    </div>
                    <div class="paragraph">${goal.author}</div>
                  </div>

                  <form id="goalForm" action="/myPage/myGoals/bookInfoRecord" method="post">

                    <div class="form-5-fields-checkbox-button">
                      <div class="fields-group">
                        <div class="text-field">
                          <div class="label-and-field">
                            <div class="label">시작 일자 <span class="exception-field"
                                id="startDate-exception-field"></span></div>
                            <div class="field">
                              <input type="text" id="startDate" name="startDate" value="${goal.startDate}">
                            </div>
                          </div>
                        </div>
                        <div class="text-field">
                          <div class="label-and-field">
                            <div class="label">목표 일자 <span class="exception-field" id="goalDate-exception-field"></span>
                            </div>
                            <div class="field">
                              <input type="text" id="goalDate" name="goalDate" value="${goal.goalDate}">
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <br>

                    <div class="form-5-fields-checkbox-button">
                      <div class="fields-group">
                        <div class="text-field">
                          <div class="label-and-field">
                            <div class="label">총 페이지 <span class="exception-field"
                                id="totalPage-exception-field"></span></div>
                            <div class="field">
                              <input type="text" id="totalPage" name="totalPage" value="${goal.totalPage}">
                            </div>
                          </div>
                        </div>
                        <div class="text-field">
                          <div class="label-and-field">
                            <div class="label">읽은 페이지 <span class="exception-field"
                                id="pagesRead-exception-field"></span></div>
                            <div class="field">
                              <input type="text" id="pagesRead" name="pagesRead" value="${goal.pagesRead}">
                            </div>
                          </div>
                        </div>
                      </div>
                      <input type="hidden" name="id" value="${goal.id}">
                      <input type="hidden" name="bookId" value="${goal.bookId}">

                      <div class="buttons-group">
                        <div class="button">
                          <div class="text-container">
                            <input class="button-text" type="submit" value="기록 완료">
                          </div>
                        </div>

                        <div class="buttons-group" style="margin-left:15px;">
                          <div class="button">
                            <div class="text-container">
                              <button class="button-text">목표 삭제</button>
                            </div>
                          </div>
                        </div>
                      </div>

                    </div>

                  </form>

                </div>

              </div>





              <div class="table2">

                <div class="header">
                  <div class="auto-layout-vertical">
                    <div class="secondary-headline">필사 다이어리<br>
                      <span class="div-5-span2">인상 깊은 오늘의 한 문장을 담아보아요 !</span>
                    </div>
                  </div>
                  <a href="javascript:void(0);" onclick="openModal()">
                    <div class="type-primary-size-large-status-enable">
                      <div class="button-text">필사 추가</div>
                    </div>
                  </a>
                </div>

                <div class="frame-1">




                  <!-- 첫 번째 컬럼 -->

                  <div class="column" id="column1">
                    <c:forEach var="transcription" items="${transcriptionList}" varStatus="status">

                      <c:if test="${status.index % 2 == 0}">
                        <div class="kanban">
                          <div class="description-top">${transcription.transcriptionDate}</div>
                          <div class="description-top2">${transcription.transcriptionSentence}</div>
                          <div class="description-top3">${transcription.transcriptionContent}</div>
                          <div class="bottom">
                            <div class="icons-container">
                              <a
                                href="/myPage/myGoals/bookInfo/deleteTrans?transcriptionId=${transcription.transcriptionId}">
                                <img class="icon-heroicons-outline-trash4"
                                  src="../../../../resources/images/myPage/icon-heroicons-outline-trash3.svg" />
                              </a>
                            </div>
                          </div>
                        </div>
                      </c:if>
                    </c:forEach>
                  </div>

                  <!-- 두 번째 컬럼 -->

                  <div class="column" id="column2">
                    <c:forEach var="transcription" items="${transcriptionList}" varStatus="status">

                      <c:if test="${status.index % 2 != 0}">
                        <div class="kanban">
                          <div class="description-top">${transcription.transcriptionDate}</div>
                          <div class="description-top2">${transcription.transcriptionSentence}</div>
                          <div class="description-top3">${transcription.transcriptionContent}</div>
                          <div class="bottom">
                            <div class="icons-container">
                              <a
                                href="/myPage/myGoals/bookInfo/deleteTrans?transcriptionId=${transcription.transcriptionId}">
                                <img class="icon-heroicons-outline-trash4"
                                  src="../../../../resources/images/myPage/icon-heroicons-outline-trash3.svg" />
                              </a>
                            </div>
                          </div>
                        </div>
                      </c:if>
                    </c:forEach>
                  </div>
                </div>




              </div>
            </div>
          </div>
        </div>
      </div>


      <!-- 모달 -->
      <div class="modal" id="myModal" onclick="closeModal(event)">
        <div class="modal-content" onclick="event.stopPropagation()">
          <div class="div-modal">
            <div class="section-text-modal">
              <div class="top-modal">
                <div class="secondary-headline-modal">필사 작성</div>
              </div>
              <div class="paragraph-modal">
                책을 읽고 인상 깊은 문장과 당신의 생각을 담아보세요.
              </div>
            </div>

            <form id="transcription-from" method="post" action="/myPage/myGoals/bookInfo/postTrans">
              <div class="form-5-fields-checkbox-button-modal">
                <div class="text-field-modal">
                  <div class="label-and-field-modal">
                    <div class="label-modal">필사 문장 <span class="exception-field" id="transcriptionSentence-exception-field"></span></div>
                    <div class="field-modal">
                      <input type="text" id="transcriptionSentence" name="transcriptionSentence" value="">
                    </div>
                    
                  </div>
                </div>
                <div class="text-field-modal">
                  <div class="label-and-field-modal">
                    <div class="label-modal">나의 생각 <span class="exception-field" id="transcriptionContent-exception-field"></span></div>
                    <div class="field-modal">
                      <input type="text" id="transcriptionContent" name="transcriptionContent" value="">
                    </div>
                    
                  </div>
                </div>
                <div class="text-field-modal">
                  <div class="label-and-field-modal">
                    <div class="label-modal">작성 날짜 <span class="exception-field" id="transcriptionDate-exception-field"></span></div>
                    <div class="field-modal">
                      <input type="text" id="transcriptionDate" name="transcriptionDate" placeholder="YYYY-MM-DD">
                    </div>
                    
                  </div>
                </div>

                <div class="buttons-group-modal">
                  <div class="button-modal">
                    <div class="text-container-modal">

                      <input type="hidden" id="id" name="id" value="${goal.id}">
                      <input type="hidden" id="bookId" name="bookId" value="${goal.bookId}">
                      <input type="hidden" id="isDelete" name="isDelete" value="1">

                      <input type="submit" class="button-text-modal" value="작성 완료"></input>
                    </div>
                  </div>
                </div>
              </div>
            </form>


          </div>
        </div>
      </div>

      <script src="../../../../resources/js/myPage/myGoalsBookInfoException.js" defer></script>
      <script src="../../../../resources/js/myPage/myGoalsWriteTranscriptionExceoption.js" defer></script>

    </body>

    <script>
      function openModal() {
        document.getElementById('myModal').style.display = 'block';
      }

      function closeModal(event) {
        // 모달을 클릭한 것이 아닌 배경을 클릭했을 때만 닫힘
        if (event.target === document.getElementById('myModal')) {
          document.getElementById('myModal').style.display = 'none';
        }
      }
    </script>





    </html>