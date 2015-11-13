package group.zerry.front_server.utils;

import java.util.Map;

/**
 * 类HttpClientTools.java的实现描述：HttpClient工具类
 * 
 * @author 正纬 2015年3月25日 下午1:52:24
 */
public interface FetchUrlTools {

    /**
     * get请求
     * 
     * @param url
     * @return
     */
    public String doGet(String url);

    /**
     * post请求
     * 
     * @param url
     * @param requestParametersMap
     * @return
     */
    public String doPost(String url, Map<String, String> requestParametersMap);
}
