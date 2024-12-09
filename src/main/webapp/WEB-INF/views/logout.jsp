<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>리플렛 - 로그아웃</title>
    <script type="text/javascript">
        // 뒤로 가기 방지
        if (window.history && window.history.pushState) {
            window.history.pushState(null, null, window.location.href);
            window.onpopstate = function () {
                window.history.pushState(null, null, window.location.href);
            };
        }

        // 자동으로 /myPage/main으로 리디렉션
        window.onload = function() {
            // window.location.replace로 리디렉션
            setTimeout(function() {
                window.location.replace('/myPage/main');
            }, 0); // 짧은 시간 후 리디렉션
        }
    </script>
</head>
<body>
    <h1>리플렛 - 로그아웃</h1>
    <p>로그아웃 중입니다. 잠시만 기다려 주세요...</p>
</body>
</html>
