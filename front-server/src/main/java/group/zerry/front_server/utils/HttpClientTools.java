package group.zerry.front_server.utils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.SocketTimeoutException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * HttpClient封装工具
 * 
 * @author：刘志龙
 * @since：2014年11月29日 上午10:46:38
 * @version:1.0
 */
public class HttpClientTools implements FetchUrlTools {

    private final static Logger                       logger      = LoggerFactory.getLogger(HttpClientTools.class);

    public final static int                           TIMEOUT     = 900000;

    private static PoolingHttpClientConnectionManager connManager = null;
    private static CloseableHttpClient                httpClient  = null;

    public void init() {
        connManager = new PoolingHttpClientConnectionManager();
        httpClient = HttpClients.custom().setConnectionManager(connManager).build();
        connManager.setMaxTotal(200);
        connManager.setDefaultMaxPerRoute(50);
    }

    public String doGet(String url) {
        String responseString = null;
        HttpGet get = new HttpGet(url);
        try {
            RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(TIMEOUT).setConnectTimeout(TIMEOUT)
                    .setConnectionRequestTimeout(TIMEOUT).build();
            get.setConfig(requestConfig);
            CloseableHttpResponse response = httpClient.execute(get);
            try {
                HttpEntity entity = response.getEntity();
                try {
                    if (entity != null) {
                        responseString = EntityUtils.toString(entity, Consts.UTF_8);
                    }
                } finally {
                    if (entity != null) {
                        entity.getContent().close();
                    }
                }
            } catch (Exception e) {
                logger.error("get response error", e);
                return responseString;
            } finally {
                if (response != null) {
                    response.close();
                }
            }

        } catch (SocketTimeoutException e) {
            logger.error("http get SocketTimeoutException", e);
            return responseString;
        } catch (Exception e) {
            logger.error("http get Exception", e);
        } finally {
            get.releaseConnection();
        }
        return responseString;
    }

    public static String doPost(String url, String postContent) {

        HttpPost post = new HttpPost(url);
        try {
            RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(TIMEOUT).setConnectTimeout(TIMEOUT)
                    .setConnectionRequestTimeout(TIMEOUT).setExpectContinueEnabled(false).build();
            post.setConfig(requestConfig);

            post.setEntity(new StringEntity(postContent, Consts.UTF_8));

            CloseableHttpResponse response = httpClient.execute(post);
            try {
                int status = response.getStatusLine().getStatusCode();

                HttpEntity entity = response.getEntity();
                try {
                    if (entity != null) {
                        String result = EntityUtils.toString(entity, Consts.UTF_8);
                        if (status == HttpStatus.SC_OK) {
                            logger.debug("url :{} , response string:{}", url, result);
                            return result;
                        } else {
                            logger.error("status:{},url :{} ,response :{} ", status, url, result);
                            return "ERROR-" + status;
                        }
                    }
                } finally {
                    if (entity != null) {
                        entity.getContent().close();
                    }
                }

            } finally {
                if (response != null) {
                    response.close();
                }
            }
        } catch (UnsupportedEncodingException e) {
            logger.error("UnsupportedEncodingException,{}", e.getMessage());
        } catch (Exception e) {
            logger.error("Exception,{}", e.getMessage());
        } finally {
            post.releaseConnection();
        }
        return "";

    }

    public String doPost(String url, Map<String, String> params) {

        String responseContent = null;

        HttpPost httpPost = new HttpPost(url);
        try {
            RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(TIMEOUT).setConnectTimeout(TIMEOUT)
                    .setConnectionRequestTimeout(TIMEOUT).build();
            httpPost.setConfig(requestConfig);

            List<NameValuePair> formParams = new ArrayList<NameValuePair>();
            for (Map.Entry<String, String> entry : params.entrySet()) {
                formParams.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
            }
            httpPost.setEntity(new UrlEncodedFormEntity(formParams, Consts.UTF_8));

            CloseableHttpResponse response = httpClient.execute(httpPost);
            try {
                // 执行POST请求
                HttpEntity entity = response.getEntity(); // 获取响应实体
                try {
                    if (null != entity) {
                        responseContent = EntityUtils.toString(entity, Consts.UTF_8);
                    }
                } finally {
                    if (entity != null) {
                        entity.getContent().close();
                    }
                }
            } finally {
                if (response != null) {
                    response.close();
                }
            }
        } catch (ClientProtocolException e) {
            logger.error("ClientProtocolException", e);
        } catch (IOException e) {
            logger.error("IOException", e);
        } finally {
            httpPost.releaseConnection();
        }
        return responseContent;

    }

}
