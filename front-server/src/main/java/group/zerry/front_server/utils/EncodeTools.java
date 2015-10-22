package group.zerry.front_server.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 编码工具
 * @author：刘志龙
 * @since：2014年11月15日 下午9:44:44
 * @version:1.0
 */
public class EncodeTools {
	/**
	 * 加密工具，采用两次hash加盐，安全性那是相当的不错，呵呵呵
	 * @param str 待编码参数
	 * @param salt 盐
	 * @return
	*/
	public static String encoder(String str , String salt) {
		return salt + MD5(SHA1(str + salt) + salt);
	}
	
	/**
	 * 客官来点盐
	 * @return
	*/
	public static String giveMeSalt() {
		String salt = SHA1(Double.toString(Math.random())).substring(0, 4);
		return salt;
	}
	
	/**
	 * MD5加密
	 * 
	 * @param input
	 * @return
	 */
	public static String MD5(String input) {
		try {
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			mdInst.update(input.getBytes());
			byte[] md = mdInst.digest();
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < md.length; i++) {
				String shaHex = Integer.toHexString(md[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexString.append(0);
				}
				hexString.append(shaHex);
			}
			return hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * SHA1加密算法
	 * 
	 * @param decript
	 * @return
	 */
	public static String SHA1(String decript) {
		try {
			MessageDigest digest = java.security.MessageDigest
					.getInstance("SHA-1");
			digest.update(decript.getBytes());
			byte messageDigest[] = digest.digest();
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < messageDigest.length; i++) {
				String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexString.append(0);
				}
				hexString.append(shaHex);
			}
			return hexString.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}
}
