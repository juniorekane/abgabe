package hbv.web;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class GetImageServlet extends HttpServlet {

	protected void doGet(HttpServletRequest  request,
			HttpServletResponse response)
			throws IOException, ServletException {

			String id = request.getParameter("id");
			response.setContentType("image/png");
			FileInputStream fis = new FileInputStream("/data/upload/"+id);
			copy(fis,response.getOutputStream());
      // ab java 9
      // fis.transferTo(response.getOutputStream());

	}

	void copy(InputStream source, OutputStream target) throws IOException {
		byte[] buf = new byte[8192];
		int length;
		while ((length = source.read(buf)) != -1) {
			target.write(buf, 0, length);
		}
	}
}
