$(document).ready(function() {
    // 페이지가 로드될 때 초기 버튼 상태를 설정
    $(".userFollow").each(function() {
        var currentStatus = $(this).data('following'); // data-following 속성 확인

        if (currentStatus === 'Y') {
            $(this).text('팔로잉');
            $(this).css({
                "background-color": "white",
                "color": "#007bff",
                "border": "2px solid #007bff"
            });
        } else {
            $(this).text('팔로우');
            $(this).css({
                "background-color": "#007bff",
                "color": "white",
                "border": "none"
            });
        }
    });
});

function clickEvent(followingId, followerId, e, textNum) {
    $.ajax({
        url: "/search/total/user/follow",
        type: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
            followerId: followerId,
            followingId: followingId
        }),
        success: function(response) {

            // 현재 버튼의 상태 확인
            var currentStatus = $(e).data('following');

            // 서버 응답에 따라 버튼 텍스트와 data-following 값 변경
            if (currentStatus === 'Y') {
                $(e).text('팔로우');
                $(e).data('following', 'N'); // 팔로잉 상태에서 팔로우 상태로 변경
                $(e).css({
                    "background-color": "#007bff",
                    "color": "white",
                    "border": "none"
                });
                $("#" + textNum + "follow").text("N");
            } else {
                $(e).text('팔로잉');
                $(e).data('following', 'Y'); // 팔로우 상태에서 팔로잉 상태로 변경
                $(e).css({
                    "background-color": "white",
                    "color": "#007bff",
                    "border": "2px solid #007bff"
                });
                $("#" + textNum + "follow").text("Y");
            }
        },
        error: function(xhr, status, error) {
            alert(error);
        }
    });
}
