package group.zerry.front_server.controllers;

import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.service.SearchService;
import group.zerry.front_server.utils.CookiesData;

@Controller
@RequestMapping(value = "/search")
public class SearchController {
	@Autowired
	SearchService searchService;

	@Autowired
	CookiesData cookiesData;

	@ResponseBody
	@RequestMapping(value = "/users", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String searchUsersLikeNickname(HttpServletRequest request, HttpServletResponse response, String nickname,
			int page) {
		saveTrace(request, response, nickname, 2);
		return searchService.searchUsersLikeNickname(nickname, page);
	}

	@ResponseBody
	@RequestMapping(value = "/messages", produces = "text/html;charset=UTF-8")
	public String searchMessagesLikeContent(HttpServletRequest request, HttpServletResponse response, String username, String content,
			int page) {
		saveTrace(request, response, content, 1);
		return searchService.searchMessagesLikeContent(username, content, page);
	}

	/**
	 * cookies保存搜索记录
	 * flag : 1 微博搜索记录  2 : 用户搜索记录
	 */
	public void saveTrace(HttpServletRequest request, HttpServletResponse response, String content, int flag) {
		if (content == null || content == "")
			return;
		Cookie cookie = null;
		if (flag == 1)
			cookie = cookiesData.getCookie(request, "history_msg");
		else 
			cookie = cookiesData.getCookie(request, "history_user");
		try {
			if (cookie == null) {
				String trace = content + ";";
				if (flag == 1)
					cookiesData.save(request, response, "history_msg", URLEncoder.encode(trace, "utf-8"));
				else
					cookiesData.save(request, response, "history_user", URLEncoder.encode(trace, "utf-8"));
			} else {
				String[] history = URLDecoder.decode(cookie.getValue(), "utf-8").split("\\;");
				int length = history.length;
				for(int i = 0;i < length; i++) {
					if(history[i].equals(content)) {
						for(i = i + 1;i < length; i++) {
							history[i-1] = history[i];
						}
						length--;
						break;
					}
				}
				if(length == 10) {
					for(int i = 1;i < 10; i++) {
						history[i-1] = history[i];
					}
				}
				String str = "";
				if (length == 10)
					length--;
				for(int i = 0;i < length; i++) {
					str += history[i];
					str += ";";
				}
				str += content;
				str += ";";
				if (flag == 1)
					cookiesData.save(request, response, "history_msg", URLEncoder.encode(str, "utf-8"));
				else
					cookiesData.save(request, response, "history_user", URLEncoder.encode(str, "utf-8"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}
