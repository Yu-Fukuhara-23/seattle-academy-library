package jp.co.seattle.library.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.seattle.library.dto.UserInfo;
import jp.co.seattle.library.service.UsersService;

@Controller
public class PasswordResetController {
	final static Logger logger = LoggerFactory.getLogger(PasswordResetController.class);

	@Autowired
	private UsersService usersService;

	@RequestMapping(value = "/PasswordReset", method = RequestMethod.POST)
	public String first(Model model) {
		return "passwordReset";
	}

	@RequestMapping(value = "/PassWordReset", method = RequestMethod.POST)
	public String passwordReset(@RequestParam("email") String email, @RequestParam("password") String password, Model model) {
		if (password.length() >= 8 && password.matches("^[A-Za-z0-9]+$")) {
			if (password.equals(passwordForCheck)) {
				UserInfo userInfo = new UserInfo();
				userInfo.setEmail(email);
				userInfo.setPassword(password);
				usersService.registUser(userInfo);
				return "redirect:/";
			} else {
				model.addAttribute("errorMessage", "パスワードと確認用パスワードが一致しません。");
				return "PasswordReset";
			}
		} else {
			model.addAttribute("errorMessage", "パスワードは８桁以上の半角英数字で設定してください。");
			return "PasswordReset";
		}
		//usersテーブルのパスワードを更新
		booksService.PasswordReset(password);
		
	}
}