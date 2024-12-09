<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet" href="../../resources/css/indexstyle.css">

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

   menu, ol, ul {
       list-style-type: none;
       margin: 0;
       padding: 0;
   }


   </style>
  <title>리플렛 방문을 환영합니다.</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <div class="div">

   
    <div class="auto-layout-vertical">
      <div class="auto-layout-horizontal">
        <div class="auto-layout-vertical2">
          <div class="auto-layout-vertical3">
            
            <div class="div2">개인 맞춤형 독서추천</div>
          </div>
          <div class="div3">${user.username} 님이 좋아하실 도서들을 추려보았어요.<br>맞춤형 도서를 추천 받고 독서 성취를 이뤄보아요 !</div>
        </div>
        <div class="type-primary-size-large-status-enable">
          <div class="button3">관심 키워드 : 키워드</div>
        </div>
      </div>

  </div>

</body>
</html>