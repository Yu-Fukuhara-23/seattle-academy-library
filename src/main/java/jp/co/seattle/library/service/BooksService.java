package jp.co.seattle.library.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import jp.co.seattle.library.dto.BookDetailsInfo;
import jp.co.seattle.library.dto.BookInfo;
import jp.co.seattle.library.rowMapper.BookDetailsInfoRowMapper;
import jp.co.seattle.library.rowMapper.BookInfoRowMapper;

/**
 * 書籍サービス
 * 
 * booksテーブルに関する処理を実装する
 */
@Service
public class BooksService {
	final static Logger logger = LoggerFactory.getLogger(BooksService.class);
	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 書籍リストを取得する
	 
	 * @return 書籍リスト
	 */
	public List<BookInfo> getBookList() {

		// TODO 書籍名の昇順で書籍情報を取得するようにSQLを修正（タスク３）
		List<BookInfo> getedBookList = jdbcTemplate.query(
				"SELECT * FROM books ORDER BY title ASC;",
				new BookInfoRowMapper());

		return getedBookList;
	}

	public List<BookInfo> sortGetBookListAsc() {

		  // TODO 書籍名の昇順で書籍情報を取得するようにSQLを修正（追加実装）
		  List<BookInfo> getedBookList = jdbcTemplate.query(
		    "SELECT * FROM books ORDER BY title ASC;",
		    new BookInfoRowMapper());

		  return getedBookList;
	}

	public List<BookInfo> sortGetBookListDesc() {
		  //書籍の降順（追加実装）
		  List<BookInfo> getedBookList = jdbcTemplate.query(
		    "SELECT * FROM books ORDER BY title DESC;",
		    new BookInfoRowMapper());
		  return getedBookList;
		 }
	
	public List<BookInfo> sortBookListPlDateAsc() {
		  // 出版日の昇順（追加実装）
		  List<BookInfo> getedBookList = jdbcTemplate.query(
		    "SELECT * FROM books ORDER BY publish_Date ASC;",
		    new BookInfoRowMapper());
		  return getedBookList;
		 }
	
	public List<BookInfo> sortBookListPlDateDesc() {
		  // 出版日の降順（追加実装）
		  List<BookInfo> getedBookList = jdbcTemplate.query(
		    "SELECT * FROM books ORDER BY publish_Date DESC;",
		    new BookInfoRowMapper());
		  return getedBookList;
		 }
	
	
	public List<BookInfo> getSearchList(String title) {
		// 検索機能（追加実装）
		List<BookInfo> getedSearchList = jdbcTemplate.query(
				"SELECT * FROM books WHERE title like concat('%',?,'%') OR bookGenre like concat('%',?,'%') ORDER BY title;",
				new BookInfoRowMapper(), title, title);

		return getedSearchList;
	}

	public List<BookInfo> getFavSearchList(String search) {
		// お気に入り検索機能（追加実装）
		List<BookInfo> getedSearchList = jdbcTemplate.query(
				"SELECT * FROM books WHERE favorite='Like' AND title like concat('%',?,'%') ORDER BY title;",
				new BookInfoRowMapper(), search, search);

		return getedSearchList;
	}

	public List<BookInfo> favoritePage() {
		// お気に入りリスト（追加実装）
		List<BookInfo> getedListFavorite = jdbcTemplate.query(
				"SELECT * FROM books WHERE favorite='Like' ORDER BY title;",
				new BookInfoRowMapper());

		return getedListFavorite;
	}

	public void favoriteList(int bookId) {
		// お気に入りボタンを押したらDBに登録される（追加実装）
		String sql = "UPDATE books SET favorite='Like' WHERE id = ?";
		jdbcTemplate.update(sql, bookId);
	}

	public void notFavoriteList(int bookId) {
		// もう一度お気に入りボタンを押したら削除される（追加実装）
		String sql = "UPDATE books SET favorite='unlike' WHERE id = ?";
		jdbcTemplate.update(sql, bookId);
	}

	
	
	/**
	 * 書籍IDに紐づく書籍詳細情報を取得する
	 *
	 * @param bookId 書籍ID
	 * @return 書籍情報
	 */
	public BookDetailsInfo getBookInfo(int bookId) {
		String sql = "SELECT id, title, author, publisher, publish_date, bookGenre, isbn, description, thumbnail_url, thumbnail_name, favorite, status FROM books WHERE books.id = ? ORDER BY title ASC;";

		BookDetailsInfo bookDetailsInfo = jdbcTemplate.queryForObject(sql, new BookDetailsInfoRowMapper(), bookId);

		return bookDetailsInfo;
	}

