package group.zerry.api_server.controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import group.zerry.api_server.annotation.AuthPass;
import group.zerry.api_server.enumtypes.FriendStatusEnum;
import group.zerry.api_server.service.FriendService;

@Controller
@RequestMapping("/friend")
public class FriendController {
	
	@Autowired
	FriendService friendService;
	
	private Logger logger = Logger.getLogger(FriendController.class);

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show/groups ", produces = "text/html;charset=UTF-8")
	public String showGroupsByUsername(String username, String userToken) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		String[] groupnames = friendService.showGroupsByUsername(username);
		if (null == groupnames) {
			regMsg.append(FriendStatusEnum.NGE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(groupnames));
		regMsg.append("}");
		return regMsg.toString();
	}
	
	//没采用分页
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show/friends", produces = "text/html;charset=UTF-8")
	public String showFriendsByGroupname(String username, String userToken, String groupname) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		String[] friendnames = friendService.showFriendsByGroupname(username, groupname);
		if (null == friendnames) {
			regMsg.append(FriendStatusEnum.NFE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(friendnames));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/ifchat", produces = "text/html;charset=UTF-8")
	public String ifAllowChat(String username, String userToken, String friendNickname) {
		//暂时无逻辑代码
		return "{returnmsg: 1}";
	}
}
