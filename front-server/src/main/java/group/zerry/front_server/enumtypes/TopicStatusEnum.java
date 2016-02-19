package group.zerry.front_server.enumtypes;

import java.util.HashMap;
import java.util.Map;

public enum TopicStatusEnum {
	TNE("TOPIC_NOT_EXIST", "话题不存在");
	
	private static Map<String, TopicStatusEnum> valueMap = new HashMap<String, TopicStatusEnum>();

	private String value;
	private String displayName;

	static {
		for (TopicStatusEnum item : TopicStatusEnum.values()) {
			valueMap.put(item.value, item);
		}
	}

	private TopicStatusEnum(String value, String displayName) {
		this.value = value;
		this.displayName = displayName;
	}

	public static TopicStatusEnum parse(String value) {
		return valueMap.get(value);
	}

	public String getValue() {
		return value;
	}

	public String getDisplayName() {
		return displayName;
	}
}
