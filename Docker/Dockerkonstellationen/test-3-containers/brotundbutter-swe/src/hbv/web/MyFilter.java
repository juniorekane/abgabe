package hbv.web;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 * <strong>MyFilter</strong> extends HttpFilter.
 *
 * <p>
 */
public class MyFilter extends HttpFilter {
  ServletContext ctx;

  public void init(FilterConfig config) throws ServletException {
    ctx = config.getServletContext();
  }

  public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
      throws java.io.IOException, ServletException {

    // MyLogger.info("in doFilter");
    // String forwardedFor = hsr.getHeader("X-Forwarded-For");
    // String requestURL = "" + hsr.getRequestURL();

    chain.doFilter(request, response);
  }

  public void destroy() {}
}
