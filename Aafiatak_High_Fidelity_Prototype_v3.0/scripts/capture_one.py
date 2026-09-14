#!/usr/bin/env python3
from pathlib import Path
import sys, json
from playwright.sync_api import sync_playwright

root=Path(__file__).resolve().parents[1]
screen=(sys.argv[1] if len(sys.argv)>1 else "PAT-01").upper()
state=(sys.argv[2] if len(sys.argv)>2 else "default").lower()
width=int(sys.argv[3]) if len(sys.argv)>3 else 390
height=int(sys.argv[4]) if len(sys.argv)>4 else 844

css="\n".join((root/p).read_text(encoding="utf-8") for p in [
    "src/css/tokens.css","src/css/base.css","src/css/components.css","src/css/screens.css"
])
js=(root/"dist/app.js").read_text(encoding="utf-8")
html = (
    '<!doctype html><html lang="ar" dir="rtl"><head><meta charset="UTF-8">'
    '<meta name="viewport" content="width=device-width,initial-scale=1">'
    '<style>'+css+'</style></head><body><div id="app"></div>'
    '<script>window.__AAF_SCREEN__='+repr(screen)+';window.__AAF_STATE__='+repr(state)+';</script>'
    '<script>'+js+'</script></body></html>'
)

master=root/"screenshots/master"
preview=root/"screenshots/preview"
master.mkdir(parents=True,exist_ok=True)
preview.mkdir(parents=True,exist_ok=True)
name=f"{screen}-{state}-phone"

with sync_playwright() as p:
    browser=p.chromium.launch(
        headless=True,
        executable_path="/usr/bin/chromium",
        args=["--no-sandbox","--disable-dev-shm-usage","--disable-gpu","--disable-background-networking","--disable-extensions"]
    )
    page=browser.new_page(viewport={"width":width,"height":height},device_scale_factor=4)
    errors=[]
    page.on("pageerror",lambda e: errors.append(str(e)))
    page.set_content(html,wait_until="load")
    page.wait_for_timeout(240)
    metrics=page.locator("body").evaluate("(e)=>({scrollWidth:e.scrollWidth,scrollHeight:e.scrollHeight,clientWidth:e.clientWidth})")
    page.screenshot(path=str(master/f"{name}.png"),full_page=True,scale="device")
    page.screenshot(path=str(preview/f"{name}.png"),full_page=True,scale="css")
    browser.close()

report={
    "screen":screen,"state":state,"width":width,"height":height,
    "metrics":metrics,"errors":errors,
    "overflow":metrics["scrollWidth"]>metrics["clientWidth"]
}
(root/"docs/reviews"/f"{screen}-{state}-capture.json").write_text(
    json.dumps(report,ensure_ascii=False,indent=2),encoding="utf-8"
)
print(json.dumps(report,ensure_ascii=False))
