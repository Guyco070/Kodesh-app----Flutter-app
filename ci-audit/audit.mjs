// Site audit: screenshots, Flutter semantics tree, axe-core, console errors,
// keyboard focus. Writes everything into ./audit-out.
import { chromium } from 'playwright';
import AxeBuilder from '@axe-core/playwright';
import fs from 'node:fs';

const BASE = process.env.BASE_URL || 'http://localhost:8080/';
const OUT = 'audit-out';
fs.mkdirSync(OUT, { recursive: true });

const routes = [
  ['home', ''],
  ['schedule-notifications', '#/schedule-notifications'],
  ['adlakat_nerot', '#/adlakat_nerot'],
  ['havdalah', '#/havdalah'],
  ['seder_anahat_tefilin', '#/seder_anahat_tefilin'],
  ['adlakat_nerot_chanuca', '#/adlakat_nerot_chanuca'],
  ['sfirat_omer_screen', '#/sfirat_omer_screen'],
  ['birkat_hamazon', '#/birkat_hamazon'],
  ['kriyat_shema_al_hamita', '#/kriyat_shema_al_hamita'],
  ['shabat_and_holidays_check_list', '#/shabat_and_holidays_check_list'],
  ['compass_screen', '#/compass_screen'],
  ['daf_yomi', '#/daf_yomi'],
  ['holiday_calendar', '#/holiday_calendar'],
  ['about', '#/about'],
  ['accessibility', '#/accessibility'],
  ['privacy', '#/privacy'],
];

const viewports = {
  mobile: { viewport: { width: 390, height: 844 }, isMobile: true, hasTouch: true, deviceScaleFactor: 2 },
  desktop: { viewport: { width: 1366, height: 900 }, deviceScaleFactor: 1 },
  // ~200% browser zoom on a laptop (WCAG 1.4.4 resize text)
  zoom200: { viewport: { width: 683, height: 450 }, deviceScaleFactor: 2 },
};

const runs = [];
for (const [name, hash] of routes) {
  runs.push({ name, hash, lang: 'he', vp: 'mobile' });
  runs.push({ name, hash, lang: 'he', vp: 'desktop' });
  runs.push({ name, hash, lang: 'en', vp: 'mobile' });
}
runs.push({ name: 'home', hash: '', lang: null, vp: 'mobile' }); // first visit
runs.push({ name: 'home', hash: '', lang: 'he', vp: 'zoom200' });
runs.push({ name: 'holiday_calendar', hash: '#/holiday_calendar', lang: 'he', vp: 'zoom200' });

async function enableSemantics(page) {
  await page.evaluate(() => {
    const ph = document.querySelector('flt-semantics-placeholder');
    if (ph) ph.click();
  });
  await page.waitForTimeout(1500);
}

async function settle(page) {
  await page.waitForSelector('flutter-view, flt-glass-pane', { timeout: 60000 });
  try {
    await page.waitForLoadState('networkidle', { timeout: 20000 });
  } catch {}
  await page.waitForTimeout(3500);
}

const browser = await chromium.launch();
const summary = [];

