package group.zerry.api_server.enumtypes;

import java.util.HashMap;
import java.util.Map;

public enum FriendStatusEnum {
	NFE("NO_FRIEND_EXISTS", "朋友不存在"),
	NGE("NO_GROUP_EXISTS", "分组不存在");
	
	private static Map<String, FriendStatusEnum> valueMap = new HashMap<String, FriendStatusEnum>();

	private String value;
	private String displayName;

	static {
		for (FriendStatusEnum item : FriendStatusEnum.values()) {
			valueMap.put(item.value, item);
		}
	}

	private FriendStatusEnum(String value, String displayName) {
		this.value = value;
		this.displayName = displayName;
	}

	public static FriendStatusEnum parse(String value) {
		return valueMap.get(value);
	}

	public String getValue() {
		return value;
	}

	public String getDisplayName() {
		return displayName;
	}
}

