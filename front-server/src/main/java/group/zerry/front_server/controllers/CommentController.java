package group.zerry.front_server.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.service.CommentService;
import group.zerry.front_server.utils.CookiesData;


/**
 * @author ZerryChu
 * @since  2015 10 3
 *
 */
@Controller
@RequestMapping(value="/comment")
public class CommentController {
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	CookiesData    cookiesData;
	
	@ResponseBody
	@RequestMapping(value = "/show", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String show_comments(HttpServletRequest request, HttpServletResponse response, int id, int page, int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "comments"))) {
				String returnMsg = commentService.show_message(id, page);
				cookiesData.safe(request, response, "comments", returnMsg);
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = commentService.show_message(id, page);
			cookiesData.safe(request, response, "comments", returnMsg);
			return returnMsg;
		}
	}
}
