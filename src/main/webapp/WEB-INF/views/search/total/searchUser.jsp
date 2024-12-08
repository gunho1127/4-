<%@ page import="com.reaplette.domain.UserVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>리플렛 - 사용자 검색</title>
    <!-- CSS 경로 수정 -->
    <link rel="stylesheet" href="/resources/css/search/style.css" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
	  <link rel="stylesheet" href="/resources/css/headerstyle.css">

    <!-- JavaScript 경로 수정 -->
    <script
      src="https://code.jquery.com/jquery-3.7.1.min.js"
      integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <script src="../../../../../resources/js/search/user.js"></script>
  </head>
  <body>
  <header>
    <jsp:include page="/WEB-INF/views/includes/headerUser.jsp" />
  </header>

  <div id="wrapper" class="py-3">
      <div class="tab_menu">
          <ul class="d-flex justify-content-center gap-4 fw-bold">
              <li><a class="tm_a py-2" href="/search/total?keyword=${keyword}">Overview</a></li>
              <li><a class="tm_a py-2" href="/search/total/book?keyword=${keyword}">Book</a></li>
              <li><a class="tm_a py-2" href="/search/total/author?keyword=${keyword}">Author</a></li>
              <li><a class="tm_a py-2" href="/search/total/post?keyword=${keyword}">Post</a></li>
              <li class="active"><a class="tm_a py-2" href="#">User</a></li>
          </ul>
      </div>
      <!-- /tab_menu -->

    <div class="container py-5 px-0 overflow-hidden">
      <section class="users">
          <!-- 검색 결과 -->
          <div class="users_sch pb-3 border-bottom border-black">
            <h5>'${keyword}'에 대한 사용자 검색 결과 <span class="fw-bold">${userList.size()}</span>건</h5>
          </div>

          <!-- 세션에서 팔로우 상태 가져오기 -->
          <c:if test="${not empty sessionScope.followList}">
          <c:set var="followingSet" value="${sessionScope.followList}" />
          </c:if>

          <!-- 사용자 목록 없을 때 메시지 표시 -->
          <c:if test="${empty userList}">
            <div class="text-center py-5">
            <p> 일치하는 사용자가 없습니다.</p>
            </div>
          </c:if>

          <!-- 사용자 목록 있을 때 리스트 표시 -->
          <c:if test="${not empty userList}">
            <div class="users_list">
            <ul class="py-5 px-3">
            <!-- 사용자 목록 출력 -->

          <c:forEach var="user" items="${userList}" varStatus="num">
            <li class="row align-items-center mb-5">
              <!-- 프로필 사진 -->
              <div class="col-2 ul_icon">
                  <img src="${user.profileImagePath}" class="userImage" />
              </div>
              <!-- 활동자명 -->
              <p class="col ul_title mb-0 fs-5">${user.username}</p>
              <!-- 팔로우/팔로잉 버튼 -->
              <c:if test="${sessionScope.user.id ne 'guest'}"> <!-- 게스트일시 버튼 숨김 -->
                <div class="col-2">
                  <button
                      class="rounded-5 py-2 fw-bold userFollow"
                      type="button"
                      name="followButton"
                      style="background-color: ${'Y'.equals(user.isFollowing) ? 'white' : '#007bff'}; color: ${'Y'.equals(user.isFollowing) ? '#007bff' : 'white'}; border: ${'Y'.equals(user.isFollowing) ? '2px solid #007bff' : 'none'};"
                      onclick="clickEvent('${sessionScope.user.id}', '${user.id}', this, ${num.count})"
                      data-following="${user.isFollowing}">
                      ${'Y'.equals(user.isFollowing) ? '팔로잉' : '팔로우'}
                  </button>
                  <span id="${num.count}follow">${user.isFollowing}</span> <!-- 팔로우 버튼 옆 N일때 팔로우 Y일때 팔로잉 -->
                </div>
              </c:if>
              <!-- 팔로우/팔로잉 버튼 -->
            </li>
          </c:forEach>
            </ul>
          </div>
          </c:if>
          <!-- /users_list -->
      </section>
  </div>
            <!-- pagination -->
          <div class="mt-5">
            <ul class="pagination d-flex justify-content-center gap-4 fw-bold">
                <!-- Previous 버튼 -->
                <li class="${currentPage == 1 ? 'disabled' : ''}">
                    <a class="px-2 py-1" href="?page=${currentPage - 1}" ${currentPage == 1 ? 'onclick="return false;"' : ''}>Previous</a>
                </li>

                <!-- 동적 페이지 번호 버튼 -->
                <c:forEach begin="1" end="${totalPages}" var="page">
                    <li class="${currentPage == page ? 'active' : ''}">
                        <a class="px-2 py-1" href="?page=${page}">${page}</a>
                    </li>
                </c:forEach>

                <!-- Next 버튼 -->
                <li class="${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="px-2 py-1" href="?page=${currentPage + 1}" ${currentPage == totalPages ? 'onclick="return false;"' : ''}>Next</a>
                </li>
            </ul>
        </div>
        </section>
        <!-- /users -->
    </div>
    <!-- /conta -->
  </body>
</html>