	/**
	 * 書籍を登録する
	 *
	 * @param bookInfo 書籍情報
	 * @return bookId 書籍ID
	 */
	public int registBook(BookDetailsInfo bookInfo) {
		// TODO 取得した書籍情報を登録し、その書籍IDを返却するようにSQLを修正（タスク４）
		String sql = "INSERT INTO books(title, author, publisher, publish_date, bookGenre, thumbnail_name, thumbnail_url, isbn, description, reg_date, upd_date) VALUES(?,?,?,?,?,?,?,?,?,now(),now()) RETURNING id;";

		int bookId = jdbcTemplate.queryForObject(sql, int.class, bookInfo.getTitle(), bookInfo.getAuthor(),
				bookInfo.getPublisher(), bookInfo.getPublishDate(), bookInfo.getBookGenre(),
				bookInfo.getThumbnailName(),
				bookInfo.getThumbnailUrl(), bookInfo.getIsbn(), bookInfo.getDescription());
		return bookId;
	}

	/**
	 * 書籍を削除する
	 * 
	 * @param bookId 書籍ID
	 */
	public void deleteBook(int bookId) {
		// TODO 対象の書籍を削除するようにSQLを修正（タスク6）
		String sql = "DELETE FROM books WHERE id = ?";
		jdbcTemplate.update(sql, bookId);
	}

	/**
	 * 書籍情報を更新する
	 * 
	 * @param bookInfo
	 */
	public void updateBook(BookDetailsInfo bookInfo) {
		String sql;
		if (bookInfo.getThumbnailUrl() == null) {
			// TODO 取得した書籍情報を更新するようにSQLを修正（タスク５）
			sql = "UPDATE books SET title=?, author=?, publisher=?, publish_date=?, bookGenre=?, ISBN=?, description=?, upd_date=now() WHERE id = ?;";
			jdbcTemplate.update(sql, bookInfo.getTitle(), bookInfo.getAuthor(), bookInfo.getPublisher(),
					bookInfo.getPublishDate(), bookInfo.getBookGenre(), bookInfo.getIsbn(), bookInfo.getDescription(),
					bookInfo.getBookId());
		} else {
			// TODO 取得した書籍情報を更新するようにSQLを修正（タスク５）
			sql = "UPDATE books SET title=?, author=?, publisher=?, publish_date=?, bookGenre=?, thumbnail_name=?, thumbnail_url=?, ISBN=?, description=?, upd_date=now() WHERE id = ?;";
			jdbcTemplate.update(sql, bookInfo.getTitle(), bookInfo.getAuthor(), bookInfo.getPublisher(),
					bookInfo.getPublishDate(), bookInfo.getBookGenre(), bookInfo.getThumbnailName(),
					bookInfo.getThumbnailUrl(),
					bookInfo.getIsbn(), bookInfo.getDescription(), bookInfo.getBookId());
		}
	}

	//パスワード付き本棚に登録されているものを取得（追加実装）
	public List<BookInfo> getShelfBook() {
		List<BookInfo> getedBookList = jdbcTemplate.query(
				"SELECT * FROM books WHERE shelf='register' ORDER BY title asc;",
				new BookInfoRowMapper());

		return getedBookList;
	}

	public void getRegistShelfBook(int bookId) {
		  String sql = "UPDATE books SET shelf='register' WHERE books.id = ?;";

		  jdbcTemplate.update(sql, bookId);
		 }
	
	public void getDeleteShelfBook(int bookId) {
		  String sql = "UPDATE books SET shelf='delete' WHERE books.id = ?;";

		  jdbcTemplate.update(sql, bookId);
		 }
	
	public List<BookInfo> getNovelList() {
		// セレクトボックスから得たい書籍情報を取得するようにSQLを修正（追加実装）
		List<BookInfo> getedNovelList = jdbcTemplate.query(
				"SELECT * FROM books WHERE bookGenre = '小説' ORDER BY title;",
				new BookInfoRowMapper());
		return getedNovelList;
	}

	public List<BookInfo> getComicList() {
		// セレクトボックスから得たい書籍情報を取得するようにSQLを修正（追加実装）
		List<BookInfo> getedComicList = jdbcTemplate.query(
				"SELECT * FROM books WHERE bookGenre = '漫画' ORDER BY title;",
				new BookInfoRowMapper());
		return getedComicList;
	}

	public List<BookInfo> getPictureBookList() {
		// セレクトボックスから得たい書籍情報を取得するようにSQLを修正（追加実装）
		List<BookInfo> getedPictureBookList = jdbcTemplate.query(
				"SELECT * FROM books WHERE bookGenre = '絵本' ORDER BY title;",
				new BookInfoRowMapper());
		return getedPictureBookList;
	}

	/*
	  * 読了のチェックをDBに登録（追加実装）
	  */
	 public void state_check(String value, int bookId) {
	     String sql = "UPDATE books SET status = ? WHERE books.id = ?;";
	     jdbcTemplate.update(sql, value, bookId);
	    }
	
}
