
namespace AAF {
  export function badge(label:string, tone='neutral'):string {
    return `<span class="badge ${tone}">${label}</span>`;
  }

  export function button(label:string, variant='primary', opts:{block?:boolean;compact?:boolean;disabled?:boolean;icon?:string;nav?:string}={}):string {
    const cls = ['button',variant,opts.block?'block':'',opts.compact?'compact':''].filter(Boolean).join(' ');
    const nav = opts.nav ? `data-nav="${opts.nav}"` : '';
    return `<button class="${cls}" ${nav} ${opts.disabled?'disabled':''}>${opts.icon?icon(opts.icon):''}<span>${label}</span></button>`;
  }

  export function searchField(value='', placeholder='ابحث عن طبيب أو تخصص أو قسم أو خدمة', nav=''):string {
    const navAttr = nav ? `data-nav="${nav}"` : '';
    return `<label class="search-field" ${navAttr}>${icon('search')}<input aria-label="البحث" value="${escapeHtml(value)}" placeholder="${escapeHtml(placeholder)}"></label>`;
  }

  export function inputField(label:string, value:string, helper='', state:'default'|'error'='default', type='text'):string {
    return `<label class="input-group"><span class="input-label">${label}</span><span class="input-shell ${state==='error'?'error':''}"><input type="${type}" value="${escapeHtml(value)}" aria-label="${escapeHtml(label)}"></span>${helper?`<span class="input-helper ${state==='error'?'input-error':''}">${helper}</span>`:''}</label>`;
  }

  export function chips(items:{label:string;active?:boolean}[]):string {
    return `<div class="chips">${items.map(i=>`<button class="chip ${i.active?'active':''}" data-toggle="chip">${i.label}</button>`).join('')}</div>`;
  }

  export function segmented(items:{label:string;active?:boolean;nav?:string}[]):string {
    return `<div class="segmented" role="tablist">${items.map(i=>`<button class="segment-button ${i.active?'active':''}" role="tab" aria-selected="${i.active?'true':'false'}" ${i.nav?`data-nav="${i.nav}"`:'data-toggle="segment"'}>${i.label}</button>`).join('')}</div>`;
  }

  export function statusBlock(tone:string, iconName:string, title:string, copy:string, tag?:string):string {
    return `<section class="surface status-block"><div class="status-head"><div class="status-icon ${tone}">${icon(iconName)}</div><div>${tag?badge(tag,tone):''}<div class="status-title" style="${tag?'margin-top:8px':''}">${title}</div><div class="status-copy">${copy}</div></div></div></section>`;
  }

  export function notice(text:string, tone='info'):string {
    return `<div class="notice ${tone}">${text}</div>`;
  }

  export function infoRows(rows:{key:string;value:string;dir?:'ltr'|'rtl'}[]):string {
    return `<div class="info-list">${rows.map(r=>`<div class="info-row"><div class="key">${r.key}</div><div class="value ${r.dir==='ltr'?'ltr':''}">${r.value}</div></div>`).join('')}</div>`;
  }

  export function sectionHeading(label:string, meta=''):string {
    return `<div class="section-heading"><div class="label">${label}</div>${meta?`<div class="meta">${meta}</div>`:''}</div>`;
  }

  export function skeleton(lines:{h:number;w?:string}[]):string {
    return `<div class="loading-stack">${lines.map(x=>`<div class="skeleton" style="height:${x.h}px;width:${x.w||'100%'}"></div>`).join('')}</div>`;
  }

  export function emptyState(title:string, copy:string, action?:string, actionNav?:string):string {
    return `<section class="surface empty-state"><div class="status-icon info">${icon('info')}</div><div class="title">${title}</div><div class="copy">${copy}</div>${action?button(action,'tonal',{nav:actionNav}):''}</section>`;
  }

  export function escapeHtml(s:string):string {
    return s.replace(/[&<>"']/g, c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[c] as string));
  }
}
