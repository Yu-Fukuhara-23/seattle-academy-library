package jp.co.seattle.library.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.seattle.library.dto.BookInfo;
import jp.co.seattle.library.service.BooksService;

/**
 * Handles requests for the application home page.
 */
@Controller // APIの入り口
public class HomeController {
	final static Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private BooksService booksService;

	/**
	 * Homeボタンからホーム画面に戻るページ
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String transitionHome(Model model) {
		//書籍の一覧情報を取得（タスク３）
		List<BookInfo> bookList = booksService.getBookList();
		model.addAttribute("bookList", bookList);
		return "home";
	}

	@RequestMapping(value = "/sortOrders", method = RequestMethod.GET)
	public String sort(Model model, @RequestParam(name = "sortOrder") String sort) {
		//並べ替え機能（追加実装）
		if (sort.equals("sortASC")) {
			List<BookInfo> books = booksService.sortGetBookListAsc();
			model.addAttribute("bookList", books);
		} else if (sort.equals("sortDESC")) {
			List<BookInfo> books = booksService.sortGetBookListDesc();
			model.addAttribute("bookList", books);
		} else if(sort.equals("sortPlASC")) {
			List<BookInfo> books = booksService.sortBookListPlDateAsc();
			model.addAttribute("bookList", books);
		}else if(sort.equals("sortPlDESC")) {
			List<BookInfo> books = booksService.sortBookListPlDateDesc();
			model.addAttribute("bookList", books);
		}
		return "home";
	}

	@RequestMapping(value = "/loginBookShelf", method = RequestMethod.GET)
	public String first(Model model) {
		//本棚のログイン画面
		return "shelfLogin";
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String searchBook(@RequestParam("searchWord") String title, Model model) {
		//検索窓（追加実装）
		List<BookInfo> books = booksService.getSearchList(title);
		model.addAttribute("bookList", books);
		return "home";
	}

	@RequestMapping(value = "/favorited", method = RequestMethod.GET)
	public String favoriteBox(@RequestParam("bookId") int bookId, Model model) {
		//お気に入り機能（追加実装）
		booksService.favoriteList(bookId);
		return "redirect:/home";
	}

	@RequestMapping(value = "/unliked", method = RequestMethod.GET)
	public String notfavorite(@RequestParam("bookId") int bookId, Model model) {
		//unlikeにする機能（追加実装）
		booksService.notFavoriteList(bookId);
		return "redirect:/home";
	}

	@RequestMapping(value = "/class", method = RequestMethod.GET)
	public String classBook(@RequestParam("") String bookGenre, Model model) {
		//ジャンル分け（追加実装）
		//ジャンルに当てはまる書籍の一覧情報を取得
		if (bookGenre.equals("小説")) {
			List<BookInfo> books = booksService.getNovelList();
			model.addAttribute("bookList", books);
		} else if (bookGenre.equals("漫画")) {
			List<BookInfo> books = booksService.getComicList();
			model.addAttribute("bookList", books);
		} else if (bookGenre.equals("絵本")) {
			List<BookInfo> books = booksService.getPictureBookList();
			model.addAttribute("bookList", books);
		}
		return "home";
	}

	//パスワード付き本棚（追加実装）
	@RequestMapping(value = "/addShelf", method = RequestMethod.POST)
	 public String addShelfBook(@RequestParam("bookId") int[] arr, Model model) {
	  
	  for(int i=0;i<arr.length;i++) {
	   int id = arr[i];
	   booksService.getRegistShelfBook(id);
	  }
	  return "redirect:/home";
	 }
	
	//読了チェック（追加実装）
	@RequestMapping(value = "/readStatus", method = RequestMethod.POST)
	   public String statusRead(@RequestParam("value") String value, @RequestParam("bookId") int bookId, Model model) {
	   booksService.state_check(value ,bookId);
	   return "redirect:/home";
	   }
	
	
	
}
