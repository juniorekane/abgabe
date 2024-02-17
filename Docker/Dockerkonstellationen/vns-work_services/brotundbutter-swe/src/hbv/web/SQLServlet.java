package hbv.web;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import hbv.service.*;
import redis.clients.jedis.*;

public class SQLServlet extends HttpServlet {

  protected void doGet(HttpServletRequest  request,
      HttpServletResponse response)
      throws IOException, ServletException {

      response.setContentType("text/plain");
      PrintWriter out = response.getWriter();
      Database db = new Database();
      db.doInsert("Moin");
      db.doQuery(out);
      Jedis jedis = new Jedis("localhost", 6379);
      jedis.auth(Config.getProperty("service_password"));

      jedis.lpush("test", "Kevin,testemail,testpasswort,false,testuhrzeit,testdatum");
      jedis.close();
  }
}
