editBook.jsp

<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta charset="UTF-8">
<title>書籍の追加｜シアトルライブラリ｜シアトルコンサルティング株式会社</title>
<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP" rel="stylesheet">
<link href="<c:url value="/resources/css/default.css" />" rel="stylesheet" type="text/css">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="resources/js/thumbnail.js"></script>
</head>
<body class="wrapper">
				<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
				<script>
        $(function() {
            $("#adultButton").click(function() {
                $("#ageConfirmationModal").show();
            });

            $("#disapear").click(function() {
             $("#ageConfirmationModal").fadeOut();
            });
            
            $("#confirmYes").click(function() {
                window.location.href = "http://localhost:8080/SeattleLibrary/deleteBook";
            });

            $("#confirmNo").click(function() {
                $("#ageConfirmationModal").fadeOut();
            });
        });

        links.forEach(link => {
            link.addEventListener('click', showModal);
        });
        });

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
				</script>
				<header>
								<div class="left">
												<img class="mark" src="resources/img/logo.png" />
												<div class="logo">Seattle Library</div>
								</div>
								<div class="right">
												<ul>
																<li><a href="<%=request.getContextPath()%>/home" class="menu">Home</a></li>
																<li><button class="modalLogout">ログアウト</button></li>
												</ul>
								</div>
								<div id="modal" class="modal">
												<div class="modal-content">
																<p>本当にログアウトしてよろしいですか？</p>
																<div class="modal--btn__block">
																				<a id="cancel">キャンセル</a> <a id="ok" href="<%=request.getContextPath()%>/">OK</a>
																</div>
				</header>
				<main>
								<form action="<%=request.getContextPath()%>/updateBook" method="post" enctype="multipart/form-data" id="data_upload_form">
												<h1>書籍の編集</h1>
												<div class="content_body add_book_content">
																<div>
																				<span>書籍の画像</span><span class="care care1">任意</span>
																				<div class="book_thumnail">
																								<c:if test="${empty bookInfo.thumbnailUrl}">
																												<img class="book_noimg" src="resources/img/noImg.png">
																								</c:if>
																								<c:if test="${!empty bookInfo.thumbnailUrl}">
																												<img class="book_noimg" src="${bookInfo.thumbnailUrl}">
																								</c:if>
																				</div>
																				<input type="file" accept="image/*" name=thumbnail id="thumbnail">
																</div>
																<div class="content_right">
																				<div>
																								<c:if test="${!empty errorList}">
																												<div class="error">
																																<c:forEach var="error" items="${errorList}">
																																				<p>${error}</p>
																																</c:forEach>
																												</div>
																								</c:if>
																								<span>書籍名</span><span class="care care2">必須</span> <input type="text" name="title" value="${bookInfo.title}">
																				</div>
																				<div>
																								<span>著者名</span><span class="care care2">必須</span> <input type="text" name="author" value="${bookInfo.author}">
																				</div>
																				<div>
																								<span>出版社</span><span class="care care2">必須</span> <input type="text" name="publisher" value="${bookInfo.publisher}">
																				</div>
																				<div>
																								<span>出版日</span><span class="care care2">必須</span> <input type="text" name="publishDate" value="${bookInfo.publishDate}">
																				</div>
																				<div>
																								<span>ジャンル</span><span class="care care1">任意</span> <label class="selectbox-005"> <select name="bookGenre">
																																<option value="firstSelect">選択してください</option>
																																<option value="小説">小説</option>
																																<option value="漫画">漫画</option>
																																<option value="絵本">絵本</option>
																								</select>
																								</label>
																				</div>
																				<div>
																								<span>ISBN</span><span class="care care1">任意</span>
																								<c:if test="${!empty bookInfo}">
																												<input type="text" name="isbn" value="${bookInfo.isbn}">
																								</c:if>
																								<c:if test="${empty bookInfo}">
																												<input type="text" name="isbn">
																								</c:if>
																				</div>
																				<div>
																								<span>説明文</span><span class="care care1">任意</span>
																								<c:if test="${!empty bookInfo}">
																												<input type="text" name="description" value="${bookInfo.description}">
																								</c:if>
																								<c:if test="${empty bookInfo}">
																												<input type="text" name="description">
																								</c:if>
																				</div>
																				<input type="hidden" id="bookId" name="bookId" value="${bookInfo.bookId}">
																</div>
												</div>
												<div class="bookBtn_box">
																<button type="submit" id="add-btn" class="btn_updateBook">更新</button>
								</form>
								<div class="deleteMove">
												<button type="button" id="adultButton" class="btn_deleteBook">削除</button>
												<!-- モーダル -->
												<div id="ageConfirmationModal" class="modal">
																<div class="modal-dialog">
																				<div class="modal-content">
																								<div class="modal-header">
																												</button>
																								</div>
																								<div class="modal-body">
																												<p>本当に削除しますか？</p>
																								</div>
																								<div class="modal-footer">
																												<form method="post" action="deleteBook">
																																<input type="hidden" id="bookId" name="bookId" value="${bookInfo.bookId}"> <a id="confirmYes" class="modal-button">はい
																																				</button>
																												</form>
																												<a id="confirmNo" class="modal-button" data-dismiss="modal">いいえ
																																</button>
																								</div>
																				</div>
																</div>
												</div>
								</div>
								</div>
				</main>
</body>
</html>