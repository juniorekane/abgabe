package hbv.playwright;
import java.nio.file.Paths;
import com.microsoft.playwright.*;

public class Main {
  public static void main(String[] args) {
    Playwright playwright = Playwright.create();
    Browser browser = playwright.chromium().launch();
    BrowserContext context = 
      browser.newContext(new Browser.NewContextOptions()
          .setRecordVideoDir(Paths.get("videos/")));

    Page page = context.newPage();
    page.navigate("https://informatik.hs-bremerhaven.de/oradfelder/newsplines.html");
    doSleep(1000);
    page.navigate("https://informatik.hs-bremerhaven.de/oradfelder/");
    doSleep(1000);
    System.out.println(page.title());
    context.close();
    browser.close();
    playwright.close();
  }
  static void doSleep(int ms){
    try{Thread.sleep(ms);}catch(InterruptedException e){}
  }
}



