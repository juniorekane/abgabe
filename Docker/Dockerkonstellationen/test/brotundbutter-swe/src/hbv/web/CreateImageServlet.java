package hbv.web;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

import java.awt.Graphics2D;
import java.awt.Color;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

public class CreateImageServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException {
     response.setContentType("image/png");
     int width=128,height=128;
     BufferedImage img = new BufferedImage(width, height,BufferedImage.TYPE_INT_ARGB);
     Graphics2D g2 = img.createGraphics();
     g2.setBackground(Color.GRAY);
     g2.clearRect(0, 0, width, height);
     g2.dispose();
     ImageIO.write(img, "PNG", response.getOutputStream());
  }

}
