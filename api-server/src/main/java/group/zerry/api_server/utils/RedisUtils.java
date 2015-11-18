package group.zerry.api_server.utils;

import org.springframework.beans.factory.annotation.Value;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * @author：刘志龙
 * @since：2014年12月13日 下午4:56:34
 * @version:1.2
 */
public class RedisUtils implements CacheTools {
	@Value("#{configLoader['redis.maxidle']}")
	private int maxidle;
	@Value("#{configLoader['redis.ip']}")
	private String ip;
	@Value("#{configLoader['redis.port']}")
	private int port;
	@Value("#{configLoader['redis.timeout']}")
	private int timeout;
	@Value("#{configLoader['redis.password']}")
	private String password;

	private JedisPool pool;

	/**
	 * 初始化Jedis Pool
	*/
	public void init() {
		JedisPoolConfig config = new JedisPoolConfig();
		config.setMaxIdle(maxidle);
		config.setTestOnBorrow(true);
		config.setTestOnReturn(true);
		pool = new JedisPool(config, ip, port, timeout, password);
	}

	@Override
	public void remove(String key) {
		Jedis jedis = pool.getResource();
		try {
			jedis.del(key);
		} finally {
			pool.returnResource(jedis);
		}
	}

	@Override
	public String get(String key) {
		Jedis jedis = pool.getResource();
		try {
			return jedis.get(key);
		} finally {
			pool.returnResource(jedis);
		}
	}

	@Override
	public void put(String key, String value) {
		Jedis jedis = pool.getResource();
		try {
			jedis.set(key, value);
			jedis.expire(key, 30 * 60);
		} finally {
			pool.returnResource(jedis);
		}
	}

	@Override
	public void put(String key, String value, int sec) {
		Jedis jedis = pool.getResource();
		try {
			jedis.set(key, value);
			jedis.expire(key, sec);
		} finally {
			pool.returnResource(jedis);
		}
	}
	
	public int getMaxidle() {
		return maxidle;
	}

	public void setMaxidle(int maxidle) {
		this.maxidle = maxidle;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public int getTimeout() {
		return timeout;
	}

	public void setTimeout(int timeout) {
		this.timeout = timeout;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
