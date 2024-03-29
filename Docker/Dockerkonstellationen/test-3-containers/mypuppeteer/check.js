const puppeteer = require('puppeteer-core')
async function main (){
  
  const browser = await puppeteer.launch({
    executablePath: '/usr/bin/chromium',
    args: ['--no-sandbox'], // im docker - siehe unten
    headless: "new",
  })
  const page = await browser.newPage()
  await page.waitForTimeout(1000)
  await page.goto('https://informatik.hs-bremerhaven.de/oradfelder/')
  await page.waitForTimeout(1000)
  const recorder = await page.screencast({path: 'recording.webm'});
  await page.screenshot({ path: 'puppeteer1.png', fullPage: true });
  await page.waitForTimeout(1000)
  await page.goto('https://informatik.hs-bremerhaven.de/kvosseberg/')
  await page.waitForTimeout(1000)
  await page.screenshot({ path: 'puppeteer2.png', fullPage: true });
  await page.goto('https://informatik.hs-bremerhaven.de/uerb/')
  await page.waitForTimeout(1000)
  await page.screenshot({ path: 'puppeteer3.png', fullPage: true });
  await page.goto('https://informatik.hs-bremerhaven.de/lafischer/')
  await page.waitForTimeout(1000)
  await page.screenshot({ path: 'puppeteer4.png', fullPage: true });
  await page.goto('https://informatik.hs-bremerhaven.de/hlipskoch/')
  await page.waitForTimeout(1000)
  await page.screenshot({ path: 'puppeteer5.png', fullPage: true });
  await recorder.stop();
  await browser.close()
}
main()
