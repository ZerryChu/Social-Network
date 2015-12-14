package group.zerry.api_server.enumtypes;

import java.util.HashMap;
import java.util.Map;

public enum PrivateMsgStatusEnum {
	AMS("ADD_MESSAGE_SUCCEED", "发私信成功"),
	AMF("ADD_MESSAGE_FAIL", "发私信失败"),
	RMS("READ_MESSAGE_SUCCEED", "读私信成功"),
	RMF("READ_MESSAGE_FAIL", "读私信失败");
	
	private static Map<String, PrivateMsgStatusEnum> valueMap = new HashMap<String, PrivateMsgStatusEnum>();

	private String value;
	private String displayName;

	static {
		for (PrivateMsgStatusEnum item : PrivateMsgStatusEnum.values()) {
			valueMap.put(item.value, item);
		}
	}

	private PrivateMsgStatusEnum(String value, String displayName) {
		this.value = value;
		this.displayName = displayName;
	}

	public static PrivateMsgStatusEnum parse(String value) {
		return valueMap.get(value);
	}

	public String getValue() {
		return value;
	}

	public String getDisplayName() {
		return displayName;
	}
}
