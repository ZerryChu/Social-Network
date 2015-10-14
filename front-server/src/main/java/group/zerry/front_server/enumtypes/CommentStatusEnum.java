package group.zerry.front_server.enumtypes;

import java.util.HashMap;
import java.util.Map;

public enum CommentStatusEnum {

	CNF("COMMENT_NOT_FOUND", "帖子不存在"),
	OS("OPERATION_SUCCEED", "操作成功");
	
	private static Map<String, CommentStatusEnum> valueMap = new HashMap<String, CommentStatusEnum>();

	private String value;
	private String displayName;

	static {
		for (CommentStatusEnum item : CommentStatusEnum.values()) {
			valueMap.put(item.value, item);
		}
	}

	private CommentStatusEnum(String value, String displayName) {
		this.value = value;
		this.displayName = displayName;
	}

	public static CommentStatusEnum parse(String value) {
		return valueMap.get(value);
	}

	public String getValue() {
		return value;
	}

	public String getDisplayName() {
		return displayName;
	}
}
