package group.zerry.front_server.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.utils.CookiesData;
import group.zerry.front_server.utils.EncodeTools;
import group.zerry.front_server.annotation.AuthPass;
import group.zerry.front_server.entity.User;
import group.zerry.front_server.service.UserService;
import group.zerry.front_server.service.impl.UserServiceImpl;

@Controller
@RequestMapping(value="/user")
public class UserController {
		
	@Autowired
	UserService userService;
	
	@Autowired
	CookiesData cookiesData;
	
	private static Logger logger = Logger.getLogger(UserController.class);
	
	@ResponseBody
	@RequestMapping(value = "/login", produces = "text/html;charset=UTF-8")
	public String login(HttpServletRequest request, HttpServletResponse response, String username, String password, String checknum) {
		/*  验证验证码
		  	String num = (String) request.getSession().getAttribute("getNum");
			if(!num.equals(checknum)) {
				return "{\"msg\" : -1}";
			}
		*/
		UUID uuid = UUID.randomUUID();
		// 解密
		//username = EncodeTools.encoder(username, username.substring(0, 4));
		//password = EncodeTools.encoder(password, password.substring(0, 4));		
		logger.error(uuid.toString());
		if(userService.login(username, password, uuid.toString())) {
			//返回userToken
			return "{\"msg\" : \"" + uuid.toString() + "\"}";
		}
		else
			return "{\"msg\" : \"0\"}";
	}
	
	@ResponseBody
	@RequestMapping(value = "/login1", produces = "text/html;charset=UTF-8")
	public String login1(HttpServletRequest request, HttpServletResponse response, String username, String password, String checknum) {
		String num = (String) request.getSession().getAttribute("getNum");
		if(!num.equals(checknum)) {
			return "{\"msg\" : \"-1\"}";
		}
		UUID uuid = UUID.randomUUID();
		logger.error(uuid.toString());
		if(userService.login(username, password, uuid.toString())) {
			// 加密
			//username = EncodeTools.encoder(username, EncodeTools.giveMeSalt());
			//password = EncodeTools.encoder(password, EncodeTools.giveMeSalt());
			/* cookies
			Cookie cookie = new Cookie("username", username);
			cookie.setMaxAge(1200); // 20min
			cookie.setPath("/");
			response.addCookie(cookie);
			cookie = new Cookie("password", password);
			cookie.setPath("/");
			cookie.setMaxAge(1200); // 20min
			response.addCookie(cookie);
			request.getSession().setAttribute(username, uuid.toString());
			*/
			
			//返回userToken
			return "{\"msg\" : \"" + uuid.toString() + "\"}";
		}
		else
			return "{\"msg\" : \"0\"}";
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/logout", produces = "text/html;charset=UTF-8")
	public String logout(HttpServletRequest request, HttpServletResponse response, String username, String userToken) {
		if (userService.logout(username, userToken))
			logger.error("delete userToken error...");
		// cookie
		cookiesData.deleteAllCookies(request, response);
		return "{\"msg\" : 1}";
	}
	
	/**
	 * 
	 * @return 1 :登陆成功 0 :用户名已存在 -1:注册失败
	 */
	@ResponseBody
	@RequestMapping(value="/reg", produces = "text/html;charset=UTF-8")
	public String reg(User user) {
		return "{\"msg\" : " + userService.reg(user) + "}";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getinfo", produces = "text/html;charset=UTF-8")
	public String showUserInfo(HttpServletRequest request, HttpServletResponse response, String username, int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "userinfo"))) {
				String returnMsg = userService.showUserInfo(username);
				cookiesData.save(request, response, "userinfo", URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = userService.showUserInfo(username);
			cookiesData.save(request, response, "userinfo", URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/getinfoByNickname", produces = "text/html;charset=UTF-8")
	public String showUserInfoByNickname(HttpServletRequest request, HttpServletResponse response, String nickname, int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "userinfo"))) {
				String returnMsg = userService.showUserInfoByNickname(nickname);
				cookiesData.save(request, response, "userinfo", URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = userService.showUserInfoByNickname(nickname);
			//cookiesData.save(request, response, "userinfo", URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}
	
	
	/*
	@ResponseBody
	@RequestMapping(value = "/showfriends", produces = "text/html;charset=UTF-8")
	public String showFriendsByNickname(String nickname) {
		return userService.showFriendsByNickname(nickname);
	}
	*/
	
	//显示目标用户的信息
	/**
	 * 注意nickname与username一一对应
	 * @param username
	 * @param nickname (targetNickname)
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/getTargetinfo", produces = "text/html;charset=UTF-8")
	public String showTargetInfoByNickname(String username, String nickname) throws UnsupportedEncodingException {
		//Cookie cookie;
		//nickname = URLEncoder.encode(nickname, "UTF-8");
		//if (null == (cookie = cookiesData.getCookie(request, nickname))) {
			String returnMsg = userService.showTargetInfoByNickname(username, nickname);
			//logger.error("getTargetInfo: " + returnMsg);
			//cookiesData.save(request, response, nickname, returnMsg);
			return returnMsg;
		//} else {
			//String returnMsg = cookie.getValue();
			//returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
			//return returnMsg;
		//}
	}
	
	/**
	 * 关注
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/addfriend", produces = "text/html;charset=UTF-8")
	public String addFriend(String username, String userToken, String friendUsername, String group) {
		if(userService.addFriend(username, userToken, friendUsername, group))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}
	
	/**
	 * 取消关注
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/deletefriend", produces = "text/html;charset=UTF-8")
	public String deleteFriend(String username, String userToken, String friendUsername) {
		if(userService.deleteFriend(username, userToken, friendUsername))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/insert_icon", produces = "text/html;charset=UTF-8")
	public String insertIcon(HttpServletRequest request, String username, String usertoken) {
		if(userService.fileUpload(request, username)) {
			return "{\"msg\" : 1}";
		}
		else {
			return "{\"msg\" : 0}";	
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_rec_users", produces = "text/html;charset=UTF-8")
	public String showRecommendedUsers(String username) {
		return userService.showRecommendedUsers(username);
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_masters", produces = "text/html;charset=UTF-8")
	public String getMasters(int label_id, int num) {
		return userService.getMastersByLabelId(label_id, num);
	}
}
