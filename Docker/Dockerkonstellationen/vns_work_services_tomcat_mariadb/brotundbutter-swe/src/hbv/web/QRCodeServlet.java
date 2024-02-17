package hbv.web;
import java.io.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

import com.google.zxing.*;
import com.google.zxing.common.*;
import com.google.zxing.client.j2se.*;


public class QRCodeServlet extends HttpServlet {

  protected void doGet(HttpServletRequest  request,
      HttpServletResponse response)
      throws IOException, ServletException {

      try{
        response.setContentType("image/png");
        int size=512;
        BitMatrix matrix = new MultiFormatWriter().encode("Moin Moin",BarcodeFormat.QR_CODE,size,size);
        BufferedImage bi = MatrixToImageWriter.toBufferedImage(matrix);
        ImageIO.write(bi, "PNG", response.getOutputStream());
      }catch(WriterException we){
        throw new IOException("could not write image:"+we);
      }
  }
}
