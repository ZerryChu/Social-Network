package group.zerry.front_server.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.service.FriendService;
import group.zerry.front_server.utils.CookiesData;

@Controller
@RequestMapping(value = "/friend")
public class FriendController {
	
	@Autowired
	FriendService friendService;
	
	@Autowired
	CookiesData   cookiesData;
	
	@ResponseBody
	@RequestMapping(value = "/show/friends ", produces = "text/html;charset=UTF-8")
	public String showFriendsByGroupname(HttpServletRequest request, HttpServletResponse response, String username, String groupname, int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, groupname))) {
				String returnMsg = friendService.showFriendsByGroupname(username, groupname);
				cookiesData.safe(request, response, groupname, returnMsg);
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = friendService.showFriendsByGroupname(username, groupname);
			cookiesData.safe(request, response, groupname, returnMsg);
			return returnMsg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/show/groups ", produces = "text/html;charset=UTF-8")
	public String showGroupsByUsername(HttpServletRequest request, HttpServletResponse response, String username, int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "group"))) {
				String returnMsg = friendService.showGroupsByUsername(username);
				cookiesData.safe(request, response, "group", returnMsg);
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = friendService.showGroupsByUsername(username);
			cookiesData.safe(request, response, "group", returnMsg);
			return returnMsg;
		}
	}
	
}
