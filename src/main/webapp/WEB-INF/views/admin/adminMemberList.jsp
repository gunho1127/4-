<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../../../resources/css/admin/adminmemberList.css">
  
  
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
  <title>Document</title>
</head>
<body>
  <div class="ui-021">
    <div class="desktop-vertical-logged-in-buttons-bottom">
      <div class="logo-container">
        <div class="logo">
          <div class="text">
            <div class="div">관리자</div>
          </div>
        </div>
      </div>
      <div class="buttons-group">
        <div class="user-thumb">
          <img
            class="icon-tabler-icons-brightness-2"
            src="../../../resources/images/admin/resource/icon-tabler-icons-brightness-20.svg"
          />
        </div>
      </div>
      <div class="menu">
        <div class="menu-item">
          <img class="icon" src="../../../resources/images/admin/resource/icon0.svg" />
          <div class="div2">관리자 정보</div>
        </div>
        <div class="menu-item2">
          <img
            class="icon-feathericons-file-text"
            src="../../../resources/images/admin/resource/icon-feathericons-file-text0.svg"
          />
          <div class="div2">회원 관리</div>
        </div>
        <div class="menu-item">
          <img
            class="icon-jam-icons-outline-logos-pictures"
            src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-pictures0.svg"
          />
          <div class="div2">커뮤니티</div>
        </div>
        <div class="menu-item">
          <img
            class="icon-heroicons-outline-lock-open"
            src="../../../resources/images/admin/resource/icon-heroicons-outline-lock-open0.svg"
          />
          <div class="div2">로그아웃</div>
        </div>
      </div>
    </div>
    <div class="page-content">
      <div class="headline">
        <div class="section-text">
          <div class="top">
            <div class="secondary-headline">회원 목록</div>
          </div>
        </div>
      </div>
      <div class="dashboard-tabs">
        <div class="fields">
          <div class="field">
            <img
              class="icon-jam-icons-outline-logos-search"
              src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-search0.svg"
            />
            <div class="div3">분류</div>
            <img class="vector" src="../../../resources/images/admin/vector0.svg" />
            <div class="text2">Search</div>
          </div>
        </div>
      </div>
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
              <div class="title">이름</div>
              <img
                class="icon-iconoir-arrow-down"
                src="../../../resources/images/admin/resource/icon-iconoir-arrow-down0.svg"
              />
            </div>
          </div>
          <div class="cell3">
            <div class="content2">
              <div class="title">작성글</div>
            </div>
          </div>
          <div class="cell3">
            <div class="content2">
              <div class="title">리뷰</div>
            </div>
          </div>
          <div class="cell3">
            <div class="content2">
              <div class="title">팔로잉</div>
            </div>
          </div>
          <div class="cell3">
            <div class="content2">
              <div class="title">팔로워</div>
            </div>
          </div>
          <div class="cell3">
            <div class="content2">
              <div class="title">회원 유형</div>
            </div>
          </div>
          <div class="cell4">
            <div class="content2"></div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-602" src="../../../resources/images/admin/resource/frame-601.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user0.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f0.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-603" src="../../../resources/images/admin/resource/frame-602.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user2"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user1.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f2"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f1.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-604" src="../../../resources/images/admin/resource/frame-603.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user3"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user2.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f3"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f2.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-605" src="../../../resources/images/admin/resource/frame-604.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user4"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user3.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f4"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f3.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-606" src="../../../resources/images/admin/resource/frame-605.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user5"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user4.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f5"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f4.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-607" src="../../../resources/images/admin/resource/frame-606.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user6"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user5.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f6"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f5.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-608" src="../../../resources/images/admin/resource/frame-607.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user7"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user6.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f7"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f6.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-609" src="../../../resources/images/admin/resource/frame-608.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user8"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user7.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f8"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f7.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-6010" src="../../../resources/images/admin/resource/frame-609.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user9"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user8.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f9"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f8.svg"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="cell5">
            <div class="content">
              <div class="controls">
                <img class="frame-6011" src="../../../resources/images/admin/resource/frame-6010.svg" />
              </div>
            </div>
          </div>
          <div class="cell6">
            <div class="content3">
              <div class="user-card">
                <div class="user-thumb2">
                  <img
                    class="icon-jam-icons-outline-logos-user10"
                    src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-user9.svg"
                  />
                </div>
                <div class="details">
                  <div class="category">책책이</div>
                  <div class="category2">example@email.com</div>
                </div>
              </div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">6</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">3</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">14</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content4">
              <div class="cell-text">12/21</div>
            </div>
          </div>
          <div class="cell7">
            <div class="content5">
              <div class="badge">
                <div class="text3">일반</div>
              </div>
            </div>
          </div>
          <div class="cell8">
            <div class="content6">
              <img
                class="icon-jam-icons-filled-more-horizontal-f10"
                src="../../../resources/images/admin/resource/icon-jam-icons-filled-more-horizontal-f9.svg"
              />
            </div>
          </div>
        </div>
      </div>
      <div class="type-primary-size-medium-status-enable">
        <div class="button">삭제</div>
      </div>
      <div class="pagination">
        <div class="pagination2">
          <img
            class="icon-jam-icons-outline-logos-chevron-left"
            src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-chevron-left0.svg"
          />
          <div class="text-container">
            <div class="page">Previous</div>
          </div>
        </div>
        <div class="pagination2">
          <div class="text-container2">
            <div class="page2">1</div>
          </div>
        </div>
        <div class="pagination3">
          <div class="text-container">
            <div class="page3">2</div>
          </div>
        </div>
        <div class="pagination2">
          <div class="text-container2">
            <div class="page2">3</div>
          </div>
        </div>
        <div class="pagination2">
          <div class="text-container2">
            <div class="page2">4</div>
          </div>
        </div>
        <div class="pagination2">
          <div class="text-container2">
            <div class="page2">5</div>
          </div>
        </div>
        <div class="pagination2">
          <div class="text-container2">
            <div class="page2">...</div>
          </div>
        </div>
        <div class="pagination2">
          <div class="text-container2">
            <div class="page2">11</div>
          </div>
        </div>
        <div class="pagination2">
          <div class="text-container2">
            <div class="page2">Next</div>
          </div>
          <img
            class="icon-jam-icons-outline-logos-chevron-right"
            src="../../../resources/images/admin/resource/icon-jam-icons-outline-logos-chevron-right0.svg"
          />
        </div>
      </div>
    </div>
  </div>
  
</body>
</html>