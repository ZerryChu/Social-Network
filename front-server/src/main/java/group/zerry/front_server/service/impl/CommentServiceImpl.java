package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.front_server.service.CommentService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value="CommentService")
public class CommentServiceImpl implements CommentService{

	@Autowired
	HttpTarget httpTarget;
	
	@Autowired
	FetchUrlTools fetchUrlTool;
	
	public String show_message(int id, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "comment/show";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("id", String.valueOf(id));
		paramsMap.put("page", String.valueOf(page));
		return fetchUrlTool.doPost(url, paramsMap);
	}
	
	//评论点赞
	//删除评论
}
