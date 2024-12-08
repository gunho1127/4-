<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet" href="../../../resources/css/myPage/followingstyle.css">


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

    menu,
    ol,
    ul {
      list-style-type: none;
      margin: 0;
      padding: 0;
    }
  </style>
  <title>리플렛 - 팔로워</title>
</head>

<body>
  <div class="div">

  <div class="col-auto sidebar d-flex flex-column align-items-start p-0">
          <jsp:include page="/WEB-INF/views/includes/mypagenav/myPageNav.jsp" />
        </div>


    <div class="table">
      <div class="header">
        
        <span>
          <span class="div-22-span">
            팔로우
            <br />
          </span>
          <span class="div-22-span2">
            회원님의 팔로잉, 팔로워 목록을 볼 수 있습니다.
          </span>
        </span>
    
  </div>
      <div class="dashboard-tabs">
        
          <div class="tab">
            <div class="text-container">
              <a href="/myPage/following">
                <div class="tab-text" style="margin-left: 30px;">팔로잉</div>
              </a>
              <div class="badge">
                <div class="text">팔로잉 수</div>
              </div>
            </div>
          </div>

          <div class="tabs">
            <div class="tab2">
              <div class="text-container">
                <a href="/myPage/follower">
                  <div class="tab-text" style="margin-left: 50px;">팔로워</div>
                </a>
                <div class="badge">
                  <div class="text">팔로워 수</div>
                </div>
              </div>
            </div>

        </div>
      </div>
      <div class="table2">
        <div class="row">

          <div class="cell2" style="margin-left: 90px;">
            <div class="content">
              <div class="title">프로필</div>
            </div>
          </div>
          <div class="cell3">
            <div class="content">
              <div class="title">가입 일자</div>
            </div>
          </div>
          <div class="cell3">
            <div class="content">
              <div class="title">팔로잉</div>
            </div>
          </div>
          <div class="cell3">
            <div class="content">
              <div class="title">팔로워</div>
            </div>
          </div>
        </div>

        <!-- 리스트뷰 -->
        <div class="row2">
          <div class="cell5">
            <div class="content2">
              <div class="controls">
                
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <a href="">
                  <div class="user-thumb">
                    <img class="icon-jam-icons-outline-logos-user" src="../../../resources/images/myPage/icon-jam-icons-outline-logos-user0.svg" />
                  </div>
                </a>
                <div class="details">
                  <div class="category">활동명</div>
                  <div class="category2">이메일@이메일.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="_2024-11-12">2024.11.12</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="_7">7</div>
            </div>
          </div>
          <div class="cell8">
            <div class="content4">
              <div class="_20">20</div>
            </div>
          </div>
          <div class="cell9">
            <div class="content5">
              <div class="badge2">
                <a href="">
                  <div class="text2">삭 제</div>
                </a>
              </div>
            </div>
          </div>
        </div>        

      </div>
    </div>
  </div>

</body>

</html>