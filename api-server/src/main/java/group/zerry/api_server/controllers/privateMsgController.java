package group.zerry.api_server.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import group.zerry.api_server.annotation.AuthPass;
import group.zerry.api_server.entity.PrivateMsgInfo;
import group.zerry.api_server.service.PrivateMsgService;

@Controller
@RequestMapping(value = "/privateMsg")
public class privateMsgController {
	
	@Autowired
	PrivateMsgService privateMsgService;
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/getInfo", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showPrivateMessagesInfo(String username, String userToken) {
		List<PrivateMsgInfo> privateMsgInfoList = privateMsgService.getALLPrivateMsgList(username);
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		regMsg.append(JSON.toJSONString(privateMsgInfoList));
		regMsg.append("}");
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/getMessage", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showMessage(String username, String userToken, int id) {
		return null;
	}
}
