package group.zerry.front_server.enumtypes;

import java.util.HashMap;
import java.util.Map;

public enum CommentStatusEnum {

	CNF("COMMENT_NOT_FOUND", "帖子不存在"),
	OS("OPERATION_SUCCEED", "操作成功"),
	OF("OPERATION_FAIL", "操作失败"),
	DCF("DELETE_COMMENT_FAIL", "评论删除失败"),
	UAF("USER_AUTHENTICATE_FAIL", "用户验证失败"),
	ATCS("ADD_TOPIC_COMMENT_SUCCEED", "话题讨论添加成功");
	
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
