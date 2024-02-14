package hbv.web;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import hbv.service.*;
import hbv.service.Config;
import redis.clients.jedis.*;
public class TestServlet extends HttpServlet {

  protected void doGet(HttpServletRequest  request,
      HttpServletResponse response)
      throws IOException, ServletException {

      response.setContentType("text/plain");
      PrintWriter out = response.getWriter();
      Test db = new Test();
      db.doQuery(out);
      //db.doInsert("Kevin","testemail","testpasswort",true,"testuhrzeit","testdatum");
      //db.doInsert("Kevin","testemail","testpasswort",false,"testuhrzeit","testdatum");
      //Jedis jedis = new Jedis("localhost", 6379);
      //jedis.auth(Config.getProperty("service_password"));

      //Long result = jedis.lpush("test", "Kevin,testemail,testpasswort,false,testuhrzeit,testdatum");
      //jedis.close();
  }
}
