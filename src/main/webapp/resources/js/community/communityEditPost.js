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

function removeImage() {
    const uploadedImage = document.getElementById('uploadedImage');
    const imageInput = document.getElementById('imageInput');
    uploadedImage.src = ''; // 미리보기 초기화
    imageInput.value = ''; // 파일 선택 초기화
}