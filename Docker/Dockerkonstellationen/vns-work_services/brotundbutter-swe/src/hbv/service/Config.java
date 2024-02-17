package hbv.service;

import java.io.InputStream;
import java.util.Properties;

/**
 * <code>Config</code>
 * <p>
 * loads properties from server.properties somewhere on the classpath ...
 */
public class Config {
  static Properties properties = new Properties();

  /**
   * <strong>Init</strong> should be called once in ContextListener.
   *
   * <p>
   * loads server.properties
   * and do some other stuff
   */
  public static void init() {
    try (InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream("server.properties")) {
      properties.load(is);
    } catch (Exception e) {
      MyLogger.info("server.properties not found or correct " + e);
    }
  }

  /**
   * <strong>getProperty</strong> returns value for passed key
   *
   * @param key
   * @return value in server.properties
   */
  public static String getProperty(String key) {
    return properties.getProperty(key);
  }
}
