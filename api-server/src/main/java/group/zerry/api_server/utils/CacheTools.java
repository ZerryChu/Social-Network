package group.zerry.api_server.utils;


/**
 * 缓存工具接口
 * @author：刘志龙
 * @since：2015年1月23日 下午3:42:16
 * @version:1.0
 */
public interface CacheTools {
	/**
	 * 删除缓存中的某个数据
	 * 
	 * @param key
	 */
	public void remove(String key);

	/**
	 * 获取缓存中数据
	 * 
	 * @param key
	 */
	public String get(String key);

	/**
	 * 存储键值对到缓存
	 * 默认情况下20min超时
	 * @param key
	 * @param value
	 */
	public void put(String key, String value);
	
	/**
	 * 存储键值对到缓存，并设置超时时间
	 * @param key
	 * @param value
	 * @param sec 超时时间 单位：秒
	*/
	public void put(String key, String value, int sec);
}
