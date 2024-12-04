<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../../../resources/css/admin/adminPostList.css">
  
  
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
   body, html{
    margin:0;
    padding:0;
    overflow: hidden;
   }
   
   menu, ol, ul {
       list-style-type: none;
       margin: 0;
       padding: 0;
   }
   </style>
  <title>Document</title>
</head>
<body>
  <div class="ui-027">
    <div class="ui-0272">
      <div class="desktop-vertical-logged-in-buttons-bottom">
        <div class="logo-container">
          <div class="logo">
            <div class="text">
              <div class="div">북조선</div>
            </div>
          </div>
        </div>
        <div class="buttons-group">
          <div class="user-thumb">
            <img
              class="icon-tabler-icons-brightness-2"
              src="../../../resources/images/admin/icon-tabler-icons-brightness-20.svg"
            />
          </div>
        </div>
        <div class="menu">
          <div class="menu-item">
            <img class="icon" src="../../../resources/images/admin/icon0.svg" />
            <div class="div2">관리자 정보</div>
          </div>
          <div class="menu-item2">
            <img
              class="icon-feathericons-file-text"
              src="../../../resources/images/admin/icon-feathericons-file-text0.svg"
            />
            <div class="div2">회원 관리</div>
          </div>
          <div class="menu-item3">
            <img
              class="icon-jam-icons-outline-logos-pictures"
              src="../../../resources/images/admin/icon-jam-icons-outline-logos-pictures0.svg"
            />
            <div class="div2">커뮤니티</div>
          </div>
          <div class="menu-item">
            <img
              class="icon-heroicons-outline-lock-open"
              src="../../../resources/images/admin/icon-heroicons-outline-lock-open0.svg"
            />
            <div class="div2">로그아웃</div>
          </div>
        </div>
      </div>
      <div class="page-content">
        <div class="headline">
          <div class="section-text">
            <div class="top">
              <div class="secondary-headline">커뮤니티 관리</div>
            </div>
          </div>
        </div>
        <div class="dashboard-tabs">
          <div class="field">
            <img
              class="icon-jam-icons-outline-logos-search"
              src="../../../resources/images/admin/icon-jam-icons-outline-logos-search0.svg"
            />
            <div class="div3">분류</div>
            <img class="vector" src="../../../resources/images/admin/vector0.svg" />
            <div class="text2">Search</div>
          </div>
        </div>
        <div class="pagination">
          <div class="pagination2">
            <div class="table">
              <div class="row">
                <div class="cell">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-60" src="../../../resources/images/admin/frame-600.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell2">
                  <div class="content2">
                    <div class="div4">제목</div>
                  </div>
                </div>
                <div class="cell3">
                  <div class="content2">
                    <div class="div4">조회수</div>
                  </div>
                </div>
                <div class="cell4">
                  <div class="content3">
                    <div class="div4">댓글 수</div>
                  </div>
                </div>
                <div class="cell5">
                  <div class="content2">
                    <div class="div4">좋아요</div>
                  </div>
                </div>
                <div class="cell6">
                  <div class="content4">
                    <div class="div4">작성자</div>
                  </div>
                </div>
                <div class="cell7">
                  <div class="content4">
                    <div class="title">작성일자</div>
                  </div>
                </div>
                <div class="cell8">
                  <div class="content5">
                    <div class="title">no</div>
                  </div>
                </div>
                <div class="cell9">
                  <div class="content2"></div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-602" src="../../../resources/images/admin/frame-601.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image0.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f0.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-603" src="../../../resources/images/admin/frame-602.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image1.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f2"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f1.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-604" src="../../../resources/images/admin/frame-603.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image2.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f3"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f2.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-605" src="../../../resources/images/admin/frame-604.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image3.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f4"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f3.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-606" src="../../../resources/images/admin/frame-605.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image4.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f5"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f4.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-607" src="../../../resources/images/admin/frame-606.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image5.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f6"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f5.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-608" src="../../../resources/images/admin/frame-607.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image6.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f7"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f6.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-609" src="../../../resources/images/admin/frame-608.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image7.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f8"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f7.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-6010" src="../../../resources/images/admin/frame-609.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image8.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f9"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f8.svg"
                    />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="cell10">
                  <div class="content">
                    <div class="controls">
                      <img class="frame-6011" src="../../../resources/images/admin/frame-6010.svg" />
                    </div>
                  </div>
                </div>
                <div class="cell11">
                  <div class="content6">
                    <div class="user-card">
                      <img class="image" src="../../../resources/images/admin/image9.png" />
                      <div class="details">
                        <div class="category">오늘도 나는 책을 읽는다..</div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="cell12">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell13">
                  <div class="content7">
                    <div class="cell-text">6</div>
                  </div>
                </div>
                <div class="cell14">
                  <div class="content7">
                    <div class="_3">3</div>
                  </div>
                </div>
                <div class="cell15">
                  <div class="content7">
                    <div class="cell-text">김예슬</div>
                  </div>
                </div>
                <div class="cell16">
                  <div class="content7">
                    <div class="cell-text">2024/12/21</div>
                  </div>
                </div>
                <div class="cell17">
                  <div class="content8">
                    <div class="badge">
                      <div class="text3">no.198</div>
                    </div>
                  </div>
                </div>
                <div class="cell18">
                  <div class="content9">
                    <img
                      class="icon-jam-icons-filled-more-horizontal-f10"
                      src="../../../resources/images/admin/icon-jam-icons-filled-more-horizontal-f9.svg"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
       
        
        <div class="pagination3">
          <div class="pagination4">
            <img
              class="icon-jam-icons-outline-logos-chevron-left"
              src="../../../resources/images/admin/icon-jam-icons-outline-logos-chevron-left0.svg"
            />
            <div class="text-container">
              <div class="page">Previous</div>
            </div>
          </div>
          <div class="pagination4">
            <div class="text-container2">
              <div class="page2">1</div>
            </div>
          </div>
          <div class="pagination5">
            <div class="text-container">
              <div class="page3">2</div>
            </div>
          </div>
          <div class="pagination4">
            <div class="text-container2">
              <div class="page2">3</div>
            </div>
          </div>
          <div class="pagination4">
            <div class="text-container2">
              <div class="page2">4</div>
            </div>
          </div>
          <div class="pagination4">
            <div class="text-container2">
              <div class="page2">5</div>
            </div>
          </div>
          <div class="pagination4">
            <div class="text-container2">
              <div class="page2">...</div>
            </div>
          </div>
          <div class="pagination4">
            <div class="text-container2">
              <div class="page2">11</div>
            </div>
          </div>
          <div class="pagination4">
            <div class="text-container2">
              <div class="page2">Next</div>
            </div>
            <img
              class="icon-jam-icons-outline-logos-chevron-right"
              src="../../../resources/images/admin/icon-jam-icons-outline-logos-chevron-right0.svg"
            />
          </div>
        </div>
      </div>
    </div>
    <!-- <div class="type-primary-size-medium-status-enable">
      <div class="button">삭제</div>
    </div> -->
    
    <div class="delete-button-container">
      <div class="type-primary-size-medium-status-enable2">
        <div class="button">삭제</div>
      </div>
    </div>
  </div>
  
</body>
</html>