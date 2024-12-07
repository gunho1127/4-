function openDeleteModal(postId) {
    const modal = document.getElementById('deleteModal');

    // 모달을 보이도록 설정
    modal.style.display = 'flex';

    // 예 버튼에 postId 전달
    const confirmButton = document.getElementById('confirmDelete');
    confirmButton.setAttribute('data-post-id', postId);
}

function closeDeleteModal() {
    const modal = document.getElementById('deleteModal');
    modal.style.display = 'none';
}

function confirmDeletePost(postId) {
    // 삭제 요청 URL 생성
    const url = `/community/viewPost/delete?id=${postId}`;

    // URL로 이동 (GET 요청)
    window.location.href = "/community/main";
}
