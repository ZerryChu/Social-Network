package group.zerry.front_server.enumtypes;

import java.util.HashMap;
import java.util.Map;

public enum UserStatusEnum {
	RS("REG_SUCCEED", "注册成功"),
	UE("USERNAME_EXISTS", "用户名存在"),
	LS("LOGIN_SUCCEED", "登陆成功"),
	PI("PASSWORD_INCORRECT", "密码错误"),
	UNV("USER_DOES_NOT_VALID", "用户无效"),
	FNF("FRIEND_NOT_FOUND", "无好友"),
	AUF("ADD_USER_FAIL", "注册失败"),
	ANE("AUTHORITY_NOT_ENOUGH", "权限不够"),
	UNE("USERNAME_OR_FRIEND_NOT_EXIST", "用户不存在"),
	PNV("PARAM_NOT_VALID", "参数无效"),
	AFE("ADD_FRIEND_ERROR", "添加关注失败"),
	DFE("DELETE_FRIEND_ERROR", "取消关注失败"),
	AFS("ADD_FRIEND_SUCCEED", "添加关注成功"),
	DFS("DELETE_FRIEND_SUCCEED", "取消关注成功"),
	LOS("LOGOUT_SUCCEED", "下线成功"),
	LOF("LOGOUT_FAIL", "下线失败");
	
	private static Map<String, UserStatusEnum> valueMap = new HashMap<String, UserStatusEnum>();

	private String value;
	private String displayName;

	static {
		for (UserStatusEnum item : UserStatusEnum.values()) {
			valueMap.put(item.value, item);
		}
	}

	private UserStatusEnum(String value, String displayName) {
		this.value = value;
		this.displayName = displayName;
	}

	public static UserStatusEnum parse(String value) {
		return valueMap.get(value);
	}

	public String getValue() {
		return value;
	}

	public String getDisplayName() {
		return displayName;
	}
}
