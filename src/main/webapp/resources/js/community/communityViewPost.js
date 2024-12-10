document.addEventListener('DOMContentLoaded', function() {
    // 삭제 버튼 클릭 시 모달 열기
    const deleteButtons = document.querySelectorAll('.delete');

    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const postId = button.getAttribute('data-post-id');
            openDeleteModal(postId);
        });
    });

    // 수정 버튼 클릭 시 editPost 페이지로 이동
    const editButton = document.querySelector('.edit');
    if (editButton) {
        const postId = editButton.getAttribute('data-post-id'); // 수정된 부분: data-post-id에서 postId를 가져옴
        editButton.addEventListener('click', function() {
            window.location.href = '/community/editPost/' + postId;
        });
    }

    // 모달 열기
    function openDeleteModal(postId) {
        const modal = document.getElementById('deleteModal');
        modal.style.display = 'flex';  // 모달 표시

        const confirmButton = document.getElementById('confirmDelete');
        confirmButton.setAttribute('data-post-id', postId); // 예 버튼에 postId 저장
    }

    // 모달 닫기
    function closeDeleteModal() {
        const modal = document.getElementById('deleteModal');
        modal.style.display = 'none';  // 모달 숨기기
    }

    // 삭제 요청 처리 (예 버튼 클릭 시)
    function confirmDeletePost(event) {
        event.preventDefault();  // 기본 동작 방지 (폼 제출 등)

        const postId = document.getElementById('confirmDelete').getAttribute('data-post-id');

        // 삭제 요청 URL 생성
        const url = `/community/viewPost/${postId}/delete`;

        // 삭제 요청 (POST 요청)
        fetch(url, { method: 'POST' })
            .then(response => {
                if (response.ok) {
                    window.location.href = '/community/main'; // 삭제 후 메인 페이지로 이동
                    alert('게시글이 삭제되었습니다.');
                } else {
                    alert('삭제 실패');
                }
            })
            .catch(error => {
                console.error('삭제 요청 오류:', error);
                alert('삭제 처리 중 오류가 발생했습니다.');
            });

        closeDeleteModal();  // 모달 닫기
    }

    // "예" 버튼 클릭 시 삭제 처리
    const confirmButton = document.getElementById('confirmDelete');
    if (confirmButton) {
        confirmButton.addEventListener('click', confirmDeletePost);
    }

    // "아니오" 버튼 클릭 시 모달 닫기
    const cancelButton = document.getElementById('cancelDelete');
    if (cancelButton) {
        cancelButton.addEventListener('click', closeDeleteModal);
    }
});

$(document).ready(function() {
    // data-* 속성으로 postId와 userId 가져오기
    var postId = $('#like-section').data('post-id');
    var userId = $('#like-section').data('user-id');

    // 페이지 로드 시 현재 좋아요 상태 확인 (비동기)
    $.ajax({
        url: '/community/viewPost/' + postId + '/likeStatus',  // 좋아요 상태 조회 URL
        type: 'GET',
        success: function(response) {
            // response는 boolean 값: true (liked), false (unliked)
            if (response) {
                // 좋아요를 눌렀다면, 눌린 하트 표시
                $('#like-img').attr('src', '../../../resources/images/community/liked.png');
            } else {
                // 좋아요를 안 눌렀다면, 빈 하트 표시
                $('#like-img').attr('src', '../../../resources/images/community/unliked.png');
            }
        },
        error: function(xhr, status, error) {
            console.error('좋아요 상태 조회 오류:', error);
            alert('좋아요 상태를 불러오는 데 실패했습니다.');
        }
    });

    // 좋아요 버튼 클릭 시
    $('#like-button').click(function() {
        // 좋아요 상태 토글 (버튼 클릭 시)
        $.ajax({
            url: '/community/viewPost/' + postId + '/like',
            type: 'POST',
            data: { userId: userId },  // 로그인 사용자 ID 전송
            success: function(response) {
                if (response === "성공") {
                    // 좋아요 상태 변경 (토글)
                    var img = $('#like-img');
                    if (img.attr('src').includes('unliked.png')) {
                        img.attr('src', '../../../resources/images/community/liked.png');
                    } else {
                        img.attr('src', '../../../resources/images/community/unliked.png');
                    }
                } else {
                    alert('좋아요 처리에 실패했습니다.');
                }
            },
            error: function(xhr, status, error) {
                console.error('좋아요 요청 오류:', error);
                alert('서버 오류로 인해 좋아요 처리에 실패했습니다.');
            }
        });
    });
});

function confirmDeleteComment() {
    return confirm("댓글을 삭제하시겠습니까?");
}
