package group.zerry.api_server.controllers;

import org.apache.commons.httpclient.NTCredentials;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.annotation.AuthPass;
import group.zerry.api_server.entity.Friend;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.enumtypes.UserStatusEnum;
import group.zerry.api_server.service.UserService;
import group.zerry.api_server.utils.CacheTools;
import redis.clients.jedis.Jedis;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	UserService                            userService;
	
	@Autowired
	CacheTools                             cacheTools;
    
	//private static Jedis                   jedis = new Jedis("localhost", 6379);

	private static SimplePropertyPreFilter userFilter   = new SimplePropertyPreFilter(User.class, "username", "nickname",
            "age", "type", "habit", "focus_num", "friend_num", "message_num", "friend");
		
    private static Logger                  logger = Logger.getLogger(UserController.class);

    
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String login(String username, String password, String userToken) {
        StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
        if(null != userToken) {
        	UserStatusEnum status = userService.login(username, password);
        	regMsg.append(status.getValue());
        	regMsg.append("\"}");
        	logger.info(regMsg.toString());
            if(status == UserStatusEnum.LS) {
            	cacheTools.put(username, userToken);
            	//jedis.set(username, uuid.toString());
            	//request.getSession().setAttribute(username, uuid.toString());
            }
            return regMsg.toString();
        }
        else {
        	regMsg.append(UserStatusEnum.ANE.getValue());
        	regMsg.append("\"}");
        	return regMsg.toString();
        }
	}
	
	/**
	 * 关注
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/addfriend", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String addFriend(String username, String userToken, String friendUsername, String group) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		regMsg.append(userService.addFriend(username, friendUsername, group).getValue());
		regMsg.append("\"}");
		logger.info(regMsg.toString());
		return regMsg.toString();
	}
	
	/**
	 * 取消关注
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/deletefriend", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String deleteFriend(String username, String userToken, String friendUsername) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		regMsg.append(userService.deleteFriend(username, friendUsername).getValue());
		regMsg.append("\"}");
		logger.info(regMsg.toString());
		return regMsg.toString();
	}
	
	/*
	 * type: 1 普通用户 2 管理员
	 */
	@ResponseBody
	@RequestMapping(value = "/reg", produces = "text/html;charset=UTF-8")
	public String reg(User user) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
        regMsg.append(userService.Reg(user).getValue());
        regMsg.append("\"}");
        logger.info(regMsg.toString());
        return regMsg.toString();
	}
	
	
	//{"returnmsg": {"age":20,"habit":"旅游、打各种球、编程","nickname":"zerrychu","type":2}}
	@ResponseBody
	@RequestMapping(value = "/getinfo", produces = "text/html;charset=UTF-8")
	public String ShowUserInfo(String username) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		User user;
		if(null == (user = userService.showUserInfo(username))) {
			regMsg.append(UserStatusEnum.UNV.getValue());
		}
		else {
			regMsg.append(JSON.toJSONString(user, userFilter));
		}
		regMsg.append("}");
        logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/getinfoByNickname", produces = "text/html;charset=UTF-8")
	public String ShowUserInfoByNickname(String nickname) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		User user;
		if(null == (user = userService.showUserInfoByNickname(nickname))) {
			regMsg.append(UserStatusEnum.UNV.getValue());
		}
		else {
			regMsg.append(JSON.toJSONString(user, userFilter));
		}
		regMsg.append("}");
        logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/getTargetinfo", produces = "text/html;charset=UTF-8")
	public String ShowTargetInfoByNickname(String username, String nickname) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		User user;
		if(null == (user = userService.showTargetInfoByNickname(username, nickname))) {
			regMsg.append(UserStatusEnum.UNV.getValue());
		}
		else {
			regMsg.append(JSON.toJSONString(user, userFilter));
		}
		regMsg.append("}");
        logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_masters", produces = "text/html;charset=UTF-8")
	public String getMasters(int label_id, int num) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		User[] users;
		if(null == (users = userService.getMastersByLabelId(label_id, num))) {
			regMsg.append(UserStatusEnum.UNV.getValue());
		}
		else {
			regMsg.append(JSON.toJSONString(users, userFilter));
		}
		regMsg.append("}");
        logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/logout", produces = "text/html;charset=UTF-8")
	public String UserLogout(String username, String userToken) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		try {
			cacheTools.remove(username);
		} catch(Exception e) {
			regMsg.append(UserStatusEnum.LOF.getValue());
			regMsg.append("\"}");
			return regMsg.toString();
		}
		regMsg.append(UserStatusEnum.LOS.getValue());
		regMsg.append("\"}");
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_rec_users", produces = "text/html;charset=UTF-8")
	public String showRecommendedUsers(String username) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		User[] users;
		if(null == (users = userService.showRecommendedUsers(username))) {
			regMsg.append(UserStatusEnum.UNV.getValue());
		}
		else {
			regMsg.append(JSON.toJSONString(users, userFilter));
		}
		regMsg.append("}");
        logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	/*
	@ResponseBody
	@RequestMapping(value = "/showfriends", produces = "text/html;charset=UTF-8")
	public String showFriendsByNickname(String nickname) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":");
		Friend[] friends = null;
		if(null == (friends = userService.showFriendsByNickname(nickname))) {
			regMsg.append(UserStatusEnum.FNF.getValue());
		} else {
			regMsg.append(JSON.toJSONString(friends));
		}
		regMsg.append(UserStatusEnum.LOS.getValue());
		regMsg.append("}");
		return regMsg.toString();
	}
	*/
}
