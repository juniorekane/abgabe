package hbv.web;

import hbv.service.Config;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import redis.clients.jedis.*;

public class RedisServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {

      response.setContentType("text/plain");
      PrintWriter out = response.getWriter();

      long start = System.nanoTime();
      Jedis jedis = new Jedis("localhost", 6379);
      jedis.auth(Config.getProperty("service_password"));

      Long result = jedis.incr("bar");
      long ende = System.nanoTime();
      out.format("value:%10d%11.4fms\n", result, (double)((ende-start)/1000000d));
      jedis.close();
  }
}
