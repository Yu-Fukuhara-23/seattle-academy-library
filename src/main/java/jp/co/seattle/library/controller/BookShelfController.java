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
public class BookShelfController {
 final static Logger logger = LoggerFactory.getLogger(BookShelfController.class);

 @Autowired
 private BooksService booksService;

 /**
  * Homeボタンからホーム画面に戻るページ
  * 
  * @param model
  * @return
  */
 
 /*
  * 本棚の書籍だけを取得
  */
 @RequestMapping(value = "/bookShelf", method = RequestMethod.GET)
 public String favBook(Model model) {
  List<BookInfo> getedShelfList = booksService.getShelfBook();
  
  if(getedShelfList.isEmpty()) {
   model.addAttribute("resultMessage", "データが存在しません");
  }else {
   model.addAttribute("bookList", getedShelfList);
  }
  return "bookShelf";
 }
 
 @RequestMapping(value = "/deleteShelf", method = RequestMethod.POST)
 public String addShelfBook(@RequestParam("bookId") int[] arr, Model model) {
  
  for(int i=0;i<arr.length;i++) {
   int id = arr[i];
   booksService.getDeleteShelfBook(id);
  }

  return "redirect:/bookShelf";
 }
 
// /*
//  * お気に入りボタンを押した際、本棚画面を表示し直す
//  */
// @RequestMapping(value = "/fav", method = RequestMethod.GET)
// public String favoriteView(@RequestParam("bookId") int bookId,Model model) {
//  booksService.getFavorite(bookId);
//  return "redirect:/favBook";
// }
// 
// /*
//  * お気に入り解除ボタンを押されたものを取得
//  */
// @RequestMapping(value = "/unfav", method = RequestMethod.GET)
// public String unlike(@RequestParam("bookId") int bookId, Model model) {
// booksService.deleteFavBook(bookId);
// return "redirect:/favBook";
// }
}