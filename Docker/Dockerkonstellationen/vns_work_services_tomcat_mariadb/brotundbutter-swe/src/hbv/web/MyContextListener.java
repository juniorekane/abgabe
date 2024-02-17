package hbv.web;

import hbv.service.*;
import jakarta.servlet.*;
import java.util.concurrent.*;

public class MyContextListener implements ServletContextListener, ServletRequestListener {
  ScheduledThreadPoolExecutor executor;
  ServletContext ctx;

  public void contextInitialized(ServletContextEvent servletContextEvent) {
    ctx = servletContextEvent.getServletContext();
    Config.init();
    Database.init();
    MyLogger.info("initialized");
    executor = new ScheduledThreadPoolExecutor(1);
    executor.scheduleAtFixedRate(new MonitorStateLogger(), 0, 10, TimeUnit.SECONDS);
  }

  public void contextDestroyed(ServletContextEvent servletContextEvent) {
    MyLogger.info("cancel timer");
    executor.shutdownNow();
  }

  public void requestInitialized(ServletRequestEvent evt) {}

  public void requestDestroyed(ServletRequestEvent evt) {}

}

class MonitorStateLogger implements Runnable {
  int count;

  public void run() {
    MyLogger.info("Info:" + (count++) + " java:"+System.getProperty("java.version"));
  }
}
