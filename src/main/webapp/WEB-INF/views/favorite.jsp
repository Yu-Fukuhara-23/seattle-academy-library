<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html; charset=utf8"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>ホーム｜シアトルライブラリ｜シアトルコンサルティング株式会社</title>
<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP" rel="stylesheet">
<link href="<c:url value="/resources/css/default.css" />" rel="stylesheet" type="text/css">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet" type="text/css">
</head>
<body class="wrapper">
    <header>
        <div class="left">
            <img class="mark" src="resources/img/logo.png" />
            <div class="logo">Seattle Library</div>
        </div>
        <div class="right">
        <form action="searchFav" class="search-form-002">
    		<label>
        	<input type="text" name="searchWord" placeholder="キーワードを入力">
   			</label>		
    		<button type="submit" aria-label="検索"></button>
		</form>
            <ul>
                <li><a href="<%=request.getContextPath()%>/home" class="menu">Home</a></li>
                <li><a href="<%=request.getContextPath()%>/">ログアウト</a></li>
            </ul>
        </div>
    </header>
    <main>
        <h1>Home</h1>
        <a href="<%=request.getContextPath()%>/addBook" class="btn_add_book">書籍の追加</a>
        <a href="<%=request.getContextPath()%>/addFavorite" class="btn_add_book">お気に入り</a>
        <div class="content_body">
            <c:if test="${!empty resultMessage}">
                <div class="error_msg">${resultMessage}</div>
            </c:if>
            <div>
                <div class="booklist">
                    <c:forEach var="bookInfo" items="${bookList}">
                        <div class="books">
                        <c:if test="${!(bookInfo.favorite.equals('Like'))}">
                                <form method="GET" action="favBook" name="favorite">
                                    <p align="justify">                     
                                        <button type=submit class="button-064">♡ Like</button>
                                        <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                    </p>
                                </form>
                                </c:if><c:if test="${bookInfo.favorite.equals('Like')}">
                                    <form method="GET" action="unlike" name="nonFavorite">
                                        <p align="justify">
                                            <button type=submit class="unlikeButton">♡ Unlike️</button>
                                            <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                        </p>
                                    </form>
                                   </c:if>
                            <form method="get" class="book_thumnail" action="editBook">
                                <a href="javascript:void(0)" onclick="this.parentNode.submit();"> <c:if test="${empty bookInfo.thumbnail}">
                                        <img class="book_noimg" src="resources/img/noImg.png">
                                    </c:if> <c:if test="${!empty bookInfo.thumbnail}">
                                        <img class="book_noimg" src="${bookInfo.thumbnail}">
                                    </c:if>
                                </a> <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                            </form>
                            <ul>
                                <li class="book_title">${bookInfo.title}</li>
                                <li class="book_author">${bookInfo.author}(著)</li>
                                <li class="fusen-001">${bookInfo.bookGenre}</li>
                                <li class="book_publisher">出版社：${bookInfo.publisher}</li>
                                <li class="book_publish_date">出版日：${bookInfo.publishDate}</li>
                                <c:if test="${bookInfo.status == NULL}">
                                <div class="radioIchito">
                                	<div class="radioShage">
    								<div><input class="radio_btn unread" type="radio" name="site${bookInfo.bookId}"
    									value="1" onchange="radio_func(this.value,${bookInfo.bookId})" checked> 
    									<label class="radio-001 label_unread"></label>
    									<p class="status">未読</p>
    								</div>
    								<div><input class="radio_btn reading" type="radio" name="site${bookInfo.bookId}"
    									value="2" onchange="radio_func(this.value,${bookInfo.bookId})">
    									<label class="radio-001 label_reading"></label>
    									<p class="status">読書中</p>
    								</div>
    								<div><input class="radio_btn read" type="radio" name="site${bookInfo.bookId}"
    									value="3" onchange="radio_func(this.value,${bookInfo.bookId})"> 
    									<label class="radio-001 label_read"></label>
    									<p class="status">読了</p>
    								</div>
    								</div>
    							</div>
    							</c:if>
    							<c:if test="${bookInfo.status.equals('1')}">
    							<div class="radioIchito">
    								<div class="radioShage">
    								<div><input class="radio_btn unread" type="radio" name="site${bookInfo.bookId}"
    									value="1" onchange="radio_func(this.value,${bookInfo.bookId})" checked> 
    									<label class="radio-001 label_unread"></label>
    									<p class="status">未読</p>
    								</div>
    								<div><input class="radio_btn reading" type="radio" name="site${bookInfo.bookId}"
    									value="2" onchange="radio_func(this.value,${bookInfo.bookId})"> 
    									<label class="radio-001 label_reading"></label>
    									<p class="status">読書中</p>
    								</div>
    								<div><input class="radio_btn read" type="radio" name="site${bookInfo.bookId}"
    									value="3" onchange="radio_func(this.value,${bookInfo.bookId})"> 
    									<label class="radio-001 label_read"></label>
    									<p class="status">読了</p>
    								</div>
    								</div>
    							</div>
    							</c:if>
    							<c:if test="${bookInfo.status.equals('2')}">
    							<div class="radioIchito">
    								<div class="radioShage">
    								<div><input class="radio_btn unread" type="radio" name="site${bookInfo.bookId}"
    									value="1" onchange="radio_func(this.value,${bookInfo.bookId})"> 
    									<label class="radio-001 label_unread"></label>
    									<p class="status">未読</p>
    								</div>
    								<div><input class="radio_btn reading" type="radio" name="site${bookInfo.bookId}"
    									value="2" onchange="radio_func(this.value,${bookInfo.bookId})" checked> 
    									<label class="radio-001 label_reading"></label>
    									<p class="status">読書中</p>
    								</div>
    								<div><input class="radio_btn read" type="radio" name="site${bookInfo.bookId}"
    									value="3" onchange="radio_func(this.value,${bookInfo.bookId})"> 
    									<label class="radio-001 label_read"></label>
    									<p class="status">読了</p>
    								</div>
    								</div>
    							</div>
    							</c:if>
    							<c:if test="${bookInfo.status.equals('3')}">
    							<div class="radioIchito">
    								<div class="radioShage">
    								<div><input class="radio_btn unread" type="radio" name="site${bookInfo.bookId}"
    									value="1" onchange="radio_func(this.value,${bookInfo.bookId})"> 
    									<label class="radio-001 label_unread"></label>
    									<p class="status">未読</p>
    								</div>
    								<div><input class="radio_btn reading" type="radio" name="site${bookInfo.bookId}"
    									value="2" onchange="radio_func(this.value,${bookInfo.bookId})"> 
    									<label class="radio-001 label_reading"></label>
    									<p class="status">読書中</p>
    								</div>
    								<div><input class="radio_btn read" type="radio" name="site${bookInfo.bookId}"
    									value="3" onchange="radio_func(this.value,${bookInfo.bookId})"checked> 
    									<label class="radio-001 label_read"></label>
    									<p class="status">読了</p>
    								</div>
    								</div>
    							</div>
    							</c:if>
                            </ul>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
    <ol class="pagination-003">
    <li class="prev"><a href="#"><</a></li>
    <li><a href="#">1</a></li>
    <li class="current"><a href="#">2</a></li>
    <li><a href="#">3</a></li>
    <li><a href="#">4</a></li>
    <li><a href="#">5</a></li>
    <li class="next"><a href="#">></a></li>
</ol>
</body>
</html>
