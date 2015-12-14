package group.zerry.api_server.controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.annotation.AuthPass;
import group.zerry.api_server.entity.Friend;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.Target;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.FriendStatusEnum;
import group.zerry.api_server.service.FriendService;

@Controller
@RequestMapping("/friend")
public class FriendController {
	
	@Autowired
	FriendService  friendService;
	
	private Logger logger = Logger.getLogger(FriendController.class);

	private static SimplePropertyPreFilter friendFilter = new SimplePropertyPreFilter(Friend.class, "nickname", "username");
	
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
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show/common_friends ", produces = "text/html;charset=UTF-8")
	public String showCommonFriendsByTargetUsername(String username, String userToken, String targetUsername) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		Target[] friends = friendService.showCommonFriendsByTargetUsername(username, targetUsername);
		if (null == friends) {
			regMsg.append(FriendStatusEnum.NFE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(friends, friendFilter));
		regMsg.append("}");
		return regMsg.toString();
	}
	
	/**
	 * 待分页
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show/friends", produces = "text/html;charset=UTF-8")
	public String showFriendsByGroupname(String username, String userToken, String groupname) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		User[] friends = friendService.showFriendsByGroupname(username, groupname);
		if (null == friends) {
			regMsg.append(FriendStatusEnum.NFE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(friends));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	/**
	 * @content 获取关注的用户昵称
	 * 分页      15个一页
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/favorites", produces = "text/html;charset=UTF-8")
	public String showFavorites(String username, String userToken, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		Target[] favorites = friendService.showFavorites(username, page);
		if (null == favorites) {
			regMsg.append(FriendStatusEnum.NFE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(favorites));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	/**
	 * @content 获取粉丝的昵称
	 * 分页      15个一页
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/followers", produces = "text/html;charset=UTF-8")
	public String showFollowers(String username, String userToken, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		Target[] followers = friendService.showFollowers(username, page);
		if (null == followers) {
			regMsg.append(FriendStatusEnum.NFE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(followers));
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
	
	/**
	 * @content 判断两者是否好友关系
	 */
	@ResponseBody
	@RequestMapping(value = "/iffriends", produces = "text/html;charset=UTF-8")
	public String judgeIfFriendsOrNot(String username, String targetUsername) {
		if(true == friendService.judgeIfFriendsOrNot(username, targetUsername)) {
			return "{returnmsg: 1}";
		} else {
			return "{returnmsg: 0}";
		}
	}
	
}
