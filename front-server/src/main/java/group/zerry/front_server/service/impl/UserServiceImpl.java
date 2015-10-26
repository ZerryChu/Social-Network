package group.zerry.front_server.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import group.zerry.front_server.dto.ReturnMsgDto;
import group.zerry.front_server.entity.User;
import group.zerry.front_server.enumtypes.UserStatusEnum;
import group.zerry.front_server.service.UserService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value = "UserService")
public class UserServiceImpl implements UserService {
	@Autowired
	HttpTarget httpTarget;

	@Autowired
	FetchUrlTools fetchURLTool;

	private static Logger logger = Logger.getLogger(UserServiceImpl.class);

	public boolean login(String username, String password, String userToken) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/login";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("password", password);
		paramsMap.put("userToken", userToken);
		logger.error(fetchURLTool.doPost(url, paramsMap));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(UserStatusEnum.LS.getValue())) {
			return true;
		} else
			return false;
	}

	public boolean reg(User user) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/reg";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", user.getUsername());
		paramsMap.put("password", user.getPassword());
		paramsMap.put("nickname", user.getNickname());
		paramsMap.put("age", String.valueOf(user.getAge()));
		paramsMap.put("habit", user.getHabit());
		paramsMap.put("type", "1");
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(UserStatusEnum.RS.getValue())) {
			return true;
		} else
			return false;
	}

	public String showUserInfo(String username) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/getinfo";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		// User user = JSON.parseObject(fetchURLTool.doPost(url, paramsMap),
		// User.class);
		// return user;
		return fetchURLTool.doPost(url, paramsMap);
	}

	public boolean addFriend(String username, String userToken, String friendUsername, String group) {
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/addfriend";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("friendUsername", friendUsername);
		paramsMap.put("group", group);
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().equals(UserStatusEnum.AFS.getValue()))
			return true;
		else
			return false;
	}
	
	//文件存储路径
	private String path = "/Users/zhuzirui/Documents/workspace/front-server/src/main/webapp/pic/";
	
	/**
	 * 用户头像上传，只开放jpg，pic，png文件的接口
	 * 
	 */
	public boolean fileUpload(HttpServletRequest request, String username) {
		// TODO Auto-generated method stub
		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setHeaderEncoding("utf-8");
			if (!ServletFileUpload.isMultipartContent(request)) {
				// 按照传统方式获取数据
				return false;
			}
			List<FileItem> list = upload.parseRequest(request);
			for (FileItem item : list) { // 只有一个
				// 如果fileitem中封装的是普通输入项的数据
				if (item.isFormField()) {
					return false;
				} else {// 如果fileitem中封装的是上传文件
					String filename = item.getName();
					if (filename == null || filename.trim().equals("")) {
						return false;
					}
					String extendName = filename.substring(filename.lastIndexOf(".") + 1);
					if (!extendName.equals("jpg") && !extendName.equals("png") && !extendName.equals("pic")) {
						logger.error("invalid extendName");
						return false;
					}
					InputStream in = item.getInputStream();
					File file = new File(path + username + "." + extendName);
					file.createNewFile();
					FileOutputStream out = new FileOutputStream(path + username + "." + extendName);
					byte buffer[] = new byte[1024];
					// 判断输入流中的数据是否已经读完的标识
					int len = 0;
					// 循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
					while ((len = in.read(buffer)) > 0) {
						// 使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\"
						// + filename)当中
						out.write(buffer, 0, len);
					}
					// 关闭输入流
					in.close();
					// 关闭输出流
					out.close();
					// 删除处理文件上传时生成的临时文件
					item.delete();
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		}
		return true;
	}

	public String showTargetInfoByNickname(String nickname) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/getTargetinfo";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("nickname", nickname);
		return fetchURLTool.doPost(url, paramsMap);
	}

	public String showFriendsByNickname(String nickname) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/showfriends";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("nickname", nickname);
		// User user = JSON.parseObject(fetchURLTool.doPost(url, paramsMap),
		// User.class);
		// return user;
		return fetchURLTool.doPost(url, paramsMap);
	}

	public boolean logout(String username, String userToken) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/logout";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if(returnMsgDto.getReturnMsg().equals(UserStatusEnum.LOS.getValue())) {
			return true;
		}
		else {
			logger.error(returnMsgDto.getReturnMsg());
			return false;
		}
	}

}
