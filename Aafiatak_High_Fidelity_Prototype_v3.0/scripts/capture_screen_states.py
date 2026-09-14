#!/usr/bin/env python3
from pathlib import Path
import re,json,sys
from playwright.sync_api import sync_playwright
from PIL import Image,ImageDraw
ROOT=Path(__file__).resolve().parents[1]
SID=(sys.argv[1] if len(sys.argv)>1 else 'PAT-01').upper()
CSS='\n'.join((ROOT/p).read_text(encoding='utf-8') for p in ['src/css/tokens.css','src/css/base.css','src/css/components.css','src/css/screens.css'])
JS=(ROOT/'dist/app.js').read_text(encoding='utf-8')
PREVIEW=ROOT/'screenshots/preview';CONTACT=ROOT/'contact_sheets';REVIEW=ROOT/'docs/reviews'
pth=ROOT/'src/ts/screens'/('PAT'+SID.split('-')[1]+'.ts')
t=pth.read_text(encoding='utf-8');title=re.search(r"title:'([^']+)'",t).group(1);states=re.findall(r"'([^']+)'",re.search(r"states:\[([^\]]+)\]",t,re.S).group(1))
def html(st):
  near = st=='hold-near-expiry'
  hold = '00:42' if near else '04:18'
  return '<!doctype html><html lang="ar" dir="rtl"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><style>'+CSS+'</style></head><body><div id="app"></div><script>window.__AAF_SCREEN__='+repr(SID)+';window.__AAF_STATE__='+repr(st)+';window.__AAF_OTP_LENGTH__=6;window.__AAF_HOLD_REMAINING__='+repr(hold)+';</script><script>'+JS+'</script></body></html>'
reports=[]
with sync_playwright() as pw:
 b=pw.chromium.launch(headless=True,executable_path='/usr/bin/chromium',args=['--no-sandbox','--disable-dev-shm-usage','--disable-gpu','--disable-background-networking','--disable-extensions'])
 p=b.new_page(viewport={'width':390,'height':844},device_scale_factor=1)
 for st in states:
  errs=[];p.set_content(html(st),wait_until='load');m=p.locator('body').evaluate('(e)=>({w:e.scrollWidth,h:e.scrollHeight,cw:e.clientWidth})');fn=f'{SID}-{st}-phone.png';p.screenshot(path=str(PREVIEW/fn),full_page=True,scale='css');reports.append({'state':st,'file':fn,'h':m['h'],'overflow':m['w']>m['cw'],'errors':errs})
 p.close();b.close()
# contact sheet
paths=[PREVIEW/r['file'] for r in reports];tiles=[]
for pp in paths:
 im=Image.open(pp).convert('RGB');im.thumbnail((250,620));tile=Image.new('RGB',(275,680),'#F7F3EE');d=ImageDraw.Draw(tile);d.rounded_rectangle((8,8,267,34),10,fill='#FFFDF9',outline='#D8D0C8');d.text((14,16),pp.stem,fill='#25232B');tile.paste(im,((275-im.width)//2,44));tiles.append(tile)
cols=3;rows=(len(tiles)+2)//3;sheet=Image.new('RGB',(cols*275+(cols+1)*12,rows*680+58),'#EEE8E1');d=ImageDraw.Draw(sheet);d.text((18,20),f'{SID} — {title}',fill='#4A315D')
for i,tile in enumerate(tiles):rr,cc=divmod(i,cols);sheet.paste(tile,(12+cc*287,46+rr*680))
out=CONTACT/f'{SID}_states.png';sheet.save(out)
(REVIEW/f'{SID}_capture_report.json').write_text(json.dumps(reports,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps({'screen':SID,'states':len(states),'overflow':sum(r['overflow'] for r in reports),'errors':sum(bool(r['errors']) for r in reports),'contact':str(out)},ensure_ascii=False))
