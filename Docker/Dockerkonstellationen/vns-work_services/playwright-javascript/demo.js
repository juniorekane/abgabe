const playwright = require('playwright-core');

(async () => {
  const browser = await playwright.chromium.launch({});
  const context = await browser.newContext({
    recordVideo: { dir: 'videos/',
    size: { width: 1080, height: 720 },
    }

  });
  const page = await context.newPage();
	  page.setViewportSize({ width: 1080, height: 720 });
  await page.goto('https://informatik.hs-bremerhaven.de/oradfelder/koggethon')
  await page.waitForTimeout(12000);
  await page.screenshot({ path: 'example.png' });
  await context.close();
  await browser.close();
})();
