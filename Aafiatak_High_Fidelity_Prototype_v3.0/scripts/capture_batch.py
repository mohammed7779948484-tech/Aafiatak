#!/usr/bin/env python3
from pathlib import Path
import re, json, sys
from playwright.sync_api import sync_playwright
from PIL import Image, ImageDraw, ImageFont

ROOT=Path(__file__).resolve().parents[1]
CSS='\n'.join((ROOT/p).read_text(encoding='utf-8') for p in ['src/css/tokens.css','src/css/base.css','src/css/components.css','src/css/screens.css'])
JS=(ROOT/'dist/app.js').read_text(encoding='utf-8')
MASTER=ROOT/'screenshots/master'; PREVIEW=ROOT/'screenshots/preview'; CONTACT=ROOT/'contact_sheets'; REVIEW=ROOT/'docs/reviews'
for d in (MASTER,PREVIEW,CONTACT,REVIEW): d.mkdir(parents=True,exist_ok=True)

def parse_manifest():
    out=[]
    for p in sorted((ROOT/'src/ts/screens').glob('PAT*.ts')):
        t=p.read_text(encoding='utf-8')
        mid=re.search(r"id:'(PAT-\d+)'",t)
        title=re.search(r"title:'([^']+)'",t)
        default=re.search(r"defaultState:'([^']+)'",t)
        states=re.search(r"states:\[([^\]]+)\]",t,re.S)
        if not (mid and default and states):
            print('PARSE FAIL',p)
            continue
        st=re.findall(r"'([^']+)'",states.group(1))
        out.append({'id':mid.group(1),'title':title.group(1) if title else '', 'default':default.group(1),'states':st})
    return out

def html_for(screen,state):
    return ('<!doctype html><html lang="ar" dir="rtl"><head><meta charset="UTF-8">'
            '<meta name="viewport" content="width=device-width,initial-scale=1">'
            '<style>'+CSS+'</style></head><body><div id="app"></div>'
            '<script>window.__AAF_SCREEN__='+repr(screen)+';window.__AAF_STATE__='+repr(state)+';</script>'
            '<script>'+JS+'</script></body></html>')

def contact_sheet(paths,out_path,title,cols=3):
    tiles=[]
    for p in paths:
        img=Image.open(p).convert('RGB')
        img.thumbnail((250,640))
        tile=Image.new('RGB',(280,710),'#F7F3EE')
        draw=ImageDraw.Draw(tile)
        # label header
        draw.rounded_rectangle((10,10,270,38),12,fill='#FFFDF9',outline='#D8D0C8',width=1)
        draw.text((18,18),p.stem,fill='#25232B')
        x=(280-img.width)//2; y=52
        tile.paste(img,(x,y))
        tiles.append(tile)
    rows=(len(tiles)+cols-1)//cols
    top=56
    sheet=Image.new('RGB',(cols*280+(cols+1)*16,rows*710+(rows+1)*16+top),'#EEE8E1')
    d=ImageDraw.Draw(sheet)
    d.rounded_rectangle((16,14,sheet.width-16,46),14,fill='#FFFDF9',outline='#D8D0C8',width=1)
    d.text((28,24),title,fill='#4A315D')
    for i,tile in enumerate(tiles):
        r,c=divmod(i,cols)
        sheet.paste(tile,(16+c*(280+16),top+16+r*(710+16)))
    sheet.save(out_path)

def main():
    manifest=parse_manifest()
    (REVIEW/'screen_state_manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2),encoding='utf-8')
    reports=[]
    with sync_playwright() as pw:
        browser=pw.chromium.launch(headless=True,executable_path='/usr/bin/chromium',args=['--no-sandbox','--disable-dev-shm-usage','--disable-gpu','--disable-background-networking','--disable-extensions'])
        for rec in manifest:
            for state in rec['states']:
                page=browser.new_page(viewport={'width':390,'height':844},device_scale_factor=4)
                errors=[]; page.on('pageerror',lambda e: errors.append(str(e)))
                page.set_content(html_for(rec['id'],state),wait_until='load')
                page.wait_for_timeout(80)
                metrics=page.locator('body').evaluate('(e)=>({w:e.scrollWidth,h:e.scrollHeight,cw:e.clientWidth})')
                name=f"{rec['id']}-{state}-phone.png"
                page.screenshot(path=str(MASTER/name),full_page=True,scale='device')
                page.screenshot(path=str(PREVIEW/name),full_page=True,scale='css')
                reports.append({'screen':rec['id'],'state':state,'file':name,'width':metrics['w'],'height':metrics['h'],'overflow':metrics['w']>metrics['cw'],'errors':errors})
                page.close()
        browser.close()
    (REVIEW/'batch_capture_report.json').write_text(json.dumps(reports,ensure_ascii=False,indent=2),encoding='utf-8')

    # defaults overview contact sheets, 7 screens each
    default_paths=[PREVIEW/f"{r['id']}-{r['default']}-phone.png" for r in manifest]
    for i in range(0,len(default_paths),7):
        contact_sheet(default_paths[i:i+7],CONTACT/f'defaults_{i//7+1}.png',f'Aafiatak High-Fidelity Defaults {i+1}-{min(i+7,len(default_paths))}',cols=2)
    # per-screen states contact sheets
    for rec in manifest:
        paths=[PREVIEW/f"{rec['id']}-{s}-phone.png" for s in rec['states']]
        contact_sheet(paths,CONTACT/f"{rec['id']}_states.png",f"{rec['id']} — {rec['title']} — states",cols=3 if len(paths)>4 else 2)

    summary={
      'screens':len(manifest),'captures':len(reports),
      'overflow_count':sum(1 for r in reports if r['overflow']),
      'runtime_error_count':sum(1 for r in reports if r['errors']),
      'missing_png':sum(1 for r in reports if not (PREVIEW/r['file']).exists())
    }
    (REVIEW/'batch_capture_summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf-8')
    print(json.dumps(summary,ensure_ascii=False))

if __name__=='__main__': main()
