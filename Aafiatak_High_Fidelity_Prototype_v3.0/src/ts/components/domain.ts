
namespace AAF {
  export function doctorCard(name=doctor.name, specialty=doctor.specialty, amount='15,000 ر.ي', nav='PAT-03'):string {
    const navAttr = nav ? `data-nav="${nav}"` : '';
    return `<article class="surface doctor-card elevated" ${navAttr}><div class="avatar">${doctor.initials}</div><div><div class="name">${name}</div><div class="meta">${specialty}</div></div><div class="price">${amount}<span>سعر الخدمة</span></div></article>`;
  }

  export function serviceCard(name:string, amount:string, policy:string, nav='PAT-04'):string {
    const navAttr = nav ? `data-nav="${nav}"` : '';
    return `<article class="surface service-card" ${navAttr}><div>${badge('خدمة','secondary')}</div><div class="title">${name}</div><div class="price">${amount}</div><div class="body-sm text-secondary">${policy}</div></article>`;
  }

  export function appointmentSummary(tone='primary'):string {
    return `<section class="surface pad elevated section-stack">${badge(appointment.service,tone)}<div><div class="h3">${appointment.doctor}</div><div class="body-sm text-secondary">${appointment.facility} · ${appointment.branch}</div></div>${infoRows([
      {key:'اليوم',value:appointment.date},
      {key:'نافذة الوصول',value:appointment.arrivalWindow,dir:'ltr'}
    ])}</section>`;
  }

  export function facilitySummary():string {
    return `<section class="surface pad section-stack"><div>${badge(facility.branch,'info')}</div><div><div class="h3">${facility.name}</div><div class="body-sm text-secondary">${facility.city} · ${facility.address}</div></div><div class="list-row" data-nav="PAT-05" style="padding:12px;border:none;background:var(--color-surface-low)"><div><div class="title">عرض تفاصيل المنشأة</div><div class="subtitle">الموقع، التواصل وساعات العمل</div></div><div class="chevron">${icon('chevron')}</div></div></section>`;
  }

  export function holdBanner(label='تم حجز السعة لك مؤقتًا', countdown='[ديناميكي]'):string {
    return `<div class="hold-banner"><div><div class="title">${label}</div><div class="copy">أكمل الخطوة التالية قبل انتهاء الحجز المؤقت.</div></div><div class="countdown">${countdown}</div></div>`;
  }

  export function paymentStatus(tone:string,title:string,copy:string,tag:string):string {
    return statusBlock(tone, tone==='success'?'check':tone==='error'?'close':tone==='warning'?'warning':'clock', title, copy, tag);
  }

  export function bottomNav(active:'home'|'appointments'|'profile'):string {
    const item=(id:string,label:string,ico:string,nav:string)=>`<button class="nav-item ${active===id?'active':''}" data-nav="${nav}"><span class="nav-icon">${icon(ico)}</span><span>${label}</span></button>`;
    return `<nav class="bottom-nav" aria-label="التنقل الرئيسي">${item('home','الرئيسية','home','PAT-01')}${item('appointments','مواعيدي','calendar','PAT-11')}${item('profile','حسابي','user','PAT-16')}</nav>`;
  }

  export function rootAppBar(titleBrand=true, title=''):string {
    if(titleBrand) return `<header class="appbar root"><div class="brand-row"><div class="brand-mark"></div><div class="brand-name">عافيتك</div></div><button class="icon-button" aria-label="الإشعارات" data-nav="PAT-15">${icon('bell')}</button></header>`;
    return `<header class="appbar root"><div class="title">${title}</div><button class="icon-button" aria-label="الإشعارات" data-nav="PAT-15">${icon('bell')}</button></header>`;
  }

  export function detailAppBar(screenId:string,title:string):string {
    return `<header class="appbar"><button class="icon-button" aria-label="رجوع" data-nav="back">${icon('back')}</button><div class="title-center"><div class="kicker">${screenId}</div><div class="title">${title}</div></div><div style="width:48px;height:48px"></div></header>`;
  }

  export function shell(opts:{screenId:string;title:string;body:string;root?:boolean;active?:'home'|'appointments'|'profile';bottomAction?:string;brandHeader?:boolean}):string {
    const root = !!opts.root;
    const cls = ['phone',opts.active?'with-bottom-nav':'',opts.bottomAction?'with-bottom-action':''].filter(Boolean).join(' ');
    const header = root ? rootAppBar(opts.brandHeader!==false,opts.title) : detailAppBar(opts.screenId,opts.title);
    return `<div class="${cls}">${header}<main class="screen">${opts.body}</main>${opts.active?bottomNav(opts.active):''}${opts.bottomAction?`<div class="bottom-action">${opts.bottomAction}</div>`:''}</div>`;
  }
}
