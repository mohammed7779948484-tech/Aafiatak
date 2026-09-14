#!/usr/bin/env python3
from pathlib import Path
import re,json
from playwright.sync_api import sync_playwright
ROOT=Path(__file__).resolve().parents[1]
CSS='\n'.join((ROOT/p).read_text(encoding='utf-8') for p in ['src/css/tokens.css','src/css/base.css','src/css/components.css','src/css/screens.css'])
JS=(ROOT/'dist/app.js').read_text(encoding='utf-8')
manifest=[]
for p in sorted((ROOT/'src/ts/screens').glob('PAT*.ts')):
 t=p.read_text(encoding='utf-8');sid=re.search(r"id:'(PAT-\d+)'",t).group(1);sts=re.findall(r"'([^']+)'",re.search(r"states:\[([^\]]+)\]",t,re.S).group(1));manifest.append((sid,sts))
def html(s,st):
 hold='00:42' if st=='hold-near-expiry' else '04:18'
 return '<!doctype html><html lang="ar" dir="rtl"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><style>'+CSS+'</style></head><body><div id="app"></div><script>window.__AAF_SCREEN__='+repr(s)+';window.__AAF_STATE__='+repr(st)+';window.__AAF_OTP_LENGTH__=6;window.__AAF_HOLD_REMAINING__='+repr(hold)+';</script><script>'+JS+'</script></body></html>'
issues=[];checked=0
with sync_playwright() as pw:
 b=pw.chromium.launch(headless=True,executable_path='/usr/bin/chromium',args=['--no-sandbox','--disable-dev-shm-usage','--disable-gpu','--disable-background-networking','--disable-extensions'])
 p=b.new_page(viewport={'width':390,'height':844},device_scale_factor=1)
 for sid,states in manifest:
  for st in states:
   p.set_content(html(sid,st),wait_until='load');checked+=1
   data=p.evaluate('''() => {
     const body=document.body;
     const selectors=['button','.search-field','.input-shell'];
     const nodes=[...document.querySelectorAll(selectors.join(','))];
     return {
       body:{sw:body.scrollWidth,cw:body.clientWidth},
       bad:nodes.map((el,i)=>{const r=el.getBoundingClientRect();return {tag:el.tagName,cls:el.className,w:r.width,h:r.height,text:(el.textContent||'').trim().slice(0,50)}}).filter(x=>x.w<44||x.h<44),
       emptyButtons:[...document.querySelectorAll('button')].filter(b=>!(b.getAttribute('aria-label')||b.textContent?.trim())).length,
       unlabeledInputs:[...document.querySelectorAll('input,textarea')].filter(i=>!(i.getAttribute('aria-label')||i.closest('label'))).length
     }
   }''')
   if data['body']['sw']>data['body']['cw'] or data['bad'] or data['emptyButtons'] or data['unlabeledInputs']:
    issues.append({'screen':sid,'state':st,**data})
 p.close();b.close()
summary={'states_checked':checked,'issue_states':len(issues),'issues':issues}
(ROOT/'docs/reviews/AUTOMATED_UI_AUDIT.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps({'states_checked':checked,'issue_states':len(issues),'small_target_occurrences':sum(len(i['bad']) for i in issues),'unlabeled_inputs':sum(i['unlabeledInputs'] for i in issues),'empty_buttons':sum(i['emptyButtons'] for i in issues)},ensure_ascii=False))
