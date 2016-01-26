package group.zerry.api_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import group.zerry.api_server.entity.Label;
import group.zerry.api_server.service.LabelService;

@Controller
@RequestMapping(value = "/label")
public class LabelController {
	
	@Autowired
	LabelService labelService;
	
	@ResponseBody
	@RequestMapping(value = "/show", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showHeatedLabel() {
		Label[] labels = labelService.showHeatedLabel();
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		regMsg.append(JSON.toJSONString(labels));
		regMsg.append("}");
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_rec", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showRecommendedLabels(String username) {
		Label[] labels = labelService.showRecommendedLabels(username);
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		regMsg.append(JSON.toJSONString(labels));
		regMsg.append("}");
		return regMsg.toString();
	}
}
