package group.zerry.front_server.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.annotation.AuthPass;
import group.zerry.front_server.service.FriendService;
import group.zerry.front_server.utils.CookiesData;

@Controller
@RequestMapping(value = "/friend")
public class FriendController {

	@Autowired
	FriendService friendService;

	@Autowired
	CookiesData cookiesData;

	// 缓存待做
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/favorites ", produces = "text/html;charset=UTF-8")
	public String showFavorites(HttpServletRequest request, HttpServletResponse response, String username,
			String userToken, int page) throws UnsupportedEncodingException {
		String returnMsg = friendService.showFavoritesNickname(username, userToken, page);
		return returnMsg;
	}

	// 缓存待做
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/followers ", produces = "text/html;charset=UTF-8")
	public String showFollowers(HttpServletRequest request, HttpServletResponse response, String username,
			String userToken, int page) throws UnsupportedEncodingException {
		String returnMsg = friendService.showFollowersNickname(username, userToken, page);
		return returnMsg;
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show/common_friends ", produces = "text/html;charset=UTF-8")
	public String showCommonFriendsByTargetUsername(HttpServletRequest request, HttpServletResponse response, String username,
			String userToken, String targetUsername) throws UnsupportedEncodingException {
		String returnMsg = friendService.showCommonFriendsByTargetUsername(username, userToken, targetUsername);
		return returnMsg;
		
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show/friends ", produces = "text/html;charset=UTF-8")
	public String showFriendsByGroupname(HttpServletRequest request, HttpServletResponse response, String username,
			String userToken, String groupname, int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, URLEncoder.encode(groupname, "UTF-8")))) {
				String returnMsg = friendService.showFriendsByGroupname(username, userToken, groupname);
				cookiesData.save(request, response, URLEncoder.encode(groupname, "UTF-8"),
						URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = friendService.showFriendsByGroupname(username, userToken, groupname);
			cookiesData.save(request, response, URLEncoder.encode(groupname, "UTF-8"),
					URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show/groups ", produces = "text/html;charset=UTF-8")
	public String showGroupsByUsername(HttpServletRequest request, HttpServletResponse response, String username,
			String userToken, int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "group"))) {
				String returnMsg = friendService.showGroupsByUsername(username, userToken);
				cookiesData.save(request, response, "group", URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = friendService.showGroupsByUsername(username, userToken);
			cookiesData.save(request, response, "group", URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}

	/**
	 * @return 1: 双方是朋友 0: 双方不是朋友
	 */
	@ResponseBody
	@RequestMapping(value = "/iffriends", produces = "text/html;charset=UTF-8")
	public String judgeIfFriendsOrNot(HttpServletRequest request, HttpServletResponse response, String username,
			String targetUsername, int flag) throws UnsupportedEncodingException {
		String cookieName = "ifFriend_" + targetUsername;
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, URLEncoder.encode(cookieName, "UTF-8")))) {
				boolean returnMsg = friendService.judgeIfFriendsOrNot(username, targetUsername);
				if (returnMsg == true) {
					cookiesData.save(request, response, URLEncoder.encode(cookieName, "UTF-8"), "1");
					return "1";
				} else {
					cookiesData.save(request, response, URLEncoder.encode(cookieName, "UTF-8"), "0");
					return "0";
				}
			} else {
				String returnMsg = cookie.getValue();
				return returnMsg;
			}
		} // 无更新查询
		else {
			boolean returnMsg = friendService.judgeIfFriendsOrNot(username, targetUsername);
			if (returnMsg == true) {
				cookiesData.save(request, response, URLEncoder.encode(cookieName, "UTF-8"), "1");
				return "1";
			} else {
				cookiesData.save(request, response, URLEncoder.encode(cookieName, "UTF-8"), "0");
				return "0";
			}
		}
	}
}