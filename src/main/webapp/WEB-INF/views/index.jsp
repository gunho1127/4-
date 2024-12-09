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

    <div class="section">
      <div class="content">
        <div class="section-text">
          <div class="top2">
            <div class="main-headline">당신의 독서 목표를 달성하세요</div>
          </div>
          <div class="paragraph">
            REAPLETTE 은 여러분에게 맞춤형 도서를 추천해주고<br>지속적인 독서 습관을 형성할 수 있도록 돕습니다.
            <br/>
            독서 커뮤니티를 통해 독서를 즐길 수 있는 환경을 제공합니다.
          </div>
        </div>
      </div>
      <div class="right">
        <div class="screen-phone">
          <img class="image" src="image0.png" />
          <div class="dynamic-island"></div>
        </div>
      </div>
    </div>
    <div class="section2">
      <div class="section-text">
        <div class="top2">
          <div class="secondary-headline">개인 맞춤형 독서관리 및 커뮤니티</div>
        </div>
        <div class="paragraph2">
            본 웹 서비스는 사용자 개인의 독서 취향 분석을 기반으로<br>맞춤형 도서를 추천하고 독서 성취를 독려하는 웹 서비스 입니다.<br>다양한 Open API를 사용하여 사용자가 좀 더 효과적인 독서활동을 할 수 있도록 지원합니다.
        </div>
      </div>
      <div class="row">
        <div class="stats-card">
          <div class="content2">
            <div class="icon-container">
              <img
                class="icon-jam-icons-outline-logos-smiley"
                src="/resources/images/icon-jam-icons-outline-logos-smiley0.svg"
              />
            </div>
            <div class="text4">
              <div class="title-container">
                <div class="title">독서 습관</div>
              </div>

            </div>
          </div>
        </div>
        <div class="stats-card">
          <div class="content2">
            <div class="icon-container">
              <img
                class="icon-jam-icons-outline-logos-files"
                src="/resources/images/icon-jam-icons-outline-logos-files0.svg"
              />
            </div>
            <div class="text4">
              <div class="title-container">
                <div class="title">맞춤 도서</div>
              </div>

            </div>
          </div>
        </div>
        <div class="stats-card">
          <div class="content2">
            <div class="icon-container">
              <img
                class="icon-jam-icons-outline-logos-pizza-slice"
                src="/resources/images/icon-jam-icons-outline-logos-pizza-slice0.svg"
              />
            </div>
            <div class="text4">
              <div class="title-container">
                <div class="title">독서 정착</div>
              </div>

            </div>
          </div>
        </div>
        <div class="stats-card">
          <div class="content2">
            <div class="icon-container">
              <img
                class="icon-jam-icons-outline-logos-users"
                src="/resources/images/icon-jam-icons-outline-logos-users0.svg"
              />
            </div>
            <div class="text4">
              <div class="title-container">
                <div class="title">커뮤니티</div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="auto-layout-vertical">
      <div class="auto-layout-horizontal">
        <div class="auto-layout-vertical2">
          <div class="auto-layout-vertical3">
            <div class="live-bootcamps">LIVE BOOTCAMPS</div>
            <div class="div2">금주의 베스트 셀러</div>
          </div>
          <div class="div3">알라딘에서 제공하는 뭐 베스트 셀러를 둘러보세요</div>
        </div>
        <div class="type-primary-size-large-status-enable">
          <div class="button3">더 알아보기</div>
        </div>
      </div>
      <div class="auto-layout-horizontal2">
        <div class="auto-layout-horizontal3">
          <!-- <div class="type-only-icon-status-enable-size-large">
            <img class="arrow-arrow-left-md" src="arrow-arrow-left-md0.svg" />
          </div> -->
          <!-- <div class="type-only-icon-status-enable-size-large2">
            <img class="arrow-arrow-right-md" src="arrow-arrow-right-md0.svg" />
          </div> -->
          <div class="style-informative-orientation-vertical">
            <div class="style-square"></div>
            <div class="auto-layout-vertical4">
              <div class="auto-layout-vertical5">
                <div class="sharon">Sharon</div>
                <div class="united-states">United States 🇺🇸</div>
              </div>
            </div>
          </div>
          <div class="style-informative-orientation-vertical">
            <div class="style-square"></div>
            <div class="auto-layout-vertical4">
              <div class="auto-layout-vertical5">
                <div class="sue">Sue</div>
                <div class="canada">Canada 🇨🇦</div>
              </div>
            </div>
          </div>
          <div class="style-informative-orientation-vertical">
            <div class="style-square"></div>
            <div class="auto-layout-vertical4">
              <div class="auto-layout-vertical5">
                <div class="james">James</div>
                <div class="united-kingdom">United Kingdom 🇬🇧</div>
              </div>
            </div>
          </div>
          <div class="style-informative-orientation-vertical">
            <div class="style-square"></div>
            <div class="auto-layout-vertical4">
              <div class="auto-layout-vertical5">
                <div class="cyril">Cyril</div>
                <div class="france">France 🇫🇷</div>
              </div>
            </div>
          </div>
          <div class="style-informative-orientation-vertical">
            <div class="style-square"></div>
            <div class="auto-layout-vertical4">
              <div class="auto-layout-vertical5">
                <div class="lewis">Lewis</div>
                <div class="united-states">United States 🇺🇸</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="section3">
      <div class="section-text2">
        <div class="top2">
          <div class="secondary-headline">추천 작가</div>
        </div>
      </div>
      <div class="images">
        <div class="team-member">
          <img class="placeholder-picture" src="placeholder-picture0.png" />
          <div class="name-and-role">
            <div class="name">Darrell Steward</div>
            <div class="role">UI Designer &amp; Co-founder</div>
          </div>
          <div class="frame-48">
            <img
              class="icon-jam-icons-outline-logos-linkedin"
              src="icon-jam-icons-outline-logos-linkedin0.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-twitter"
              src="icon-jam-icons-outline-logos-twitter0.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-instagram"
              src="icon-jam-icons-outline-logos-instagram0.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-facebook"
              src="icon-jam-icons-outline-logos-facebook0.svg"
            />
          </div>
          <div class="button4">
            <div class="text-container2">
              <div class="button-text2">Contact Darrell</div>
            </div>
          </div>
        </div>
        <div class="team-member">
          <img class="placeholder-picture" src="placeholder-picture1.png" />
          <div class="name-and-role">
            <div class="name">Savannah Nguyen</div>
            <div class="role">UX Designer &amp; Co-founder</div>
          </div>
          <div class="frame-48">
            <img
              class="icon-jam-icons-outline-logos-linkedin2"
              src="icon-jam-icons-outline-logos-linkedin1.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-twitter2"
              src="icon-jam-icons-outline-logos-twitter1.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-instagram2"
              src="icon-jam-icons-outline-logos-instagram1.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-facebook2"
              src="icon-jam-icons-outline-logos-facebook1.svg"
            />
          </div>
          <div class="button4">
            <div class="text-container2">
              <div class="button-text2">Contact Savannah</div>
            </div>
          </div>
        </div>
        <div class="team-member">
          <img class="placeholder-picture" src="placeholder-picture2.png" />
          <div class="name-and-role">
            <div class="name">Dianne Russell</div>
            <div class="role">Developer</div>
          </div>
          <div class="frame-48">
            <img
              class="icon-jam-icons-outline-logos-linkedin3"
              src="icon-jam-icons-outline-logos-linkedin2.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-twitter3"
              src="icon-jam-icons-outline-logos-twitter2.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-instagram3"
              src="icon-jam-icons-outline-logos-instagram2.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-facebook3"
              src="icon-jam-icons-outline-logos-facebook2.svg"
            />
          </div>
          <div class="button4">
            <div class="text-container2">
              <div class="button-text2">Contact Dianne</div>
            </div>
          </div>
        </div>
        <div class="team-member">
          <img class="placeholder-picture" src="placeholder-picture3.png" />
          <div class="name-and-role">
            <div class="name">Kristin Watson</div>
            <div class="role">Sr. Product Designer</div>
          </div>
          <div class="frame-48">
            <img
              class="icon-jam-icons-outline-logos-linkedin4"
              src="icon-jam-icons-outline-logos-linkedin3.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-twitter4"
              src="icon-jam-icons-outline-logos-twitter3.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-instagram4"
              src="icon-jam-icons-outline-logos-instagram3.svg"
            />
            <img
              class="icon-jam-icons-outline-logos-facebook4"
              src="icon-jam-icons-outline-logos-facebook3.svg"
            />
          </div>
          <div class="button4">
            <div class="text-container2">
              <div class="button-text2">Contact Kristin</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    
    </div>
  </div>

</body>
</html>