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
//パスワード付き本棚（追加実装）
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
      
             status.open('POST',"http://localhost:8080/SeattleLibrary/addShelf?bookId="+arr+"");
             status.send();           
}
//モーダル機能（追加実装）
//ロードが完了したらイベント開始
window.addEventListener('load', (event) => {
// モーダルやボタンの定義
const modal = document.getElementById('modal');
const okButton = document.getElementById('ok');
const cancelButton = document.getElementById('cancel');
const links = document.querySelectorAll('.modalLogout');
let targetHref;

// モーダルを表示
function showModal(event) {
  // イベントに対するデフォルトの動作を止める
  event.preventDefault();
  targetHref = event.currentTarget.href;
  // モーダルをblockに変えて表示
  modal.style.display = 'block';
  }

// モーダルを非表示にする
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
//読了チェックのラジオボタン（追加実装）
function radio_func(check,id) {
	console.log(check);
    var status = new XMLHttpRequest();
      status.open('POST',"http://localhost:8080/SeattleLibrary/readStatus?value="+check+"&bookId="+id+"");
       status.send();
}

window.onload = function(){
	 let unread = document.getElementsByClassName('unread');
	 let label_unread = document.getElementsByClassName('label_unread');
	 for(let i =0;i<unread.length;i++){
	  var val = 'unread'+(i+1);
	  unread[i].setAttribute("id",val);
	  label_unread[i].setAttribute("for",val);
	  /* console.log(unread[i]);
	  console.log(label_unread[i]); */
	 }

	 let read = document.getElementsByClassName('read');
	 let label_read = document.getElementsByClassName('label_read');
	 for(let i =0;i<read.length;i++){
	  var val = 'read'+(i+1);
	  read[i].setAttribute("id",val);
	  label_read[i].setAttribute("for",val);
	  /* console.log(read[i]);
	  console.log(label_read[i]); */
	 }

	 let reading = document.getElementsByClassName('reading');
	 let label_reading = document.getElementsByClassName('label_reading');
	 for(let i =0;i<reading.length;i++){
	  var val = 'reading'+(i+1);
	  reading[i].setAttribute("id",val);
	  label_reading[i].setAttribute("for",val);
	  /* console.log(reading[i]);
	  console.log(label_reading[i]); */
	 }
}
</script>
    <header>
        <div class="left">
            <img class="mark" src="resources/img/logo.png" />
            <div class="logo">Seattle Library</div>
        </div>
        <div class="right">
        <div class="overlay"></div>
  		<nav class="nav">
    <div class="toggle">
      	<span id="deleteconpo" class="toggler"></span>
    </div>
    <div class="logo">
      	<a href="#">MENU</a>
    </div>
    	<ul class="linkList">
      	<li><a href="<%=request.getContextPath()%>/home">Home</a></li>
      	<li><a href="<%=request.getContextPath()%>/addBook">AddBook</a></li>
      	<li><a href="<%=request.getContextPath()%>/addFavorite">Favorite</a></li>
      	<li><a href="<%=request.getContextPath()%>/loginBookShelf">MyShelf</a></li>
      	<li><a href="<%=request.getContextPath()%>/">Logout</a></li>
    </ul>
  		</nav>
  		<!-- 検索窓（追加実装） -->
        <form action="search" class="search-form-002">
    		<label>
        	<input type="text" name="searchWord" placeholder="キーワードを入力">
   			</label>		
    		<button type="submit" aria-label="検索"></button>
		</form>
        </div>
        <!-- モーダル（追加実装） -->
        <div id="modal" class="modal">
  			<div class="modal-content">
    		<p>本当にログアウトしてよろしいですか？</p>
    	<div class="modal--btn__block">
      		<a id="cancel">キャンセル</a>
      		<a id="ok" href="<%=request.getContextPath()%>/">OK</a>
    	</div>
  	</div>
</div>
    </header>
    <main>
        <h1>Home</h1>
        <!-- ジャンル分けセレクトボックス（追加実装） -->
        <input type="button" form="form1" class="btn_add_book" value="+AddMyShelf" onclick="shelf()">
      <form method="GET" action="class">
       	<label class="selectbox-003">
    	<select name="bookGenre">
        	<option>選択してください</option>
        	<option>小説</option>
        	<option>漫画</option>
        	<option>絵本</option>
   		</select>
		</label>
		<button class="button-013">表示</button>
		</form>
		<!-- 並び替えセレクトボックス（追加実装） -->
		<form method="get" action="sortOrders">
            <p>
              <label class="selectbox-003"> 
               <select name="sortOrder">
                 <option>並び替え</option>
                 <option value="sortASC">タイトル(昇順)</option>
                 <option value="sortDESC">タイトル(降順)</option>
                 <option value="sortPlASC">出版日順(昇順)</option>
                 <option value="sortPlDESC">出版日順(降順)</option>
               </select>
              </label>
                 <button type="submit" name="submit" class="button-013">表示</button>
            </p>
         </form>
        <div class="content_body">
            <c:if test="${!empty resultMessage}">
                <div class="error_msg">${resultMessage}</div>
            </c:if>
            <!-- パスワード付き本棚（追加実装） -->
            <div>
                <div class="booklist">
                    <c:forEach var="bookInfo" items="${bookList}">
                        <div class="books">
                        <form method="post" name="form1" id="form1" class="shelfCheck" action="addShelf">
         					<input type="checkbox" name="bookShelf" value="${bookInfo.bookId}"
          							id="shelfBtn">📚
        				</form>
        				<!-- お気に入りボタン（追加実装） -->
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
                                <button class="button-063" onclick="location.href='https://www.amazon.co.jp/s?k=${bookInfo.title}&ref=nb_sb_noss'" value="購入">購入</button>   
                                <c:if test="${bookInfo.status == NULL}">
                                <!-- 読了チェックラジオボタン（追加実装） -->
                                <div class="radioBooks">
                                	<div class="radioRead">
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
<script>
//ドロワーメニュー（追加実装）
const toggler = document.querySelector(".toggle");

window.addEventListener("click", event => {
  if(event.target.className == "toggle" || event.target.className == "toggle") {
    document.body.classList.toggle("show-nav");
    document.getElementById("deleteconpo").classList.toggle("deleteclass")
  } else if (event.target.className == "overlay") {
    document.body.classList.remove("show-nav");
document.getElementById("deleteconpo").classList.toggle("deleteclass")
  }

});


//ドロワーのメニューをクリックしたら非表示
const hrefLink = document.querySelectorAll('.linkList li a');
for (i = 0; i < hrefLink.length; i++) {
hrefLink[i].addEventListener("click", () => {
document.body.classList.remove("show-nav");
document.getElementById("deleteconpo").classList.toggle("deleteclass")
});
}
</script>
</body>
</html>
