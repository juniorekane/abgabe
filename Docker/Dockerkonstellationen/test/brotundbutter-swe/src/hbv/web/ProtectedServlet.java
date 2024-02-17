package hbv.web;
import java.io.*;
import java.time.*;
import java.time.format.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ProtectedServlet extends HttpServlet {

  protected void doGet(HttpServletRequest  request,
      HttpServletResponse response)
      throws IOException, ServletException {

      response.setContentType("text/plain");
      PrintWriter out = response.getWriter();

      HttpSession session=request.getSession(false);
      if(session != null){
        out.println("you are logged in as "+session.getAttribute("user")+" at protected");
      } else {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.sendRedirect("default.txt");
      }
  }
}
