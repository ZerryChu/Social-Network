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

import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.UserStatusEnum;
import group.zerry.api_server.service.UserService;
import group.zerry.api_server.utils.CacheTools;
import redis.clients.jedis.Jedis;

@Controller(value="/user")
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
        }
        return regMsg.toString();
        //usertoken
	}
	
	/*
	 * type: 1 普通用户 2 管理员
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/reg", produces = "text/html;charset=UTF-8")
	public String reg(User user) {
		//密码加盐
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
        regMsg.append(userService.Reg(user).getValue());
        regMsg.append("\"}");
        logger.info(regMsg.toString());
        return regMsg.toString();
	}
	
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