for (const r of runs) {
  const id = `${r.name}__${r.lang ?? 'fresh'}__${r.vp}`;
  const ctx = await browser.newContext({
    ...viewports[r.vp],
    locale: r.lang === 'en' ? 'en-US' : 'he-IL',
  });
  if (r.lang) {
    await ctx.addInitScript((lang) => {
      localStorage.setItem('flutter.language', JSON.stringify(lang));
    }, r.lang);
  }
  const page = await ctx.newPage();
  const consoleMsgs = [];
  const failedRequests = [];
  page.on('console', (m) => {
    if (['error', 'warning'].includes(m.type())) consoleMsgs.push(`${m.type()}: ${m.text()}`);
  });
  page.on('pageerror', (e) => consoleMsgs.push(`pageerror: ${e.message}`));
  page.on('requestfailed', (q) => failedRequests.push(`${q.url()} ${q.failure()?.errorText}`));
  page.on('response', (res) => {
    if (res.status() >= 400) failedRequests.push(`${res.status()} ${res.url()}`);
  });

  const entry = { id, ...r };
  const t0 = Date.now();
  try {
    await page.goto(BASE + r.hash, { waitUntil: 'load', timeout: 60000 });
    await settle(page);
    entry.loadMs = Date.now() - t0;
    await page.screenshot({ path: `${OUT}/${id}.png`, fullPage: false });

    entry.html = await page.evaluate(() => ({
      lang: document.documentElement.lang,
      dir: document.documentElement.dir,
      title: document.title,
      description: document.querySelector('meta[name=description]')?.content,
      viewport: document.querySelector('meta[name=viewport]')?.content,
      hasPlaceholder: !!document.querySelector('flt-semantics-placeholder'),
      placeholderLabel: document.querySelector('flt-semantics-placeholder')?.getAttribute('aria-label'),
    }));

    // Accessibility before the hidden "enable accessibility" button is used
    entry.semanticsNodesBefore = await page.evaluate(
      () => document.querySelectorAll('flt-semantics').length,
    );
    await enableSemantics(page);
    entry.semanticsNodesAfter = await page.evaluate(
      () => document.querySelectorAll('flt-semantics').length,
    );

    try {
      entry.aria = await page.locator('body').ariaSnapshot({ timeout: 10000 });
    } catch (e) {
      entry.aria = `ariaSnapshot failed: ${e.message}`;
    }

    try {
      const axe = await new AxeBuilder({ page })
        .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])
        .analyze();
      entry.axe = axe.violations.map((v) => ({
        id: v.id,
        impact: v.impact,
        help: v.help,
        nodes: v.nodes.length,
        sample: v.nodes.slice(0, 3).map((n) => n.html.slice(0, 200)),
      }));
    } catch (e) {
      entry.axe = `axe failed: ${e.message}`;
    }

    // Keyboard: tab through and record what receives focus
    const focus = [];
    for (let i = 0; i < 12; i++) {
      await page.keyboard.press('Tab');
      await page.waitForTimeout(150);
      focus.push(
        await page.evaluate(() => {
          const a = document.activeElement;
          if (!a) return null;
          return `${a.tagName.toLowerCase()} role=${a.getAttribute('role')} label=${(a.getAttribute('aria-label') || a.textContent || '').trim().slice(0, 60)}`;
        }),
      );
    }
    entry.tabOrder = focus;
    await page.screenshot({ path: `${OUT}/${id}__after-tab.png` });

    if (r.name === 'home' && r.vp === 'mobile' && r.lang) {
      // Second tab (zmanim) and the drawer menu
      const tabText = r.lang === 'he' ? 'זמני היום' : "Today's times";
      const tab = page.locator('flt-semantics', { hasText: tabText }).last();
      if (await tab.count()) {
        await tab.click({ force: true });
        await page.waitForTimeout(4000);
        await page.screenshot({ path: `${OUT}/${id}__zmanim.png` });
        try {
          entry.ariaZmanim = await page.locator('body').ariaSnapshot({ timeout: 10000 });
        } catch {}
        await page.mouse.wheel(0, 600);
        await page.waitForTimeout(800);
        await page.screenshot({ path: `${OUT}/${id}__zmanim-scrolled.png` });
      } else {
        entry.note = 'zmanim tab not found in semantics';
      }
      const w = viewports[r.vp].viewport.width;
      await page.mouse.click(r.lang === 'he' ? w - 26 : 26, 26);
      await page.waitForTimeout(1500);
      await page.screenshot({ path: `${OUT}/${id}__drawer.png` });
      try {
        entry.ariaDrawer = await page.locator('body').ariaSnapshot({ timeout: 10000 });
      } catch {}
    }
    if (r.vp === 'mobile') {
      await page.mouse.wheel(0, 700);
      await page.waitForTimeout(800);
      await page.screenshot({ path: `${OUT}/${id}__scrolled.png` });
    }
  } catch (e) {
    entry.error = e.message;
    try {
      await page.screenshot({ path: `${OUT}/${id}__error.png` });
    } catch {}
  }
  entry.console = consoleMsgs.slice(0, 40);
  entry.failedRequests = failedRequests.slice(0, 40);
  summary.push(entry);
  fs.writeFileSync(`${OUT}/${id}.json`, JSON.stringify(entry, null, 2));
  await ctx.close();
  console.log(`done ${id} ${entry.error ? 'ERROR ' + entry.error : ''}`);
}

fs.writeFileSync(
  `${OUT}/summary.json`,
  JSON.stringify(
    summary.map(({ aria, ariaZmanim, ariaDrawer, ...rest }) => rest),
    null,
    2,
  ),
);
await browser.close();
