#!/usr/bin/env python3
from pathlib import Path
import re,json
from playwright.sync_api import sync_playwright
from PIL import Image,ImageDraw
ROOT=Path(__file__).resolve().parents[1]
CSS='\n'.join((ROOT/p).read_text(encoding='utf-8') for p in ['src/css/tokens.css','src/css/base.css','src/css/components.css','src/css/screens.css'])
JS=(ROOT/'dist/app.js').read_text(encoding='utf-8')
PREVIEW=ROOT/'screenshots/preview'; CONTACT=ROOT/'contact_sheets'; REVIEW=ROOT/'docs/reviews'
manifest=[]
for p in sorted((ROOT/'src/ts/screens').glob('PAT*.ts')):
 t=p.read_text(encoding='utf-8'); sid=re.search(r"id:'(PAT-\d+)'",t).group(1); title=re.search(r"title:'([^']+)'",t).group(1); default=re.search(r"defaultState:'([^']+)'",t).group(1); st=re.findall(r"'([^']+)'",re.search(r"states:\[([^\]]+)\]",t,re.S).group(1));manifest.append({'id':sid,'title':title,'default':default,'states':st})
def html(s,st):return '<!doctype html><html lang="ar" dir="rtl"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><style>'+CSS+'</style></head><body><div id="app"></div><script>window.__AAF_SCREEN__='+repr(s)+';window.__AAF_STATE__='+repr(st)+';</script><script>'+JS+'</script></body></html>'
reports=[]
with sync_playwright() as pw:
 b=pw.chromium.launch(headless=True,executable_path='/usr/bin/chromium',args=['--no-sandbox','--disable-dev-shm-usage','--disable-gpu','--disable-background-networking','--disable-extensions'])
 for rec in manifest:
  for st in rec['states']:
   p=b.new_page(viewport={'width':390,'height':844},device_scale_factor=1);errs=[];p.on('pageerror',lambda e:errs.append(str(e)));p.set_content(html(rec['id'],st),wait_until='load');m=p.locator('body').evaluate('(e)=>({w:e.scrollWidth,h:e.scrollHeight,cw:e.clientWidth})');fn=f"{rec['id']}-{st}-phone.png";p.screenshot(path=str(PREVIEW/fn),full_page=True,scale='css');reports.append({'screen':rec['id'],'state':st,'file':fn,'h':m['h'],'overflow':m['w']>m['cw'],'errors':errs});p.close()
 b.close()
(REVIEW/'all_states_capture_report.json').write_text(json.dumps(reports,ensure_ascii=False,indent=2),encoding='utf-8')
# per-screen contact sheets max 3 cols, tile each ~240w
for rec in manifest:
 paths=[PREVIEW/f"{rec['id']}-{s}-phone.png" for s in rec['states']]
 tiles=[]
 for pth in paths:
  img=Image.open(pth).convert('RGB'); img.thumbnail((230,560)); tile=Image.new('RGB',(250,625),'#F7F3EE'); d=ImageDraw.Draw(tile); d.rounded_rectangle((8,8,242,34),10,fill='#FFFDF9',outline='#D8D0C8'); d.text((14,16),pth.stem,fill='#25232B');tile.paste(img,((250-img.width)//2,44));tiles.append(tile)
 cols=3;rows=(len(tiles)+cols-1)//cols;sheet=Image.new('RGB',(cols*250+(cols+1)*12,rows*625+56),'#EEE8E1');d=ImageDraw.Draw(sheet);d.text((18,20),f"{rec['id']} states — {rec['title']}",fill='#4A315D')
 for i,t in enumerate(tiles):rr,cc=divmod(i,cols);sheet.paste(t,(12+cc*262,44+rr*625))
 sheet.save(CONTACT/f"{rec['id']}_states.png")
summary={'screens':len(manifest),'states':len(reports),'overflow':sum(r['overflow'] for r in reports),'runtime_errors':sum(bool(r['errors']) for r in reports)}
(REVIEW/'all_states_capture_summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(summary,ensure_ascii=False))
