package group.zerry.front_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.service.LabelService;

@Controller
@RequestMapping(value = "/label")
public class LabelController {
	@Autowired
	private LabelService labelService;
	
	@ResponseBody
	@RequestMapping(value = "/show", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showHeatedLabel() {
		return labelService.showHeatedLabel();
	}

	@ResponseBody
	@RequestMapping(value = "/show_rec", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showRecommendedLabels(String username) {
		return labelService.showRecommendedLabels(username);
	}
}
