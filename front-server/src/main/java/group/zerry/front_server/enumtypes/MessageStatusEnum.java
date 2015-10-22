package group.zerry.front_server.enumtypes;

import java.util.HashMap;
import java.util.Map;


public enum MessageStatusEnum {
	DS("DELETE_SUCCESS", "删除成功"),
	NFM("NO_FOUND_MESSAGE", "没有发现相应帖子"),
	AMS("ADD_MESSAGE_SUCCEED", "发帖成功"),
	AMF("ADD_MESSAGE_FAIL", "发帖失败"),
	DMS("DELETE_MESSAGE_SUCCEED", "删帖成功"),
	DMF("DELETE_MESSAGE_FAIL", "删帖失败"),
	MNE("MESSAGE_DOES_NOT_EXIST", "消息不存在"),
	SMF("SHOW_MESSAGES_FAIL", "帖子展示失败"),
	ACF("AUTHORITY_CHECK_FAIL", "权限认证失败"),
	SS("ADD_SUPPORT_SUCCEED", "点赞成功"),
	RS("ADD_REPOST_SUCCEED", "转发成功"),
	CS("ADD_COMMENT_SUCCEED", "评论成功"),
	OF("OPERATION_FAIL", "操作失败");
	
	private static Map<String, MessageStatusEnum> valueMap = new HashMap<String, MessageStatusEnum>();

	private String value;
	private String displayName;

	static {
		for (MessageStatusEnum item : MessageStatusEnum.values()) {
			valueMap.put(item.value, item);
		}
	}

	private MessageStatusEnum(String value, String displayName) {
		this.value = value;
		this.displayName = displayName;
	}

	public static MessageStatusEnum parse(String value) {
		return valueMap.get(value);
	}

	public String getValue() {
		return value;
	}

	public String getDisplayName() {
		return displayName;
	}
}
