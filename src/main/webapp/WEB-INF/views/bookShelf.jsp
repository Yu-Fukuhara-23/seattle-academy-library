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
<script>
function shelf(){
    console.log("10");
    const arr = [];
    let aaa=0;
    const chk1 = document.getElementsByName("bookShelf");
       console.log(chk1);
    for (let i = 0; i < chk1.length; i++) {
      if (chk1[i].checked) {
       console.log(chk1[i].value+" "+i);
           arr.push(chk1[i].value); 
      }
    }
         var status = new XMLHttpRequest();
      
             status.open('POST',"http://localhost:8080/SeattleLibrary/deleteShelf?bookId="+arr+"");
             status.send();  
}
//ロードが完了したらイベント開始
window.addEventListener('load', (event) => {
// モーダルやボタンの定義
const modal = document.getElementById('modal');
const okButton = document.getElementById('ok');
const cancelButton = document.getElementById('cancel');
const links = document.querySelectorAll('.modalLogout');
let targetHref;

// モーダル表示の関数定義
function showModal(event) {
  // イベントに対するデフォルトの動作を止める
  event.preventDefault();
  targetHref = event.currentTarget.href;
  // モーダルをblockに変えて表示
  modal.style.display = 'block';
  }

// モーダル非表示の関数定義
function hideModal() {
  modal.style.display = 'none';
  }

// OKボタンがクリックされたら
okButton.addEventListener('click', () => {
  window.location.href = targetHref;
});

// キャンセルボタンがクリックされたら
cancelButton.addEventListener('click', hideModal);
  modal.addEventListener('click', (event) => {
    if (event.target === modal) {
    hideModal();
    }
  });

  links.forEach(link => {
    link.addEventListener('click', showModal);
});
});
</script>
    <header>
        <div class="left">
            <img class="mark" src="resources/img/logo.png" />
            <div class="logo">Seattle Library</div>
        </div>
        <div class="right">
        <form action="search" class="search-form-002">
    		<label>
        	<input type="text" name="searchWord" placeholder="キーワードを入力">
   			</label>		
    		<button type="submit" aria-label="検索"></button>
		</form>
            <ul>
                <li><a href="<%=request.getContextPath()%>/home" class="menu">Home</a></li>
                <li><button class="modalLogout">ログアウト</button></li>
            </ul>
        </div>
        <div id="modal" class="modal">
  			<div class="modal-content">
    		<p>本当にログアウトしてよろしいですか？</p>
    	<div class="modal--btn__block">
      		<a id="cancel">キャンセル</a>
      		<a id="ok" href="<%=request.getContextPath()%>/">OK</a>
    	</div>
    </header>
    <main>
        <h1>本棚</h1>
        <a href="<%=request.getContextPath()%>/addBook" class="btn_add_book">書籍の追加</a>
        <a href="<%=request.getContextPath()%>/addFavorite" class="btn_add_book">お気に入り</a>
        <input type="button" form="form1" class="btn_add_book" value="本棚から削除" onclick="shelf()">
       <label class="selectbox-003">
    	<select>
        	<option>選択してください</option>
        	<option>小説</option>
        	<option>漫画</option>
        	<option>絵本</option>
   		</select>
		</label>
        <div class="content_body">
            <c:if test="${!empty resultMessage}">
                <div class="error_msg">${resultMessage}</div>
            </c:if>
            <div>
                <div class="booklist">
                    <c:forEach var="bookInfo" items="${bookList}">
                        <div class="books">
                        <form method="post" name="form1" id="form1" class="shelfCheck" action="deleteShelf">
         					<input type="checkbox" name="bookShelf" value="${bookInfo.bookId}"
         							id="shelfBtn">📚
        				</form>
                        <c:if test="${!(bookInfo.favorite.equals('Like'))}">
                                <form method="GET" action="favorited" name="favorite">
                                    <p align="justify">                     
                                        <button type=submit class="button-064">♡ Like</button>
                                        <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                    </p>
                                </form>
                                </c:if><c:if test="${bookInfo.favorite.equals('Like')}">
                                    <form method="GET" action="unliked" name="nonFavorite">
                                        <p align="justify">
                                            <button type=submit class="unlikeButton">♡ Unlike</button>
                                            <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                        </p>
                                    </form>
                                   </c:if>
                       <%-- <form method="get" action="favorited">
    						<input type="hidden" name="bookId" value="${bookInfo.bookId}">
        					<button  type=submit class="button-064">Like</button>
						</form> --%>
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
