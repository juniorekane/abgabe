package hbv.web;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import hbv.service.*;

public class SQLServlet extends HttpServlet {

  protected void doGet(HttpServletRequest  request,
      HttpServletResponse response)
      throws IOException, ServletException {

      response.setContentType("text/plain");
      PrintWriter out = response.getWriter();
      Database db = new Database();
      db.doInsert("Moin");
      db.doQuery(out);
  }
}
