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

import group.zerry.front_server.annotation.AuthPass;
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
		String cookieName = "commentsFromMessage" + id;
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, cookieName))) {
				String returnMsg = commentService.show_comments(id, page);
				cookiesData.save(request, response, cookieName, returnMsg);
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = commentService.show_comments(id, page);
			// cookiesData.save(request, response, cookieName, returnMsg); 若不使用缓存，不需要设置
			return returnMsg;
		}
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String delete_comment(String username, String userToken, String nickname, int message_id, int id) {
		if(true == commentService.delete_comment(username, userToken, nickname, message_id, id)) {
			return "{\"msg\" : 1}";
		} else {
			return "{\"msg\" : 0}";
		}
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/add_topicComment", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String addTopicComment(String username, String userToken, String comment, int topic_id) {
		if (true == commentService.insertCommentByTopicId(username, userToken, comment, topic_id))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}
}
