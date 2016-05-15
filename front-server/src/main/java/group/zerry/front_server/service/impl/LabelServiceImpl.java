package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.front_server.service.LabelService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value = "LabelService")
public class LabelServiceImpl implements LabelService {

	@Autowired
	HttpTarget httpTarget;
	
	@Autowired
	FetchUrlTools fetchURLTool;
	
	@Override
	public String showHeatedLabel() {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "label/show";
		Map<String, String> paramsMap = new HashMap<String, String>();
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public String showRecommendedLabels(String username) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "label/show_rec";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public String showSimilarLabel(int label_id) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
