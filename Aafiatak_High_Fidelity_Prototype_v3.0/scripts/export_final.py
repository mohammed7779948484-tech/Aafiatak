#!/usr/bin/env python3
from pathlib import Path
import re,json
from playwright.sync_api import sync_playwright
from PIL import Image,ImageDraw
ROOT=Path(__file__).resolve().parents[1]
CSS='\n'.join((ROOT/p).read_text(encoding='utf-8') for p in ['src/css/tokens.css','src/css/base.css','src/css/components.css','src/css/screens.css'])
JS=(ROOT/'dist/app.js').read_text(encoding='utf-8')
VP=ROOT/'screenshots/final_phone_viewport_4x'; FULL=ROOT/'screenshots/final_phone_full_3x'; CONTACT=ROOT/'contact_sheets'; REVIEW=ROOT/'docs/reviews'
for d in (VP,FULL,CONTACT,REVIEW): d.mkdir(parents=True,exist_ok=True)
manifest=[]
for p in sorted((ROOT/'src/ts/screens').glob('PAT*.ts')):
 t=p.read_text(encoding='utf-8'); sid=re.search(r"id:'(PAT-\d+)'",t).group(1); title=re.search(r"title:'([^']+)'",t).group(1); default=re.search(r"defaultState:'([^']+)'",t).group(1); manifest.append({'id':sid,'title':title,'default':default})
def html(rec):
 hold='04:18'
 return '<!doctype html><html lang="ar" dir="rtl"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><style>'+CSS+'</style></head><body><div id="app"></div><script>window.__AAF_SCREEN__='+repr(rec['id'])+';window.__AAF_STATE__='+repr(rec['default'])+';window.__AAF_OTP_LENGTH__=6;window.__AAF_HOLD_REMAINING__='+repr(hold)+';</script><script>'+JS+'</script></body></html>'
reports=[]
with sync_playwright() as pw:
 b=pw.chromium.launch(headless=True,executable_path='/usr/bin/chromium',args=['--no-sandbox','--disable-dev-shm-usage','--disable-gpu','--disable-background-networking','--disable-extensions'])
 vp=b.new_page(viewport={'width':390,'height':844},device_scale_factor=4)
 full=b.new_page(viewport={'width':390,'height':844},device_scale_factor=3)
 for rec in manifest:
  # actual phone viewport
  vp.set_content(html(rec),wait_until='load')
  vp_name=f"{rec['id']}-{rec['default']}-viewport-4x.png"
  vp.screenshot(path=str(VP/vp_name),full_page=False,scale='device')
  # full scroll reference: move persistent controls to document end ONLY for export readability
  full.set_content(html(rec),wait_until='load')
  full.add_style_tag(content='''
    .bottom-action,.bottom-nav{position:static!important;inset:auto!important;width:100%!important;margin:0!important;transform:none!important;backdrop-filter:none!important}
    .phone.with-bottom-action,.phone.with-bottom-nav{padding-bottom:0!important}
  ''')
  m=full.locator('body').evaluate('(e)=>({w:e.scrollWidth,h:e.scrollHeight,cw:e.clientWidth})')
  full_name=f"{rec['id']}-{rec['default']}-full-3x.png"
  full.screenshot(path=str(FULL/full_name),full_page=True,scale='device')
  reports.append({'screen':rec['id'],'title':rec['title'],'state':rec['default'],'viewport_file':vp_name,'full_file':full_name,'full_css_width':m['w'],'full_css_height':m['h'],'overflow':m['w']>m['cw']})
 vp.close(); full.close(); b.close()
(REVIEW/'FINAL_EXPORT_REPORT.json').write_text(json.dumps(reports,ensure_ascii=False,indent=2),encoding='utf-8')
# Build final contact sheet from full references at thumbnail size
imgs=[]
for r in reports:
 p=FULL/r['full_file'];im=Image.open(p).convert('RGB');im.thumbnail((260,620));tile=Image.new('RGB',(290,690),'#F7F3EE');d=ImageDraw.Draw(tile);d.rounded_rectangle((10,8,280,34),10,fill='#FFFDF9',outline='#D8D0C8');d.text((18,16),r['screen']+' — '+r['state'],fill='#25232B');tile.paste(im,((290-im.width)//2,44));imgs.append(tile)
cols=3;rows=(len(imgs)+2)//3;sheet=Image.new('RGB',(cols*290+(cols+1)*14,rows*690+64),'#EEE8E1');d=ImageDraw.Draw(sheet);d.text((22,20),'Aafiatak — Final High-Fidelity Phone Screens',fill='#4A315D')
for i,t in enumerate(imgs):rr,cc=divmod(i,cols);sheet.paste(t,(14+cc*304,48+rr*690))
sheet.save(CONTACT/'FINAL_21_SCREENS_OVERVIEW.png')
print(json.dumps({'screens':len(reports),'viewport_4x':len(list(VP.glob('*.png'))),'full_3x':len(list(FULL.glob('*.png'))),'overflow':sum(r['overflow'] for r in reports)},ensure_ascii=False))
