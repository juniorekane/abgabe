package hbv.web;

import java.io.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import org.json.*;

// https://www.baeldung.com/java-org-json

public class JSONServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    JSONObject jo = new JSONObject();
    jo.put("name","Peter");
    jo.put("alter",42);
    out.println(jo);

  }
}
