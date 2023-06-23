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

@Controller // APIの入り口
public class FavoriteController {
	final static Logger logger = LoggerFactory.getLogger(FavoriteController.class);

	/**
	 * 
	 *
	 *
	 * @param model
	 * @return ホーム画面に遷移
	 */
			
	@Autowired
	private BooksService booksService;

	@RequestMapping(value = "/addFavorite", method = RequestMethod.GET) // value＝actionで指定したパラメータ
	// お気に入り画面が表示される
	public String addFav(Model model) {
		List<BookInfo> books = booksService.favoritePage();
		model.addAttribute("bookList", books);
		return "favorite";
	}
	
	@RequestMapping(value = "/favBook", method = RequestMethod.GET)
	//　お気に入りボタンが押された後、お気に入り画面にいく
	public String favList(@RequestParam("bookId") int bookId, Model model) {
		booksService.favoriteList(bookId);
		return "redirect:/addFavorite"; 
	}
	
	@RequestMapping(value = "/unlike", method = RequestMethod.GET)
	//　お気に入り解除ボタンが押された後、お気に入り画面にいく
	public String notfavList(@RequestParam("bookId") int bookId, Model model) {
		booksService.notFavoriteList(bookId);
		return "redirect:/addFavorite"; 
	}
	
	@RequestMapping(value = "/searchFav", method = RequestMethod.GET)
	public String searchFavBook(@RequestParam("searchWord") String search, Model model) {
		//お気にいりのみの検索窓
		List<BookInfo> books = booksService.getFavSearchList(search);
		
		if (books.isEmpty()) {
			model.addAttribute("resultMessage", "データが存在しません");
		} else {
			model.addAttribute("bookList", books);
		}
	
		return "favorite";
	}
	
	
	
	
	
	
	
}	