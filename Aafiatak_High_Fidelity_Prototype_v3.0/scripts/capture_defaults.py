#!/usr/bin/env python3
from pathlib import Path
import re, json
from playwright.sync_api import sync_playwright
from PIL import Image, ImageDraw
ROOT=Path(__file__).resolve().parents[1]
CSS='\n'.join((ROOT/p).read_text(encoding='utf-8') for p in ['src/css/tokens.css','src/css/base.css','src/css/components.css','src/css/screens.css'])
JS=(ROOT/'dist/app.js').read_text(encoding='utf-8')
PREVIEW=ROOT/'screenshots/preview'; CONTACT=ROOT/'contact_sheets'; REVIEW=ROOT/'docs/reviews'
for d in (PREVIEW,CONTACT,REVIEW):d.mkdir(parents=True,exist_ok=True)
manifest=[]
for p in sorted((ROOT/'src/ts/screens').glob('PAT*.ts')):
 t=p.read_text(encoding='utf-8'); mid=re.search(r"id:'(PAT-\d+)'",t); default=re.search(r"defaultState:'([^']+)'",t); title=re.search(r"title:'([^']+)'",t)
 manifest.append((mid.group(1),default.group(1),title.group(1) if title else ''))
def html_for(s,st):return '<!doctype html><html lang="ar" dir="rtl"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><style>'+CSS+'</style></head><body><div id="app"></div><script>window.__AAF_SCREEN__='+repr(s)+';window.__AAF_STATE__='+repr(st)+';</script><script>'+JS+'</script></body></html>'
reports=[]
with sync_playwright() as pw:
 b=pw.chromium.launch(headless=True,executable_path='/usr/bin/chromium',args=['--no-sandbox','--disable-dev-shm-usage','--disable-gpu','--disable-background-networking','--disable-extensions'])
 for s,st,title in manifest:
  p=b.new_page(viewport={'width':390,'height':844},device_scale_factor=1);errs=[];p.on('pageerror',lambda e:errs.append(str(e)))
  p.set_content(html_for(s,st),wait_until='load');p.wait_for_timeout(50);m=p.locator('body').evaluate('(e)=>({w:e.scrollWidth,h:e.scrollHeight,cw:e.clientWidth})')
  fn=f'{s}-{st}-phone.png';p.screenshot(path=str(PREVIEW/fn),full_page=True,scale='css');reports.append({'screen':s,'state':st,'file':fn,'height':m['h'],'overflow':m['w']>m['cw'],'errors':errs});p.close()
 b.close()
(REVIEW/'defaults_capture_report.json').write_text(json.dumps(reports,ensure_ascii=False,indent=2),encoding='utf-8')
# sheets 7 per sheet 2 columns
for chunk_i in range(0,len(reports),7):
 chunk=reports[chunk_i:chunk_i+7]; tiles=[]
 for r in chunk:
  img=Image.open(PREVIEW/r['file']).convert('RGB');img.thumbnail((300,650));tile=Image.new('RGB',(330,720),'#F7F3EE');d=ImageDraw.Draw(tile);d.rounded_rectangle((10,8,320,36),12,fill='#FFFDF9',outline='#D8D0C8');d.text((18,16),r['file'],fill='#25232B');tile.paste(img,((330-img.width)//2,48));tiles.append(tile)
 cols=2;rows=(len(tiles)+1)//2;sheet=Image.new('RGB',(cols*330+48,rows*720+80),'#EEE8E1');d=ImageDraw.Draw(sheet);d.text((24,22),f'Aafiatak Defaults {chunk_i+1}-{chunk_i+len(chunk)}',fill='#4A315D')
 for i,t in enumerate(tiles):rr,cc=divmod(i,2);sheet.paste(t,(16+cc*346,58+rr*720))
 sheet.save(CONTACT/f'defaults_{chunk_i//7+1}.png')
print(json.dumps({'screens':len(reports),'overflow':sum(r['overflow'] for r in reports),'errors':sum(bool(r['errors']) for r in reports)},ensure_ascii=False))
