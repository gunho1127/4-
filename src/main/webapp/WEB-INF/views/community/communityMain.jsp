<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실시간 인기 게시글</title>
    <link rel="stylesheet" href="../../../resources/css/community/communityMain.css">
    <script src="../../../resources/js/community/communityMain.js"></script>
</head>

<body>
    <!-- nav -->
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    <!-- nav -->

    <section>
        <a href="/community/newPost">
            <div class="container2">
                <button class="new-post-btn">+ 새 글 작성</button>
            </div>
        </a>
    </section>

    <section>
        <div class="container">
            <header class="header">
                <h1>
                    <img src="../../../resources/images/community/fire-icon.svg" class="header-icon">
                    실시간 인기 게시글
                </h1>
            </header>

            <div class="post-slider">
                <button class="slider-btn prev">‹</button>
                <div class="post-grid">
                    <!-- 반복문을 사용하여 게시글 정보를 동적으로 출력 -->
                    <c:forEach var="post" items="${postList}">
                        <div class="post-card" data-post-id="${post.postId}" data-post-type="${post.type}">
                            <img class="image-placeholder" src="${post.postImagePath}" >
                            <div class="post-info">
                                <!-- 카테고리 (BoardVO에 type) -->
                                <p class="category">${post.type}</p>
                                <!-- 제목 -->
                                <h3 class="title">${post.title}</h3>
                                <!-- 내용 일부 (content의 앞부분을 표시) -->
                                <p class="description">
                                    <c:choose>
                                        <c:when test="${post.content != null && post.content.length() > 20}">
                                            ${post.content.substring(0, 20)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${post.content != null ? post.content : "내용 없음"}
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="author">
                                    <div class="avatar-placeholder"></div>
                                    <div>
                                        <!-- 작성자 이름 -->
                                        <p class="name">${post.id}</p> <!-- 'id'는 작성자 ID -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button class="slider-btn next">›</button>
            </div>
        </div>
    </section>

    <div class="container3">
    </div>

   <!-- 팔로우한 게시글 섹션 -->
   <c:if test="${not empty followList}">
       <section>
           <div class="container">
               <header class="header">
                   <h1>
                       <img src="../../../resources/images/community/group-icon.svg" class="header-icon">
                       팔로잉 게시글
                   </h1>
               </header>

               <div class="post-slider">
                   <button class="slider-btn prev">‹</button>
                   <div class="post-grid">
                       <!-- 팔로우한 게시글을 반복문으로 출력 -->
                       <c:forEach var="post" items="${followList}">
                           <div class="post-card" data-post-id="${post.postId}" data-post-type="${post.type}">
                               <div class="image-placeholder"></div>
                               <div class="post-info">
                                   <p class="category">${post.type}</p>
                                   <h3 class="title">${post.title}</h3>
                                   <p class="description">
                                       <c:choose>
                                           <c:when test="${post.content != null && post.content.length() > 20}">
                                               ${post.content.substring(0, 20)}...
                                           </c:when>
                                           <c:otherwise>
                                               ${post.content != null ? post.content : "내용 없음"}
                                           </c:otherwise>
                                       </c:choose>
                                   </p>
                                   <div class="author">
                                       <div class="avatar-placeholder"></div>
                                       <div>
                                           <p class="name">${post.id}</p>
                                       </div>
                                   </div>
                               </div>
                           </div>
                       </c:forEach>
                   </div>
                   <button class="slider-btn next">›</button>
               </div>
           </div>
       </section>
   </c:if>


    <div class="container3">
    </div>

    <div class="container3">
    </div>

    <section>
        <div class="container">
            <header class="header">
                <h1>
                    <img src="../../../resources/images/community/book-icon.svg" class="header-icon">
                    도서 리뷰
                </h1>
                <div class="sort-dropdown">
                    <select name="sort" onchange="window.location.href='?sort=' + this.value;">
                        <option value="latest" selected>최신순</option>
                        <option value="popular">인기순</option>
                    </select>
                </div>
            </header>
            <div class="post-list">
                <c:forEach var="post" items="${reviewList}">
                    <div class="post-item" data-post-id="${post.reviewId}" data-post-type="${post.type}">
                        <div class="post-image">
                            <img src="">
                        </div>
                        <div class="post-content">
                            <div>
                                <span class="post-category">${post.type}</span>
                                <span class="post-id">no. ${post.reviewId}</span>
                            </div>
                            <h2 class="post-title">${post.bookTitle}</h2>
                            <p class="post-snippet">
                                <c:choose>
                                    <c:when test="${post.reviewContent != null && post.reviewContent.length() > 20}">
                                        ${post.reviewContent.substring(0, 20)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${post.reviewContent != null ? post.reviewContent : "내용 없음"}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="post-meta">
                            <span class="post-author">${post.id}</span>
                            <span class="post-date">${post.date}</span>
                            <span class="post-likes">❤️${post.likeCount}</span>
                        </div>
                    </div>
                </c:forEach>

                <div class="pagination-wrapper">
                    <a href="?allPage=${allCurrentPage}&followPage=${followCurrentPage}&communityPage=${communityCurrentPage}&bookPage=${bookCurrentPage - 1}"
                       class="pagination-btn ${bookCurrentPage == 1 ? 'disabled' : ''}">&lt; Previous</a>
                    <c:forEach begin="1" end="${bookTotalPages}" var="page">
                        <a href="?allPage=${allCurrentPage}&followPage=${followCurrentPage}&communityPage=${communityCurrentPage}&bookPage=${page}"
                           class="pagination-btn ${page == bookCurrentPage ? 'active' : ''}">${page}</a>
                    </c:forEach>
                    <a href="?allPage=${allCurrentPage}&followPage=${followCurrentPage}&communityPage=${communityCurrentPage}&bookPage=${bookCurrentPage + 1}"
                       class="pagination-btn ${bookCurrentPage == bookTotalPages ? 'disabled' : ''}">Next &gt;</a>
                </div>


            </div>

        </div>
    </section>

    <div class="container3">
    </div>

    <section>
        <div class="container">
            <header class="header">
                <h1>
                    <img src="../../../resources/images/community/community-icon.svg" class="header-icon">
                     커뮤니티
                </h1>
                <div class="sort-dropdown">
                    <select name="sort" onchange="window.location.href='?sort=' + this.value;">
                        <option value="latest" selected>최신순</option>
                        <option value="popular">인기순</option>
                    </select>
                </div>
            </header>
            <div class="post-list">
                <c:forEach var="post" items="${communityList}">
                    <div class="post-item" data-post-id="${post.postId}" data-post-type="${post.type}">
                        <div class="post-image">
                            <img src="${post.postImagePath}" >
                        </div>
                        <div class="post-content">
                            <div>
                                <span class="post-category">${post.type}</span>
                                <span class="post-id">no. ${post.postId}</span>
                            </div>
                            <h2 class="post-title">${post.title}</h2>
                            <p class="post-snippet">
                                <c:choose>
                                    <c:when test="${post.content != null && post.content.length() > 20}">
                                        ${post.content.substring(0, 20)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${post.content != null ? post.content : "내용 없음"}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="post-meta">
                            <span class="post-author">${post.id}</span>
                            <span class="post-date">${post.date}</span>
                            <span class="post-likes">❤️${post.likeCount}</span>
                        </div>
                    </div>
                </c:forEach>

                <div class="pagination-wrapper">
                    <a href="?allPage=${allCurrentPage}&followPage=${followCurrentPage}&communityPage=${communityCurrentPage - 1}&bookPage=${bookCurrentPage}"
                       class="pagination-btn ${communityCurrentPage == 1 ? 'disabled' : ''}">&lt; Previous</a>
                    <c:forEach begin="1" end="${communityTotalPages}" var="page">
                        <a href="?allPage=${allCurrentPage}&followPage=${followCurrentPage}&communityPage=${page}&bookPage=${bookCurrentPage}"
                           class="pagination-btn ${page == communityCurrentPage ? 'active' : ''}">${page}</a>
                    </c:forEach>
                    <a href="?allPage=${allCurrentPage}&followPage=${followCurrentPage}&communityPage=${communityCurrentPage + 1}&bookPage=${bookCurrentPage}"
                       class="pagination-btn ${communityCurrentPage == communityTotalPages ? 'disabled' : ''}">Next &gt;</a>
                </div>


            </div>

        </div>
    </section>

    <div class="container3">
    </div>

</body>

</html>