<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>리플렛 - 검색 예외처리 </title>
    <link rel="stylesheet" href="../../../resources/css/search/style.css" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="../../../resources/css/headerstyle.css">

    <script
      src="https://code.jquery.com/jquery-3.7.1.min.js"
      integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
  </head>
  <body>
  <header>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
  </header>

    <div id="wrapper" class="py-3">
      <div class="tab_menu">
        <ul class="d-flex justify-content-center gap-4 fw-bold">
          <li data-path="searchMain"><a class="tm_a py-2" href="/search/total?keyword=${param.keyword}">Overview</a></li>
          <li data-path="searchBook"><a class="tm_a py-2" href="/search/total/book?keyword=${param.keyword}"> Book </a></li>
          <li data-path="searchAuthor"><a class="tm_a py-2" href="/search/total/author?keyword=${param.keyword}"> Author </a></li>
          <li class="active" data-path="searchPost"><a class="tm_a py-2" href="#">Post</a></li>
          <li data-path="searchUsers"><a class="tm_a py-2" href="/search/total/user?keyword=${param.keyword}">User</a></li>
        </ul>
      </div>
      <!-- /tab_menu -->

      <div class="container py-5 px-0 overflow-hidden">
        <section class="noSearch py-5">
          <h3 class="mb-5 fw-bold">
            <span class="searchText" style="color: var(--color-red)">'${keyword}'</span
            >에 대한 검색 결과가 없습니다
          </h3>

          <ul>
            <li>&#183; 단어의 철자가 정확한지 확인해 보세요.</li>
            <li>&#183; 검색어는 최소 길이가 1자 이상이어야 합니다.</li>
            <li>&#183; 검색어는 한글, 영어, 숫자만 포함해야 합니다.</li>
            <li>&#183; 의미 없는 특수 문자로만 구성된 경우는 제외됩니다.</li>
          </ul>
        </section>
        <!-- /noSearch -->
      </div>
      <!-- /container -->
    </div>
    <!-- /wrapper -->
  </body>
</html>
