document.addEventListener('DOMContentLoaded', function () {
    // 이미지 업로드 함수
    function uploadImage() {
        const imageInput = document.getElementById('imageInput');
        imageInput.click(); // 파일 선택 창 열기
        imageInput.onchange = () => {
            const file = imageInput.files[0];
            const uploadedImage = document.getElementById('uploadedImage');
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    uploadedImage.src = e.target.result; // 이미지 미리보기 업데이트
                };
                reader.readAsDataURL(file);
            }
        };
    }

    // 이미지 제거 함수
    function rmImage() {
        document.getElementById('removeImage').value = "true";  // removeImage 값을 true로 설정
        const uploadedImage = document.getElementById('uploadedImage');
        const imageInput = document.getElementById('imageInput');
        uploadedImage.src = ''; // 미리보기 초기화
        imageInput.value = ''; // 파일 선택 초기화
    }

    // 버튼에 이벤트 리스너 추가
    const uploadButton = document.getElementById('uploadButton');
    if (uploadButton) {
        uploadButton.addEventListener('click', uploadImage);
    }

    const removeButton = document.getElementById('removeButton');
    if (removeButton) {
        removeButton.addEventListener('click', rmImage);
    }
});
