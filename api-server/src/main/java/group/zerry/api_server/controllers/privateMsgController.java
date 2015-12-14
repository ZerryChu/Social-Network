package group.zerry.api_server.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.annotation.AuthPass;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.PrivateMsg;
import group.zerry.api_server.entity.PrivateMsgInfo;
import group.zerry.api_server.enumtypes.PrivateMsgStatusEnum;
import group.zerry.api_server.service.PrivateMsgService;

@Controller
@RequestMapping(value = "/privateMsg")
public class privateMsgController {
	
	@Autowired
	PrivateMsgService privateMsgService;
	
	private static SimplePropertyPreFilter msgFilter = new SimplePropertyPreFilter(PrivateMsg.class, "time", "content", "is_target"); // 全部属性都需要
	
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
	@RequestMapping(value = "/getMsg", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showMessage(String username, String userToken, String targetUsername) {
		PrivateMsg[] msg = privateMsgService.getPrivateMsg(username, targetUsername);
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		regMsg.append(JSON.toJSONString(msg, msgFilter));
		regMsg.append("}");
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/addMsg", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String writeNewPrivateMessage(String username, String userToken, String targetUsername, String content) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\": ");
		PrivateMsgStatusEnum status = privateMsgService.addPrivateMessage(username, targetUsername, content);
		if(status.getValue().equals(PrivateMsgStatusEnum.AMS.getValue())) {
			regMsg.append("1 }");
		} else {
			regMsg.append("0 }");
		}
		// logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/readMsg", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String readPrivateMessage(String username, String userToken, String targetUsername) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\": ");
		PrivateMsgStatusEnum status = privateMsgService.readPrivateMsg(username, targetUsername);
		if(status.getValue().equals(PrivateMsgStatusEnum.RMS.getValue())) {
			regMsg.append("1 }");
		} else {
			regMsg.append("0 }");
		}
		// logger.error(regMsg.toString());
		return regMsg.toString();
	}
}
