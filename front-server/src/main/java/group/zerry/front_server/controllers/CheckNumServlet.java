package group.zerry.front_server.controllers;


import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * @author zerrychu
 * @content 生成验证码
 */
public class CheckNumServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Font mFont = new Font("Times New Roman", Font.PLAIN, 18);

	static Color getRandomColor(int fc, int bc) {
		Random random = new Random();
		if (fc > 255) {
			fc = 255;
		}
		if (bc > 255) {
			bc = 255;
		}
		int r = fc + random.nextInt(bc - fc);
		int g = fc + random.nextInt(bc - fc);
		int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		response.setContentType("image/gif");
		response.setHeader("Prama", "No-cache");
		response.setDateHeader("Expires", 0);
		ServletOutputStream out = response.getOutputStream();
		BufferedImage image = new BufferedImage(60, 20,
				BufferedImage.TYPE_INT_RGB);
		Graphics gra = image.getGraphics();
		Random random = new Random();
		gra.setColor(getRandomColor(200, 250));
		gra.fillRect(0, 0, 60, 20);
		gra.setColor(Color.BLACK);
		gra.setFont(mFont);

		// 画线段
		gra.setColor(getRandomColor(160, 200));
		for (int i = 0; i < 155; i++) {
			int x1 = random.nextInt();
			int y1 = random.nextInt();
			int x2 = random.nextInt();
			int y2 = random.nextInt();
			gra.drawLine(x1, y1, x2, y2);
		}
		String sRan = "";

		// 随机四位验证码
		for (int i = 0; i < 4; i++) {
			String rand = String.valueOf(random.nextInt(10));
			sRan += rand;
			gra.setColor(new Color(20 + random.nextInt(110), 20 + random
					.nextInt(110), 20 + random.nextInt(110)));
			gra.drawString(rand, 13 * i + 6, 16);
		}
		session.setAttribute("getNum", sRan);
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		encoder.encode(image);
		out.close();
	}
	

}
