<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상세 게시글 조회</title>
    <!-- jQuery CDN 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../../../resources/css/community/communityViewPost.css">
    <script src="../../../resources/js/community/communityViewPost.js"></script>
</head>

<body>
    <!-- nav -->
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    <!-- nav -->

    <div class="container4">
    </div>

    <div class="container">
        <!-- 게시글 헤더 -->
        <div class="post-header">
            <h1>${post.title}</h1>
            <div class="buttons">
                <c:if test="${isAuthor}">
                    <button class="delete" data-post-id="${post.postId}">삭제</button>
                    <button class="edit" data-post-id="${post.postId}">수정</button>
                </c:if>
            </div>
        </div>
        <!-- 게시글 메타 정보 -->
        <div class="post-meta">
            <div> ${post.type} | ${post.date} | ${post.id} </div>
            <div> 조회수 ${post.viewCount} | 댓글 ${post.commentCount} | 좋아요 ${post.likeCount} </div>
        </div>
        <!-- 게시글 본문 -->
        <div class="post-content">
            <div class="img-container">
                <img src="${post.postImagePath}">
            </div>
            <div class="horizontal-line"></div>
            <div>
                <p>${post.content}</p>
            </div>
        </div>
        <!-- 좋아요 버튼 -->
        <div class="like-section" id="like-section" data-post-id="${post.postId}" data-user-id="${loggedInUserId}">
            <button id="like-button">
                <img id="like-img" src="../../../resources/images/community/unliked.png" alt="Like Button">
            </button>
        </div>

        <!-- 댓글 섹션 -->
        <!-- 댓글 섹션 -->
        <div class="comments-section">
            <!-- 댓글 입력 -->
            <form action="/community/viewPost/${post.postId}/commentWrite" method="post">
                <div class="comment-input">
                    <!-- 로그인한 사용자의 아이디 출력 -->
                    <div class="comment-input-text">
                        <div class="user-id">
                            ${user.username}
                        </div>
                        <!-- 댓글 입력창 -->
                        <input type="text" name="comment" placeholder="댓글을 남겨보세요." required>
                    </div>
                    <!-- 전송 버튼 -->
                    <button type="submit">
                        <img src="../../../resources/images/community/Send.svg" alt="댓글 전송">
                    </button>
                </div>
            </form>


            <!-- 댓글 목록 -->
            <div class="comments-list">
                <c:forEach var="comment" items="${comments}">
                    <div class="comment">
                        <div class="comment-info">
                            <span class="comment-author">${comment.username}</span>
                            <span class="comment-date">${comment.date}</span>
                        </div>
                        <div class="comment-content">
                            <p>${comment.comment}</p>
                        </div>
                        <div class="comment-actions">
                            <!-- 삭제 버튼 -->
                            <c:if test="${comment.id == loggedInUserId}">
                                <form action="/community/viewPost/${post.postId}/commentDelete/${comment.commentId}" method="post" style="display:inline;" onsubmit="return confirmDeleteComment();">
                                    <button type="submit" class="delete-button">
                                        <img src="../../../resources/images/community/Trash.svg" alt="댓글 삭제">
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="comments-section-more">
            <!-- 더보기 버튼 -->
            <c:if test="${hasMoreComments}">
                <form action="/community/viewPost" method="get">
                    <input type="hidden" name="postId" value="${post.id}">
                    <input type="hidden" name="page" value="${currentPage + 1}">
                    <div class="load-more">
                        <button type="submit">
                            <img src="/path/to/load-more-icon.png" alt="댓글 더보기">
                        </button>
                    </div>
                </form>
            </c:if>
        </div>
    </div>

    <div class="container4">
    </div>

    <!-- 삭제 모달 -->
    <div id="deleteModal" class="modal" style="display: none;">
        <div class="modal-content">
            <p>정말 삭제하시겠습니까?</p>
            <div class="modal-buttons">
                <button id="confirmDelete" class="button">예</button>
                <button id="cancelDelete" class="button">아니오</button>
            </div>
        </div>
    </div>

</body>

</html>