package group.zerry.api_server.controllers;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.annotation.AuthPass;
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
    
	private static Jedis                   jedis = new Jedis("localhost", 6379);

	private static SimplePropertyPreFilter userFilter   = new SimplePropertyPreFilter(User.class, "nickname",
            "age", "type", "habit");
	
    private static Logger                  logger = Logger.getLogger(UserController.class);

    
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String login(HttpServletRequest request, String username, String password) {
        StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
        UserStatusEnum status = userService.login(username, password);
        regMsg.append(status.getValue());
        regMsg.append("\"}");
        logger.info(regMsg.toString());
        if(status == UserStatusEnum.LS) {
        	UUID uuid = UUID.randomUUID();
        	jedis.set(username, uuid.toString());
        	request.getSession().setAttribute(username, uuid.toString());
        	logger.info(request.getSession().getAttribute("zerry"));
        	//is nickname need to send? name = nickname
        }
        return regMsg.toString();
        //usertoken
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/addfriend", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String addFriend(HttpServletRequest request, String username, String friendUsername, String group) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		regMsg.append(userService.addFriend(username, friendUsername, group));
		regMsg.append("\"}");
		logger.info(regMsg.toString());
		return regMsg.toString();
	}
	
	/*
	 * type: 1 普通用户 2 管理员
	 * 
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
	
	
	//check 是否能越权限访问
	//{"returnmsg":"{"age":20,"habit":"旅游、打各种球、编程","nickname":"zerrychu","type":2}"}
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/getinfo", produces = "text/html;charset=UTF-8")
	public String ShowUserInfo(String username) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		User user;
		if(null == (user = userService.showUserInfo(username))) {
			regMsg.append(UserStatusEnum.UNV.getValue());
		}
		else {
			regMsg.append(JSON.toJSONString(user, userFilter));
		}
		regMsg.append("\"}");
        logger.info(regMsg.toString());
		return regMsg.toString();
	}
	
}
