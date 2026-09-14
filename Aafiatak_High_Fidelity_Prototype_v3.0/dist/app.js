var AAF;
(function (AAF) {
    AAF.registry = {};
    function register(screen) { AAF.registry[screen.id] = screen; }
    AAF.register = register;
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    const paths = {
        bell: '<path d="M18 8a6 6 0 0 0-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9"/><path d="M10 21h4"/>',
        search: '<circle cx="11" cy="11" r="7"/><path d="m20 20-4-4"/>',
        doctor: '<circle cx="12" cy="8" r="3"/><path d="M5 20c.8-4.2 3.2-6 7-6s6.2 1.8 7 6"/>',
        service: '<path d="M12 4v16M4 12h16"/><circle cx="12" cy="12" r="9"/>',
        place: '<path d="M20 10c0 5-8 11-8 11S4 15 4 10a8 8 0 1 1 16 0Z"/><circle cx="12" cy="10" r="2.5"/>',
        arrow: '<path d="M5 12h14M13 6l6 6-6 6"/>',
        chevron: '<path d="m9 18 6-6-6-6"/>',
        back: '<path d="M19 12H5"/><path d="m11 18-6-6 6-6"/>',
        home: '<path d="M3 11 12 4l9 7v9h-6v-6H9v6H3z"/>',
        calendar: '<rect x="3" y="5" width="18" height="16" rx="3"/><path d="M8 3v4M16 3v4M3 10h18"/>',
        user: '<circle cx="12" cy="8" r="4"/><path d="M4 21c1-5 4-7 8-7s7 2 8 7"/>',
        check: '<path d="M20 6 9 17l-5-5"/>',
        clock: '<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
        warning: '<path d="M12 3 2 21h20L12 3Z"/><path d="M12 9v5"/><path d="M12 17h.01"/>',
        close: '<path d="M18 6 6 18M6 6l12 12"/>',
        qr: '<rect x="4" y="4" width="6" height="6"/><rect x="14" y="4" width="6" height="6"/><rect x="4" y="14" width="6" height="6"/><path d="M14 14h2v2h-2zM18 14h2v6h-6v-2h4z"/>',
        card: '<rect x="3" y="6" width="18" height="12" rx="3"/><path d="M3 10h18"/>',
        queue: '<path d="M6 7h12M6 12h10M6 17h8"/>',
        phone: '<path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1A19.3 19.3 0 0 1 5.2 13 19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1 1 .4 2 .7 2.9a2 2 0 0 1-.5 2.1L8 10a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5c.9.3 1.9.6 2.9.7A2 2 0 0 1 22 16.9Z"/>',
        info: '<circle cx="12" cy="12" r="9"/><path d="M12 11v5"/><path d="M12 8h.01"/>',
        edit: '<path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L8 18l-4 1 1-4Z"/>',
        logout: '<path d="M10 17l5-5-5-5"/><path d="M15 12H3"/><path d="M21 19V5a2 2 0 0 0-2-2h-6"/>',
        refresh: '<path d="M20 11a8 8 0 1 0 2 5"/><path d="M20 4v7h-7"/>',
        building: '<path d="M4 21V3h12v18M16 8h4v13M8 7h4M8 11h4M8 15h4M2 21h20"/>',
        money: '<circle cx="12" cy="12" r="9"/><path d="M16 8.5c-.7-.8-1.8-1.2-3-1.2-1.7 0-3 .8-3 2s1 1.8 3 2.2 3 1 3 2.3-1.3 2.2-3 2.2c-1.3 0-2.5-.5-3.2-1.3M13 5.8v12.4"/>',
        location: '<path d="M20 10c0 5-8 11-8 11S4 15 4 10a8 8 0 1 1 16 0Z"/><circle cx="12" cy="10" r="2.5"/>',
        shield: '<path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10Z"/><path d="m9 12 2 2 4-4"/>',
        whats: '<path d="M20 11.5A8.5 8.5 0 0 1 7 18.7L3 20l1.3-3.9A8.5 8.5 0 1 1 20 11.5Z"/><path d="M9 8.8c.3-.8.6-.8.8-.8h.7c.2 0 .4 0 .6.5.2.5.7 1.6.8 1.7.1.1.1.3 0 .5-.1.2-.2.3-.4.5-.2.2-.3.3-.1.7.2.3.8 1.2 1.8 1.9 1.2.9 2.1 1.1 2.5 1.3.4.2.6.1.8-.1.2-.2.7-.8.9-1 .2-.3.4-.2.6-.1.3.1 1.7.8 2 .9.3.2.5.3.6.5.1.2.1 1.1-.3 2.1"/>'
    };
    function icon(name, cls = '') {
        const directional = ['arrow', 'chevron', 'back'].includes(name) ? 'rtl-mirror' : '';
        const classes = [directional, cls].filter(Boolean).join(' ');
        return `<svg class="${classes}" viewBox="0 0 24 24" aria-hidden="true">${paths[name] || paths.info}</svg>`;
    }
    AAF.icon = icon;
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    AAF.doctor = {
        id: 'doc-001', initials: 'س.ع', name: 'د. سارة عبدالله', specialty: 'طب الأسرة',
        department: 'الرعاية الأولية', qualification: 'زمالة في طب الأسرة',
        biography: 'تهتم بتقديم رعاية واضحة ومتكاملة للبالغين، مع التركيز على الوقاية والمتابعة وتفسير الخطة للمريض بلغة بسيطة.',
        facility: 'مركز عافيتك التخصصي', branch: 'فرع التحرير',
        services: [
            { name: 'استشارة طب الأسرة', amount: '15,000 ر.ي', policy: 'الدفع الكامل إلكترونيًا' },
            { name: 'متابعة طبية', amount: '12,000 ر.ي', policy: 'الدفع في المنشأة' }
        ],
        workingDays: 'الأحد – الخميس', workingHours: '9:00 ص – 4:00 م'
    };
    AAF.appointment = {
        doctor: 'د. سارة عبدالله', service: 'استشارة طب الأسرة',
        facility: 'مركز عافيتك التخصصي', branch: 'فرع التحرير',
        date: 'الأربعاء 18 سبتمبر 2026', arrivalWindow: '10:00 – 10:30',
        amount: '15,000 ر.ي', currency: 'YER', bookingNumber: 'AF-28931',
        paymentReference: 'PAY-2026-1847'
    };
    AAF.facility = {
        name: 'مركز عافيتك التخصصي', branch: 'فرع التحرير',
        city: 'صنعاء', region: 'أمانة العاصمة',
        address: 'شارع التحرير، بجوار الساحة العامة',
        phone: '+967 ••• ••• •••',
        hours: 'الأحد – الخميس · 8:00 ص – 5:00 م'
    };
    AAF.notifications = [
        { kind: 'queue', title: 'تم النداء عليك', message: 'يرجى التوجه إلى غرفة الخدمة عند توجيه موظف الاستقبال.', time: 'اليوم · 12:04 م', unread: true },
        { kind: 'appointment', title: 'تم تأكيد موعدك', message: 'موعدك مع د. سارة عبدالله مؤكد. نافذة الوصول 10:00 ص – 10:30 ص.', time: 'أمس · 7:32 م', unread: true },
        { kind: 'payment', title: 'تمت معالجة الدفع', message: 'تم التحقق من الدفع لموعد استشارة طب الأسرة.', time: 'أمس · 7:31 م', unread: false }
    ];
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function badge(label, tone = 'neutral') {
        return `<span class="badge ${tone}">${label}</span>`;
    }
    AAF.badge = badge;
    function button(label, variant = 'primary', opts = {}) {
        const cls = ['button', variant, opts.block ? 'block' : '', opts.compact ? 'compact' : ''].filter(Boolean).join(' ');
        const nav = opts.nav ? `data-nav="${opts.nav}"` : '';
        return `<button class="${cls}" ${nav} ${opts.disabled ? 'disabled' : ''}>${opts.icon ? AAF.icon(opts.icon) : ''}<span>${label}</span></button>`;
    }
    AAF.button = button;
    function searchField(value = '', placeholder = 'ابحث عن طبيب أو تخصص أو قسم أو خدمة', nav = '') {
        const navAttr = nav ? `data-nav="${nav}"` : '';
        return `<label class="search-field" ${navAttr}>${AAF.icon('search')}<input aria-label="البحث" value="${escapeHtml(value)}" placeholder="${escapeHtml(placeholder)}"></label>`;
    }
    AAF.searchField = searchField;
    function inputField(label, value, helper = '', state = 'default', type = 'text') {
        return `<label class="input-group"><span class="input-label">${label}</span><span class="input-shell ${state === 'error' ? 'error' : ''}"><input type="${type}" value="${escapeHtml(value)}" aria-label="${escapeHtml(label)}"></span>${helper ? `<span class="input-helper ${state === 'error' ? 'input-error' : ''}">${helper}</span>` : ''}</label>`;
    }
    AAF.inputField = inputField;
    function chips(items) {
        return `<div class="chips">${items.map(i => `<button class="chip ${i.active ? 'active' : ''}" data-toggle="chip">${i.label}</button>`).join('')}</div>`;
    }
    AAF.chips = chips;
    function segmented(items) {
        return `<div class="segmented" role="tablist">${items.map(i => `<button class="segment-button ${i.active ? 'active' : ''}" role="tab" aria-selected="${i.active ? 'true' : 'false'}" ${i.nav ? `data-nav="${i.nav}"` : 'data-toggle="segment"'}>${i.label}</button>`).join('')}</div>`;
    }
    AAF.segmented = segmented;
    function statusBlock(tone, iconName, title, copy, tag) {
        return `<section class="surface status-block"><div class="status-head"><div class="status-icon ${tone}">${AAF.icon(iconName)}</div><div>${tag ? badge(tag, tone) : ''}<div class="status-title" style="${tag ? 'margin-top:8px' : ''}">${title}</div><div class="status-copy">${copy}</div></div></div></section>`;
    }
    AAF.statusBlock = statusBlock;
    function notice(text, tone = 'info') {
        return `<div class="notice ${tone}">${text}</div>`;
    }
    AAF.notice = notice;
    function infoRows(rows) {
        return `<div class="info-list">${rows.map(r => `<div class="info-row"><div class="key">${r.key}</div><div class="value ${r.dir === 'ltr' ? 'ltr' : ''}">${r.value}</div></div>`).join('')}</div>`;
    }
    AAF.infoRows = infoRows;
    function sectionHeading(label, meta = '') {
        return `<div class="section-heading"><div class="label">${label}</div>${meta ? `<div class="meta">${meta}</div>` : ''}</div>`;
    }
    AAF.sectionHeading = sectionHeading;
    function skeleton(lines) {
        return `<div class="loading-stack">${lines.map(x => `<div class="skeleton" style="height:${x.h}px;width:${x.w || '100%'}"></div>`).join('')}</div>`;
    }
    AAF.skeleton = skeleton;
    function emptyState(title, copy, action, actionNav) {
        return `<section class="surface empty-state"><div class="status-icon info">${AAF.icon('info')}</div><div class="title">${title}</div><div class="copy">${copy}</div>${action ? button(action, 'tonal', { nav: actionNav }) : ''}</section>`;
    }
    AAF.emptyState = emptyState;
    function escapeHtml(s) {
        return s.replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }[c]));
    }
    AAF.escapeHtml = escapeHtml;
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function doctorCard(name = AAF.doctor.name, specialty = AAF.doctor.specialty, amount = '15,000 ر.ي', nav = 'PAT-03') {
        const navAttr = nav ? `data-nav="${nav}"` : '';
        return `<article class="surface doctor-card elevated" ${navAttr}><div class="avatar">${AAF.doctor.initials}</div><div><div class="name">${name}</div><div class="meta">${specialty}</div></div><div class="price">${amount}<span>سعر الخدمة</span></div></article>`;
    }
    AAF.doctorCard = doctorCard;
    function serviceCard(name, amount, policy, nav = 'PAT-04') {
        const navAttr = nav ? `data-nav="${nav}"` : '';
        return `<article class="surface service-card" ${navAttr}><div>${AAF.badge('خدمة', 'secondary')}</div><div class="title">${name}</div><div class="price">${amount}</div><div class="body-sm text-secondary">${policy}</div></article>`;
    }
    AAF.serviceCard = serviceCard;
    function appointmentSummary(tone = 'primary') {
        return `<section class="surface pad elevated section-stack">${AAF.badge(AAF.appointment.service, tone)}<div><div class="h3">${AAF.appointment.doctor}</div><div class="body-sm text-secondary">${AAF.appointment.facility} · ${AAF.appointment.branch}</div></div>${AAF.infoRows([
            { key: 'اليوم', value: AAF.appointment.date },
            { key: 'نافذة الوصول', value: AAF.appointment.arrivalWindow, dir: 'ltr' }
        ])}</section>`;
    }
    AAF.appointmentSummary = appointmentSummary;
    function facilitySummary() {
        return `<section class="surface pad section-stack"><div>${AAF.badge(AAF.facility.branch, 'info')}</div><div><div class="h3">${AAF.facility.name}</div><div class="body-sm text-secondary">${AAF.facility.city} · ${AAF.facility.address}</div></div><div class="list-row" data-nav="PAT-05" style="padding:12px;border:none;background:var(--color-surface-low)"><div><div class="title">عرض تفاصيل المنشأة</div><div class="subtitle">الموقع، التواصل وساعات العمل</div></div><div class="chevron">${AAF.icon('chevron')}</div></div></section>`;
    }
    AAF.facilitySummary = facilitySummary;
    function holdBanner(label = 'تم حجز السعة لك مؤقتًا', countdown = '[ديناميكي]') {
        return `<div class="hold-banner"><div><div class="title">${label}</div><div class="copy">أكمل الخطوة التالية قبل انتهاء الحجز المؤقت.</div></div><div class="countdown">${countdown}</div></div>`;
    }
    AAF.holdBanner = holdBanner;
    function paymentStatus(tone, title, copy, tag) {
        return AAF.statusBlock(tone, tone === 'success' ? 'check' : tone === 'error' ? 'close' : tone === 'warning' ? 'warning' : 'clock', title, copy, tag);
    }
    AAF.paymentStatus = paymentStatus;
    function bottomNav(active) {
        const item = (id, label, ico, nav) => `<button class="nav-item ${active === id ? 'active' : ''}" data-nav="${nav}"><span class="nav-icon">${AAF.icon(ico)}</span><span>${label}</span></button>`;
        return `<nav class="bottom-nav" aria-label="التنقل الرئيسي">${item('home', 'الرئيسية', 'home', 'PAT-01')}${item('appointments', 'مواعيدي', 'calendar', 'PAT-11')}${item('profile', 'حسابي', 'user', 'PAT-16')}</nav>`;
    }
    AAF.bottomNav = bottomNav;
    function rootAppBar(titleBrand = true, title = '') {
        if (titleBrand)
            return `<header class="appbar root"><div class="brand-row"><div class="brand-mark"></div><div class="brand-name">عافيتك</div></div><button class="icon-button" aria-label="الإشعارات" data-nav="PAT-15">${AAF.icon('bell')}</button></header>`;
        return `<header class="appbar root"><div class="title">${title}</div><button class="icon-button" aria-label="الإشعارات" data-nav="PAT-15">${AAF.icon('bell')}</button></header>`;
    }
    AAF.rootAppBar = rootAppBar;
    function detailAppBar(screenId, title) {
        return `<header class="appbar"><button class="icon-button" aria-label="رجوع" data-nav="back">${AAF.icon('back')}</button><div class="title-center"><div class="kicker">${screenId}</div><div class="title">${title}</div></div><div style="width:48px;height:48px"></div></header>`;
    }
    AAF.detailAppBar = detailAppBar;
    function shell(opts) {
        const root = !!opts.root;
        const cls = ['phone', opts.active ? 'with-bottom-nav' : '', opts.bottomAction ? 'with-bottom-action' : ''].filter(Boolean).join(' ');
        const header = root ? rootAppBar(opts.brandHeader !== false, opts.title) : detailAppBar(opts.screenId, opts.title);
        return `<div class="${cls}">${header}<main class="screen">${opts.body}</main>${opts.active ? bottomNav(opts.active) : ''}${opts.bottomAction ? `<div class="bottom-action">${opts.bottomAction}</div>` : ''}</div>`;
    }
    AAF.shell = shell;
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT01Body(state) {
        if (state === 'loading') {
            return `<div class="screen-stack">
        ${AAF.skeleton([{ h: 26, w: '32%' }, { h: 78, w: '88%' }, { h: 58 }, { h: 94 }, { h: 196 }, { h: 84 }, { h: 84 }])}
      </div>`;
        }
        if (state === 'empty-discovery') {
            return `<div class="screen-stack">
        <section class="home-hero">
          <div class="eyebrow">الرعاية أقرب مما تتوقع</div>
          <h1 class="display">ابدأ رحلتك الصحية <em>بوضوح وطمأنينة.</em></h1>
          <div class="copy">ابحث عن طبيب أو تخصص أو قسم أو خدمة، ثم اطّلع على التوفر قبل بدء الحجز.</div>
        </section>
        ${AAF.searchField('', undefined, 'PAT-02:results')}
        ${AAF.button('احجز موعدًا', 'primary', { block: true, nav: 'PAT-06' })}
        ${AAF.emptyState('لا يوجد محتوى استكشاف متاح الآن', 'يمكنك البحث مباشرة، أو المحاولة مرة أخرى عندما تتوفر بيانات الاستكشاف.', 'إعادة المحاولة', 'PAT-01')}
      </div>`;
        }
        const offline = state === 'offline' ? AAF.notice('أنت غير متصل الآن. يمكنك تصفح آخر بيانات محفوظة، وسنحدّث التوفر عند عودة الاتصال.', 'info') : state === 'error' ? AAF.notice('تعذر تحديث محتوى الاستكشاف الآن. يمكنك البحث مباشرة أو إعادة المحاولة.', 'error') : '';
        const upcoming = state === 'guest-populated' ? '' : `<section class="section-stack">
      ${AAF.sectionHeading('موعدك القادم', 'يتطلب تسجيل الدخول')}
      <section class="surface pad elevated section-stack">
        <div>${AAF.badge('موعد قادم', 'secondary')}</div>
        <div>
          <div class="h3">${AAF.appointment.doctor}</div>
          <div class="body-sm text-secondary">${AAF.appointment.service}</div>
        </div>
        ${AAF.infoRows([
            { key: 'التاريخ', value: AAF.appointment.date },
            { key: 'نافذة الوصول', value: AAF.appointment.arrivalWindow, dir: 'ltr' }
        ])}
        ${AAF.button('عرض تفاصيل الموعد', 'text', { block: true, nav: 'PAT-12' })}
      </section>
    </section>`;
        return `<div class="home-discovery">
      <section class="home-hero">
        <div class="eyebrow">الرعاية أقرب مما تتوقع</div>
        <h1 class="display">ابدأ رحلتك الصحية <em>بوضوح وطمأنينة.</em></h1>
        <div class="copy">ابحث عن طبيب أو تخصص أو قسم أو خدمة، ثم اطّلع على التوفر وأكمل الحجز بخطوات واضحة.</div>
      </section>

      ${offline}
      ${AAF.searchField('', undefined, 'PAT-02:results')}
      ${AAF.button('احجز موعدًا', 'primary', { block: true, nav: 'PAT-06' })}

      <div class="quick-actions" aria-label="اختصارات الاستكشاف">
        <button class="quick-action" data-nav="PAT-02:results"><span class="icon-wrap">${AAF.icon('doctor')}</span><span class="label">الأطباء</span></button>
        <button class="quick-action" data-nav="PAT-04"><span class="icon-wrap">${AAF.icon('service')}</span><span class="label">الخدمات</span></button>
        <button class="quick-action" data-nav="PAT-05"><span class="icon-wrap">${AAF.icon('place')}</span><span class="label">المنشآت</span></button>
      </div>

      ${upcoming}

      <section class="feature-panel care-window">
        ${AAF.badge('نافذة وصول واضحة', 'hold')}
        <div class="title">اعرف التوفر قبل أن تبدأ الحجز</div>
        <div class="copy">اختر الخدمة واليوم، وسيعرض النظام نافذة الوصول المتاحة دون أن يوهمك بوقت دخول مضمون للطبيب.</div>
        ${AAF.button('استكشف التوفر', 'secondary', { icon: 'arrow', nav: 'PAT-06' })}
      </section>

      <section class="section-stack">
        ${AAF.sectionHeading('اكتشف الأطباء', '')}
        ${AAF.doctorCard()}
        ${AAF.doctorCard('د. محمد حسن', 'الطب العام', '12,000 ر.ي')}
      </section>

      <section class="section-stack">
        ${AAF.sectionHeading('خدمات شائعة', 'اختيار سريع')}
        ${AAF.serviceCard('استشارة طب الأسرة', '15,000 ر.ي', 'الدفع الكامل إلكترونيًا')}
        ${AAF.serviceCard('متابعة طبية', '12,000 ر.ي', 'الدفع في المنشأة')}
      </section>
    </div>`;
    }
    AAF.register({
        id: 'PAT-01',
        title: 'الرئيسية / اكتشف',
        defaultState: 'patient-populated',
        states: ['guest-populated', 'patient-populated', 'loading', 'empty-discovery', 'offline', 'error'],
        render: (state) => AAF.shell({
            screenId: 'PAT-01',
            title: 'الرئيسية',
            root: true,
            active: 'home',
            brandHeader: true,
            body: PAT01Body(state)
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT02Results() {
        const row = (tone, type, title, sub, nav) => `<article class="list-row interactive" data-nav="${nav}">
      <div><div>${AAF.badge(type, tone)}</div><div style="margin-top:8px" class="title">${title}</div><div class="subtitle">${sub}</div></div>
      <div class="chevron">${AAF.icon('chevron')}</div>
    </article>`;
        return `<div class="list">
      ${row('secondary', 'طبيب', 'د. سارة عبدالله', 'طب الأسرة · مركز عافيتك التخصصي', 'PAT-03')}
      ${row('primary', 'خدمة', 'استشارة طب الأسرة', '15,000 ر.ي · الدفع الكامل إلكترونيًا', 'PAT-04')}
      ${row('info', 'منشأة', 'مركز عافيتك التخصصي · فرع التحرير', 'صنعاء · شارع التحرير', 'PAT-05')}
    </div>`;
    }
    function PAT02Body(state) {
        if (state === 'searching')
            return `<div class="screen-stack">
      ${AAF.searchField('طب الأسرة')}
      ${AAF.skeleton([{ h: 40, w: '72%' }, { h: 106 }, { h: 106 }, { h: 106 }])}
    </div>`;
        if (state === 'offline' || state === 'error')
            return `<div class="screen-stack">
      ${AAF.searchField('طب الأسرة')}
      ${AAF.notice(state === 'offline' ? 'تعذر تحديث النتائج لأنك غير متصل. سنُبقي الاستعلام ظاهرًا لتتمكن من المحاولة مجددًا.' : 'تعذر تحميل نتائج البحث. احتفظنا بعبارة البحث ويمكنك إعادة المحاولة.', 'error')}
      ${AAF.button('إعادة المحاولة', 'primary', { block: true, icon: 'refresh', nav: 'PAT-02:results' })}
    </div>`;
        if (state === 'initial')
            return `<div class="screen-stack">
      ${AAF.searchField()}
      <section class="surface empty-state">
        <div class="status-icon primary">${AAF.icon('search')}</div>
        <div class="title">ابحث عن الرعاية المناسبة</div>
        <div class="copy">يمكنك البحث باسم الطبيب أو التخصص أو القسم أو الخدمة.</div>
      </section>
    </div>`;
        if (state === 'no-results')
            return `<div class="screen-stack">
      ${AAF.searchField('طب الأعصاب للأطفال')}
      ${AAF.chips([{ label: 'الكل', active: true }, { label: 'أطباء' }, { label: 'خدمات' }, { label: 'منشآت' }])}
      <section class="surface empty-state">
        <div class="status-icon info">${AAF.icon('search')}</div>
        <div class="title">لا توجد نتائج مطابقة</div>
        <div class="copy">لم نعثر على نتائج لعبارة البحث الحالية. يمكنك تعديلها أو العودة لتصفح الخيارات المتاحة.</div>
        ${AAF.button('مسح البحث', 'tonal', { nav: 'PAT-02:initial' })}
      </section>
    </div>`;
        return `<div class="screen-stack">
      ${AAF.searchField('طب الأسرة')}
      ${AAF.chips([{ label: 'الكل', active: true }, { label: 'أطباء' }, { label: 'خدمات' }, { label: 'منشآت' }])}
      <div class="search-summary"><div class="h3">النتائج</div><div class="caption">3 نتائج</div></div>
      ${PAT02Results()}
    </div>`;
    }
    AAF.register({
        id: 'PAT-02', title: 'البحث والنتائج', defaultState: 'results',
        states: ['initial', 'searching', 'results', 'no-results', 'offline', 'error'],
        render: (state) => AAF.shell({ screenId: 'PAT-02', title: 'البحث والنتائج', body: PAT02Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT03Body(state) {
        if (state === 'loading')
            return AAF.skeleton([{ h: 110 }, { h: 110 }, { h: 92 }, { h: 92 }, { h: 92 }]);
        if (state === 'error')
            return `<div class="screen-stack">
      ${AAF.notice('تعذر تحميل تفاصيل الطبيب الآن. يمكنك إعادة المحاولة دون فقد مسار التصفح.', 'error')}
      ${AAF.button('إعادة المحاولة', 'primary', { block: true, icon: 'refresh', nav: 'PAT-03' })}
    </div>`;
        const inactive = state === 'inactive';
        const noAvailability = state === 'no-bookable-availability';
        return `<div class="screen-stack doctor-hero">
      <section class="doctor-profile">
        <div class="avatar large">${AAF.doctor.initials}</div>
        <div>
          <div class="specialty">${AAF.doctor.specialty}</div>
          <div class="name">${AAF.doctor.name}</div>
          <div class="dept">${AAF.doctor.department}</div>
        </div>
      </section>

      ${inactive ? AAF.notice('هذا الطبيب غير متاح للحجز عبر عافيتك حاليًا. يمكنك الاطلاع على المعلومات العامة والخدمات المرتبطة.', 'warning') : ''}
      ${noAvailability ? AAF.notice('لا توجد سعة قابلة للحجز حاليًا. ستظل معلومات الطبيب متاحة ويمكنك مراجعة التوفر لاحقًا.', 'info') : ''}

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('نبذة مهنية')}
        <div class="body-sm text-secondary">${AAF.doctor.qualification}</div>
        <div class="bio">${AAF.doctor.biography}</div>
      </section>

      <section class="section-stack">
        ${AAF.sectionHeading('المنشأة والفرع')}
        ${AAF.facilitySummary()}
      </section>

      <section class="section-stack">
        ${AAF.sectionHeading('الخدمات', 'في هذا الفرع')}
        ${AAF.doctor.services.map(s => AAF.serviceCard(s.name, s.amount, s.policy)).join('')}
      </section>

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('أيام وساعات العمل', 'معلومات عامة')}
        ${AAF.infoRows([
            { key: 'الأيام', value: AAF.doctor.workingDays },
            { key: 'الساعات', value: AAF.doctor.workingHours, dir: 'ltr' }
        ])}
      </section>
    </div>`;
    }
    AAF.register({
        id: 'PAT-03', title: 'تفاصيل الطبيب', defaultState: 'active',
        states: ['active', 'no-bookable-availability', 'inactive', 'loading', 'error'],
        render: (state) => AAF.shell({
            screenId: 'PAT-03', title: 'تفاصيل الطبيب', body: PAT03Body(state),
            bottomAction: AAF.button(state === 'inactive' ? 'غير متاح للحجز' : 'عرض المواعيد المتاحة', state === 'inactive' ? 'secondary' : 'primary', { disabled: state === 'inactive', icon: state === 'inactive' ? undefined : 'calendar', nav: 'PAT-06' })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT04Body(state) {
        if (state === 'loading')
            return AAF.skeleton([{ h: 86 }, { h: 140 }, { h: 108 }, { h: 108 }, { h: 108 }]);
        if (state === 'error')
            return `<div class="screen-stack">${AAF.notice('تعذر تحميل تفاصيل الخدمة. حاول مرة أخرى.', 'error')}${AAF.button('إعادة المحاولة', 'primary', { block: true, icon: 'refresh', nav: 'PAT-04' })}</div>`;
        const inactive = state === 'inactive';
        const noCapacity = state === 'no-capacity';
        return `<div class="screen-stack service-hero">
      <section class="section-stack">
        <div>${AAF.badge('طب الأسرة', 'secondary')}</div>
        <div class="service-title-row">
          <div>
            <h1 class="h1">استشارة طب الأسرة</h1>
            <div class="body-sm text-secondary">${AAF.doctor.name} · ${AAF.facility.name}</div>
          </div>
        </div>
      </section>

      ${inactive ? AAF.notice('هذه الخدمة غير متاحة للحجز عبر عافيتك حاليًا.', 'warning') : ''}
      ${noCapacity ? AAF.notice('الخدمة فعّالة، لكن لا توجد سعة قابلة للحجز حاليًا. يمكنك مراجعة التوفر لاحقًا.', 'info') : ''}

      <section class="service-price-panel">
        <div class="caption">السعر لهذه الخدمة</div>
        <div class="amount">15,000 ر.ي</div>
        <div>${AAF.badge('الدفع الكامل إلكترونيًا مطلوب', 'warning')}</div>
        <div class="body-sm text-secondary">سياسة الدفع معروضة للمعلومة فقط ولا يمكن للمريض تغييرها.</div>
      </section>

      <section class="surface policy-card">
        <div class="policy-title">${AAF.icon('shield')}<span>الإلغاء والاسترداد</span></div>
        <p>يمكن الإلغاء ضمن الشروط المحفوظة للموعد. إذا كان الإلغاء مؤهلًا للاسترداد فستظهر حالته بشكل مستقل عن حالة الموعد.</p>
      </section>

      <section class="surface policy-card">
        <div class="policy-title">${AAF.icon('warning')}<span>عدم الحضور</span></div>
        <p>تُطبق سياسة عدم الحضور الخاصة بهذه الخدمة إذا انتهت نافذة الوصول دون تسجيل وصول صالح.</p>
      </section>

      <section class="surface policy-card">
        <div class="policy-title">${AAF.icon('clock')}<span>تعليمات الحضور</span></div>
        <ul>
          <li>احضر ضمن نافذة الوصول التي سيعرضها النظام عند اختيار اليوم.</li>
          <li>نافذة الوصول ليست وقت دخول مضمونًا للطبيب.</li>
        </ul>
      </section>

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('مدة الخدمة', 'معلومة تقديرية')}
        <div class="body-lg">30 دقيقة تقريبًا</div>
        <div class="body-sm text-secondary">مدة تقديرية للخدمة وليست وقت دخول مضمونًا.</div>
      </section>

      ${AAF.facilitySummary()}
    </div>`;
    }
    AAF.register({
        id: 'PAT-04', title: 'تفاصيل الخدمة', defaultState: 'active',
        states: ['active', 'no-capacity', 'inactive', 'loading', 'error'],
        render: (state) => AAF.shell({
            screenId: 'PAT-04', title: 'تفاصيل الخدمة', body: PAT04Body(state),
            bottomAction: AAF.button(state === 'inactive' ? 'الخدمة غير متاحة' : 'عرض التوفر', state === 'inactive' ? 'secondary' : 'primary', { disabled: state === 'inactive', icon: state === 'inactive' ? undefined : 'calendar', nav: 'PAT-06' })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT05Body(state) {
        if (state === 'loading')
            return AAF.skeleton([{ h: 82 }, { h: 88 }, { h: 180 }, { h: 96 }, { h: 92 }, { h: 92 }]);
        if (state === 'error')
            return `<div class="screen-stack">${AAF.notice('تعذر تحميل تفاصيل المنشأة الآن. يمكنك إعادة المحاولة.', 'error')}${AAF.button('إعادة المحاولة', 'primary', { block: true, icon: 'refresh', nav: 'PAT-05' })}</div>`;
        const locationUnavailable = state === 'location-unavailable';
        return `<div class="screen-stack">
      <section class="facility-identity">
        <div>${AAF.badge(AAF.facility.branch, 'info')}</div>
        <h1 class="facility-name">${AAF.facility.name}</h1>
        <div class="body-sm text-secondary">${AAF.facility.city} · ${AAF.facility.region}</div>
      </section>

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('العنوان')}
        <div class="body">${AAF.facility.address}</div>
      </section>

      ${locationUnavailable
            ? `<section class="surface empty-state">
            <div class="status-icon info">${AAF.icon('location')}</div>
            <div class="title">تعذر عرض معاينة الموقع</div>
            <div class="copy">العنوان النصي ما زال متاحًا، ويمكن استخدامه حتى يكتمل تكامل خدمة الخرائط.</div>
          </section>`
            : `<section class="surface map-placeholder">
            <div class="map-pin">${AAF.icon('location')}</div>
            <div class="map-label">معاينة موقع المنشأة</div>
          </section>`}

      ${AAF.button('عرض الموقع', 'secondary', { block: true, icon: 'location', nav: 'PAT-05' })}

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('التواصل وساعات العمل')}
        ${AAF.infoRows([
            { key: 'رقم التواصل', value: AAF.facility.phone, dir: 'ltr' },
            { key: 'ساعات العمل', value: AAF.facility.hours }
        ])}
        ${AAF.button('اتصال', 'text', { icon: 'phone' })}
      </section>

      <section class="section-stack">
        ${AAF.sectionHeading('أطباء في هذا الفرع', '')}
        ${AAF.doctorCard()}
      </section>

      <section class="section-stack">
        ${AAF.sectionHeading('خدمات متاحة', '')}
        ${AAF.serviceCard('استشارة طب الأسرة', '15,000 ر.ي', 'الدفع الكامل إلكترونيًا')}
        ${AAF.serviceCard('متابعة طبية', '12,000 ر.ي', 'الدفع في المنشأة')}
      </section>

      ${AAF.notice('المواعيد المعروضة هي السعة المنشورة في عافيتك وليست كامل جدول المنشأة.', 'info')}
    </div>`;
    }
    AAF.register({
        id: 'PAT-05', title: 'تفاصيل المنشأة والفرع', defaultState: 'loaded',
        states: ['loaded', 'location-unavailable', 'loading', 'error'],
        render: (state) => AAF.shell({ screenId: 'PAT-05', title: 'تفاصيل المنشأة والفرع', body: PAT05Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function availabilityDay(dow, num, kind, label) {
        return `<button class="day ${kind}" data-toggle="day"><span class="dow">${dow}</span><span class="num">${num}</span><span class="state">${label}</span></button>`;
    }
    function PAT06Body(state) {
        if (state === 'loading')
            return AAF.skeleton([{ h: 150 }, { h: 132 }, { h: 116 }, { h: 68 }]);
        if (state === 'offline' || state === 'error')
            return `<div class="screen-stack">
      ${AAF.appointmentSummary()}
      ${AAF.notice(state === 'offline' ? 'لا يمكن التحقق من السعة الحالية دون اتصال. لن نعرض سعة قديمة على أنها قابلة للحجز.' : 'تعذر التحقق من التوفر الآن. حاول مرة أخرى.', 'error')}
      ${AAF.button('إعادة المحاولة', 'primary', { block: true, icon: 'refresh', nav: 'PAT-06' })}
    </div>`;
        const noCapacity = ['no-capacity', 'last-seat-held', 'time-cutoff'].includes(state);
        let contextual = '';
        if (state === 'no-capacity')
            contextual = AAF.notice('لا توجد سعة قابلة للحجز لهذا اليوم حاليًا. يمكنك اختيار يوم آخر أو طلب تنبيه عند التوفر.', 'info');
        if (state === 'last-seat-held')
            contextual = AAF.notice('آخر سعة متاحة محمية حاليًا بحجز مؤقت لمستخدم آخر. التنبيه لا يحجز لك مقعدًا أو أولوية.', 'warning');
        if (state === 'time-cutoff')
            contextual = AAF.notice('انتهى وقت إنشاء حجز مؤقت صالح لهذا اليوم، حتى لو ظهرت سعة رقمية متبقية. اختر يومًا آخر.', 'warning');
        if (state === 'stale')
            contextual = AAF.notice('قد تكون بيانات التوفر قديمة. حدّث الحالة قبل المتابعة حتى لا نعتمد على سعة منتهية.', 'warning');
        const selectedKind = noCapacity ? 'disabled' : 'selected';
        return `<div class="screen-stack">
      ${AAF.appointmentSummary()}
      <section class="surface availability-calendar section-stack">
        ${AAF.sectionHeading('اختر اليوم', 'اختيار يوم فقط')}
        <div class="calendar-strip">
          ${availabilityDay('سبت', '14', 'disabled', 'مغلق')}
          ${availabilityDay('أحد', '15', 'available', 'متاح')}
          ${availabilityDay('إثنين', '16', 'available', 'متاح')}
          ${availabilityDay('ثلاثاء', '17', 'warning', 'آخر سعة')}
          ${availabilityDay('أربعاء', '18', selectedKind, noCapacity ? 'غير متاح' : 'محدد')}
          ${availabilityDay('خميس', '19', 'available', 'متاح')}
          ${availabilityDay('جمعة', '20', 'disabled', 'مغلق')}
        </div>
      </section>

      <section class="surface arrival-window">
        <div class="caption">نافذة الوصول التي خصصها النظام</div>
        <div class="time">${noCapacity ? '—' : AAF.appointment.arrivalWindow}</div>
        <div class="body-sm text-secondary">هذه نافذة وصول وليست وقت دخول مضمونًا للطبيب.</div>
      </section>

      ${contextual}

      ${noCapacity ? `<section class="surface pad section-stack">
        ${AAF.sectionHeading('هل تريد معرفة متى تتوفر سعة؟')}
        <div class="body-sm text-secondary">يمكنك الاشتراك في تنبيه. التنبيه لا يحجز مقعدًا ولا يمنح أولوية.</div>
        ${AAF.button('أشعرني عند التوفر', 'tonal', { block: true, icon: 'bell' })}
      </section>` : ''}
    </div>`;
    }
    AAF.register({
        id: 'PAT-06', title: 'التوفر / اختيار اليوم', defaultState: 'bookable',
        states: ['loading', 'bookable', 'no-capacity', 'last-seat-held', 'time-cutoff', 'stale', 'offline', 'error'],
        render: (state) => AAF.shell({
            screenId: 'PAT-06', title: 'اختر اليوم', body: PAT06Body(state),
            bottomAction: AAF.button(['no-capacity', 'last-seat-held', 'time-cutoff', 'offline', 'error'].includes(state) ? 'اختر يومًا آخر' : 'مراجعة الحجز', ['no-capacity', 'last-seat-held', 'time-cutoff', 'offline', 'error'].includes(state) ? 'secondary' : 'primary', { disabled: ['offline', 'error'].includes(state), nav: ['no-capacity', 'last-seat-held', 'time-cutoff', 'offline', 'error'].includes(state) ? 'PAT-06' : 'PAT-07' })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT07Body(state) {
        const holdRemaining = String(window.__AAF_HOLD_REMAINING__ || '—');
        if (state === 'acquiring-hold')
            return `<div class="screen-stack">
      ${AAF.appointmentSummary()}
      ${AAF.skeleton([{ h: 80 }, { h: 116 }])}
      ${AAF.notice('جارٍ التحقق من السعة وإنشاء حجز مؤقت صالح. لا تضغط الإجراء مرة أخرى.', 'info')}
    </div>`;
        if (state === 'capacity-loss' || state === 'hold-expired' || state === 'target-invalid') {
            const title = state === 'hold-expired' ? 'انتهت مدة الحجز المؤقت' : state === 'capacity-loss' ? 'لم تعد السعة متاحة' : 'تغيرت صلاحية وجهة الحجز';
            const copy = state === 'hold-expired'
                ? 'لم يعد المقعد محميًا لك. ارجع إلى التوفر للحصول على أحدث سعة قابلة للحجز.'
                : state === 'capacity-loss'
                    ? 'تم أخذ السعة قبل إتمام الحماية المؤقتة. حدّث التوفر واختر من السعة الحالية.'
                    : 'لم يعد الطبيب أو الخدمة أو اليوم صالحًا لإكمال هذا الحجز. ارجع إلى التوفر لمراجعة الخيارات.';
            return `<div class="screen-stack">
        ${AAF.appointmentSummary()}
        ${AAF.statusBlock('error', 'warning', title, copy)}
        ${AAF.notice('لا توجد حالة موعد مؤكدة ناتجة عن هذا الحجز المؤقت.', 'error')}
      </div>`;
        }
        if (state === 'offline-unknown')
            return `<div class="screen-stack">
      ${AAF.appointmentSummary()}
      ${AAF.statusBlock('warning', 'warning', 'تعذر التحقق من حالة الحجز المؤقت', 'لا نعرف إن كانت الحماية المؤقتة ما زالت فعّالة. لا ننشئ محاولة جديدة قبل إعادة التحقق.')}
      ${AAF.button('إعادة التحقق', 'primary', { block: true, icon: 'refresh', nav: 'PAT-07:active-hold' })}
    </div>`;
        const active = state === 'active-hold';
        return `<div class="screen-stack">
      ${AAF.appointmentSummary()}

      <section class="surface amount-block">
        ${AAF.sectionHeading('الدفع والسياسة', AAF.badge('دفع كامل', 'warning'))}
        <div class="amount big">15,000 ر.ي</div>
        <div class="body-sm text-secondary">سياسة الدفع محددة للخدمة ولا يمكن تغييرها من المريض.</div>
      </section>

      <section class="surface policy-card">
        <div class="policy-title">${AAF.icon('shield')}<span>قبل التأكيد</span></div>
        <ul>
          <li>الحجز المؤقت يحمي السعة لفترة قصيرة فقط.</li>
          <li>سياسة الإلغاء والاسترداد محفوظة مع الموعد عند التأكيد.</li>
          <li>نافذة الوصول ليست وقت دخول مضمونًا للطبيب.</li>
        </ul>
      </section>

      ${active ? AAF.holdBanner('تم حجز السعة لك مؤقتًا', holdRemaining) : ''}
      ${active ? AAF.notice('الحجز المؤقت ليس موعدًا مؤكدًا بعد. أكمل الدفع قبل انتهاء الحماية.', 'hold') : ''}
    </div>`;
    }
    AAF.register({
        id: 'PAT-07', title: 'مراجعة الحجز والحجز المؤقت', defaultState: 'pre-hold-review',
        states: ['pre-hold-review', 'acquiring-hold', 'active-hold', 'capacity-loss', 'hold-expired', 'target-invalid', 'offline-unknown'],
        render: (state) => AAF.shell({
            screenId: 'PAT-07', title: 'مراجعة الحجز', body: PAT07Body(state),
            bottomAction: AAF.button(state === 'active-hold' ? 'الانتقال إلى الدفع' :
                ['capacity-loss', 'hold-expired', 'target-invalid'].includes(state) ? 'العودة إلى التوفر' :
                    state === 'offline-unknown' ? 'إعادة التحقق' : 'إنشاء الحجز المؤقت', ['capacity-loss', 'hold-expired', 'target-invalid'].includes(state) ? 'secondary' : 'primary', { disabled: state === 'acquiring-hold',
                nav: state === 'active-hold' ? 'PAT-08' :
                    ['capacity-loss', 'hold-expired', 'target-invalid'].includes(state) ? 'PAT-06' :
                        state === 'offline-unknown' ? 'PAT-07:active-hold' : 'PAT-07:active-hold' })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT08Body(state) {
        const holdRemaining = String(window.__AAF_HOLD_REMAINING__ || '—');
        if (state === 'hold-expired')
            return `<div class="screen-stack">
      ${AAF.appointmentSummary()}
      ${AAF.statusBlock('error', 'warning', 'انتهى الحجز المؤقت', 'لا يمكن بدء أو استكمال الدفع على سعة لم تعد محمية. ارجع إلى التوفر أولًا.')}
      ${AAF.notice('لن يتم عرض نجاح حجز أو دفع من هذه الحالة.', 'error')}
    </div>`;
        const handoff = state === 'handoff';
        const returned = state === 'returned-unverified';
        const interrupted = state === 'connectivity-interrupted';
        const nearExpiry = state === 'hold-near-expiry';
        return `<div class="screen-stack">
      <section class="payment-safe-panel care-window">
        <div class="caption" style="color:rgba(255,255,255,.72)">المبلغ الكامل</div>
        <div class="amount">15,000 ر.ي</div>
        <div class="copy">${AAF.appointment.doctor} · ${AAF.appointment.service}<br>${AAF.appointment.date}</div>
      </section>

      ${AAF.holdBanner(nearExpiry ? 'الحجز المؤقت يقترب من الانتهاء' : 'الحجز المؤقت نشط', holdRemaining)}

      ${returned
            ? AAF.statusBlock('info', 'clock', 'عدت من بوابة الدفع. جارٍ التحقق من النتيجة.', 'العودة من مزود الدفع ليست إثباتًا نهائيًا للنجاح. سننتقل إلى شاشة النتيجة بعد التحقق.')
            : handoff
                ? AAF.statusBlock('info', 'shield', 'جارٍ فتح تجربة الدفع', 'تم بدء محاولة واحدة فقط لهذا الحجز المؤقت. لا تبدأ محاولة مكررة.')
                : interrupted
                    ? AAF.statusBlock('warning', 'warning', 'انقطع الاتصال أثناء الدفع', 'احتفظنا بسياق المحاولة الحالية. أعد التحقق قبل بدء أي محاولة جديدة.')
                    : `<section class="surface pad section-stack">
                ${AAF.sectionHeading('الدفع الآمن')}
                <div class="body-sm text-secondary">سيتم تحويلك إلى تجربة الدفع الآمنة عبر مزود الدفع المعتمد عند إكمال الربط.</div>
              </section>`}

      ${AAF.notice('لن يتم تأكيد الموعد إلا بعد التحقق من الدفع وصلاحية الحجز المؤقت.', 'info')}
    </div>`;
    }
    AAF.register({
        id: 'PAT-08', title: 'الدفع الكامل', defaultState: 'ready',
        states: ['ready', 'handoff', 'returned-unverified', 'connectivity-interrupted', 'hold-near-expiry', 'hold-expired'],
        render: (state) => AAF.shell({
            screenId: 'PAT-08', title: 'الدفع الكامل', body: PAT08Body(state),
            bottomAction: AAF.button(state === 'returned-unverified' ? 'عرض حالة التحقق' :
                state === 'connectivity-interrupted' ? 'إعادة التحقق' :
                    state === 'hold-expired' ? 'العودة إلى التوفر' :
                        state === 'handoff' ? 'جارٍ فتح الدفع…' : 'متابعة الدفع', state === 'hold-expired' ? 'secondary' : 'primary', { disabled: state === 'handoff', icon: state === 'ready' ? 'card' : undefined,
                nav: state === 'returned-unverified' ? 'PAT-09:processing' :
                    state === 'connectivity-interrupted' ? 'PAT-08:handoff' :
                        state === 'hold-expired' ? 'PAT-06' : 'PAT-08:handoff' })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function outcomeCfg(state) {
        const map = {
            'success-confirmed': {
                tone: 'success', icon: 'check', tag: 'تم الدفع', payTitle: 'تمت معالجة الدفع بنجاح', payCopy: 'تم التحقق من نجاح الدفع الكامل.',
                apptTone: 'success', apptIcon: 'calendar', apptTitle: 'تم تأكيد الموعد', apptCopy: 'تم إنشاء موعد مؤكد لهذا الحجز.',
                action: 'عرض تفاصيل الموعد', nav: 'PAT-10'
            },
            'processing': {
                tone: 'info', icon: 'clock', tag: 'تحت التحقق', payTitle: 'جاري التحقق من عملية الدفع', payCopy: 'استلمنا العودة من مزود الدفع وما زالت النتيجة قيد التحقق.',
                apptTone: 'info', apptIcon: 'calendar', apptTitle: 'نتيجة الحجز لم تُحسم بعد', apptCopy: 'لن نعرض تأكيدًا قبل وصول نتيجة موثوقة.',
                action: 'تحديث الحالة', nav: 'PAT-09:success-confirmed', notice: 'قد يستغرق التحقق بضع لحظات.'
            },
            'failed': {
                tone: 'error', icon: 'close', tag: 'فشل الدفع', payTitle: 'تعذر إتمام عملية الدفع', payCopy: 'لم يكتمل الدفع الكامل لهذه المحاولة.',
                apptTone: 'info', apptIcon: 'calendar', apptTitle: 'الموعد غير مؤكد', apptCopy: 'تحقق من صلاحية الحجز المؤقت قبل إعادة محاولة الدفع.',
                action: 'إعادة المحاولة', nav: 'PAT-08'
            },
            'expired': {
                tone: 'error', icon: 'warning', tag: 'انتهت المحاولة', payTitle: 'انتهت صلاحية محاولة الدفع', payCopy: 'لا توجد نتيجة دفع ناجحة لهذه المحاولة.',
                apptTone: 'error', apptIcon: 'calendar', apptTitle: 'لا يوجد موعد مؤكد', apptCopy: 'انتهت الحماية المؤقتة ويجب العودة إلى التوفر.',
                action: 'العودة إلى التوفر', nav: 'PAT-06'
            },
            'under-review': {
                tone: 'warning', icon: 'warning', tag: 'قيد المراجعة', payTitle: 'الدفع قيد المراجعة', payCopy: 'وصلت نتيجة تحتاج مراجعة قبل اعتماد الحالة المالية.',
                apptTone: 'info', apptIcon: 'calendar', apptTitle: 'تأكيد الموعد غير محسوم', apptCopy: 'سنفصل نتيجة الحجز عن نتيجة الدفع حتى يتم الحسم.',
                action: 'تحديث الحالة', nav: 'PAT-09:success-confirmed'
            },
            'payment-succeeded-booking-unresolved': {
                tone: 'success', icon: 'check', tag: 'الدفع ناجح', payTitle: 'تم التحقق من الدفع', payCopy: 'العملية المالية ناجحة.',
                apptTone: 'warning', apptIcon: 'warning', apptTitle: 'تأكيد الحجز ما زال غير محسوم', apptCopy: 'نجاح الدفع لا يعني تلقائيًا أن الموعد أصبح مؤكدًا.',
                action: 'متابعة حالة الحجز', nav: 'PAT-12:payment-variants', notice: 'إذا تعذر تأكيد الموعد فسيتم التعامل مع المبلغ وفق مسار الاسترداد.'
            },
            'refund-pending': {
                tone: 'warning', icon: 'clock', tag: 'استرداد قيد المعالجة', payTitle: 'بدأت معالجة الاسترداد', payCopy: 'المبلغ في مسار الاسترداد الكامل وفق الحالة الحالية.',
                apptTone: 'error', apptIcon: 'calendar', apptTitle: 'الموعد غير قائم', apptCopy: 'حالة الموعد مستقلة عن اكتمال الاسترداد.',
                action: 'عرض تفاصيل الدفع', nav: 'PAT-13:refund-pending'
            },
            'refunded': {
                tone: 'success', icon: 'check', tag: 'تم الاسترداد', payTitle: 'اكتمل الاسترداد', payCopy: 'تم تسجيل اكتمال استرداد المبلغ وفق الحالة الموثوقة.',
                apptTone: 'error', apptIcon: 'calendar', apptTitle: 'الموعد غير قائم', apptCopy: 'انتهاء الاسترداد لا يغيّر حالة الموعد الملغي.',
                action: 'عرض تفاصيل الدفع', nav: 'PAT-13:refunded'
            },
            'offline': {
                tone: 'warning', icon: 'warning', tag: 'تعذر التحديث', payTitle: 'لا يمكن التحقق من أحدث حالة', payCopy: 'نعرض آخر حالة موثوقة دون افتراض نتيجة جديدة.',
                apptTone: 'info', apptIcon: 'calendar', apptTitle: 'حالة الموعد تحتاج تحديثًا', apptCopy: 'أعد الاتصال قبل اتخاذ قرار جديد.',
                action: 'إعادة التحقق', nav: 'PAT-09:success-confirmed'
            }
        };
        return map[state] || map['success-confirmed'];
    }
    function PAT09Body(state) {
        const c = outcomeCfg(state);
        return `<div class="screen-stack">
      ${AAF.statusBlock(c.tone, c.icon, c.payTitle, c.payCopy, c.tag)}
      ${AAF.statusBlock(c.apptTone, c.apptIcon, c.apptTitle, c.apptCopy, 'حالة الحجز')}
      <section class="surface pad section-stack">
        ${AAF.sectionHeading('تفاصيل العملية')}
        ${AAF.infoRows([
            { key: 'المبلغ', value: AAF.appointment.amount, dir: 'ltr' },
            { key: 'مرجع الدفع', value: AAF.appointment.paymentReference, dir: 'ltr' },
            { key: 'رقم الحجز', value: AAF.appointment.bookingNumber, dir: 'ltr' }
        ])}
      </section>
      ${c.notice ? AAF.notice(c.notice, 'info') : ''}
    </div>`;
    }
    AAF.register({
        id: 'PAT-09', title: 'نتيجة الدفع والمعالجة', defaultState: 'success-confirmed',
        states: ['processing', 'success-confirmed', 'failed', 'expired', 'under-review', 'payment-succeeded-booking-unresolved', 'refund-pending', 'refunded', 'offline'],
        render: (state) => AAF.shell({
            screenId: 'PAT-09', title: 'نتيجة الدفع والمعالجة', body: PAT09Body(state),
            bottomAction: AAF.button(outcomeCfg(state).action, state === 'expired' ? 'secondary' : 'primary', { nav: outcomeCfg(state).nav })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT10Body(state) {
        const payAtFacility = state === 'confirmed-pay-at-facility';
        return `<div class="screen-stack">
      <section class="confirmation-hero">
        <div class="confirmation-icon">${AAF.icon('check')}</div>
        <div>${AAF.badge('موعد مؤكد', 'success')}</div>
        <h1 class="h2">تم تأكيد موعدك</h1>
        <div class="body-sm text-secondary">احتفظ برقم الحجز، واحضر ضمن نافذة الوصول الموضحة.</div>
        <div class="booking-number">${AAF.appointment.bookingNumber}</div>
        ${AAF.button('عرض رمز التحقق', 'secondary', { icon: 'qr', nav: 'PAT-12' })}
      </section>

      ${AAF.appointmentSummary('secondary')}

      ${AAF.statusBlock(payAtFacility ? 'info' : 'success', payAtFacility ? 'money' : 'card', payAtFacility ? 'الدفع في المنشأة' : 'تم الدفع', payAtFacility ? 'لا يوجد PaymentIntent إلكتروني لهذا الحجز. المبلغ مستحق في المنشأة.' : 'تم التحقق من الدفع الكامل لهذا الموعد.', payAtFacility ? 'مستحق في المنشأة' : 'مدفوع')}

      <section class="surface policy-card">
        <div class="policy-title">${AAF.icon('clock')}<span>تعليمات الوصول</span></div>
        <ul>
          <li>احضر ضمن نافذة الوصول ${AAF.appointment.arrivalWindow}.</li>
          <li>نافذة الوصول ليست وقت دخول مضمونًا للطبيب.</li>
          <li>أبرز رقم الحجز عند طلب موظف الاستقبال.</li>
        </ul>
      </section>

      <div class="section-stack">
        ${AAF.button('عرض تفاصيل الموعد', 'primary', { block: true, nav: 'PAT-12' })}
        ${AAF.button('عرض الاتجاهات', 'secondary', { block: true, icon: 'location', nav: 'PAT-05' })}
        ${AAF.button('العودة إلى الرئيسية', 'text', { block: true, nav: 'PAT-01' })}
      </div>
    </div>`;
    }
    AAF.register({
        id: 'PAT-10', title: 'تأكيد الحجز', defaultState: 'confirmed-paid',
        states: ['confirmed-paid', 'confirmed-pay-at-facility'],
        render: (state) => AAF.shell({ screenId: 'PAT-10', title: 'تأكيد الحجز', body: PAT10Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function appointmentCard(status, tone, past = false) {
        return `<article class="surface appointment-card elevated">
      <div class="top"><div><div>${AAF.badge(status, tone)}</div><div style="margin-top:8px" class="name">${AAF.appointment.doctor}</div><div class="service">${AAF.appointment.service}</div></div><div class="caption">${past ? 'سابق' : 'قادم'}</div></div>
      ${AAF.infoRows([
            { key: 'المنشأة', value: AAF.appointment.facility + ' · ' + AAF.appointment.branch },
            { key: 'التاريخ', value: past ? 'الخميس 22 أغسطس 2026' : AAF.appointment.date },
            { key: 'نافذة الوصول', value: past ? '11:00 – 11:30' : AAF.appointment.arrivalWindow, dir: 'ltr' },
            { key: 'الدفع', value: past ? 'تم الدفع' : 'تم الدفع' }
        ])}
      ${AAF.button('عرض تفاصيل الموعد', 'text', { block: true, nav: 'PAT-12' })}
    </article>`;
    }
    function PAT11Body(state) {
        if (state === 'loading')
            return `<div class="screen-stack">${AAF.segmented([{ label: 'القادمة', active: true, nav: 'PAT-11:upcoming-populated' }, { label: 'السابقة', nav: 'PAT-11:past-populated' }])}${AAF.skeleton([{ h: 210 }, { h: 210 }])}</div>`;
        const past = state.startsWith('past');
        const empty = state.endsWith('empty');
        const offline = state === 'offline' || state === 'error';
        return `<div class="screen-stack">
      ${AAF.segmented([{ label: 'القادمة', active: !past, nav: 'PAT-11:upcoming-populated' }, { label: 'السابقة', active: past, nav: 'PAT-11:past-populated' }])}
      ${offline ? AAF.notice(state === 'offline' ? 'أنت غير متصل. نعرض آخر المواعيد المحفوظة ويمكنك تحديثها لاحقًا.' : 'تعذر تحديث المواعيد. يمكنك إعادة المحاولة.', 'info') : ''}
      ${state === 'refreshing' ? AAF.notice('جارٍ تحديث المواعيد مع إبقاء القائمة الحالية ظاهرة.', 'info') : ''}
      ${empty
            ? AAF.emptyState(past ? 'لا توجد مواعيد سابقة' : 'لا توجد لديك مواعيد قادمة', past ? 'ستظهر هنا المواعيد المكتملة أو الملغاة عند توفرها.' : 'ابدأ حجزًا جديدًا عندما تحتاج إلى موعد.', past ? undefined : 'احجز موعدًا', past ? undefined : 'PAT-06')
            : `<div class="list">
            ${appointmentCard(past ? 'مكتمل' : 'مؤكد', past ? 'success' : 'success', past)}
            ${past ? appointmentCard('أُلغي من طرفك', 'error', true) : ''}
          </div>`}
    </div>`;
    }
    AAF.register({
        id: 'PAT-11', title: 'مواعيدي', defaultState: 'upcoming-populated',
        states: ['loading', 'upcoming-populated', 'upcoming-empty', 'past-populated', 'past-empty', 'refreshing', 'offline', 'error'],
        render: (state) => AAF.shell({ screenId: 'PAT-11', title: 'مواعيدي', root: true, active: 'appointments', brandHeader: false, body: PAT11Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT12Body(state) {
        if (state === 'loading')
            return AAF.skeleton([{ h: 180 }, { h: 126 }, { h: 112 }, { h: 112 }, { h: 120 }]);
        if (state === 'offline')
            return `<div class="screen-stack">
      ${AAF.appointmentSummary()}
      ${AAF.notice('أنت غير متصل. نعرض آخر حالة موثوقة للموعد دون افتراض أي تغيير جديد.', 'info')}
      ${AAF.button('إعادة التحقق', 'primary', { block: true, icon: 'refresh', nav: 'PAT-12:confirmed' })}
    </div>`;
        const cancelledPatient = state === 'cancelled-by-patient';
        const cancelledFacility = state === 'cancelled-by-facility';
        const cancelled = cancelledPatient || cancelledFacility;
        const manualLate = state === 'manual-late';
        const paymentVariant = state === 'payment-variants';
        const visitQueueVariant = state === 'visit-queue-variants';
        const appointmentTone = cancelled ? 'error' : 'success';
        const appointmentLabel = cancelledPatient ? 'أُلغي من طرفك' : cancelledFacility ? 'أُلغي من المنشأة' : 'مؤكد';
        return `<div class="screen-stack">
      <section class="surface pad elevated section-stack">
        <div>${AAF.badge(appointmentLabel, appointmentTone)}</div>
        <div>
          <div class="h3">موعد ${AAF.appointment.service}</div>
          <div class="body-sm text-secondary">${AAF.appointment.facility} · ${AAF.appointment.branch}</div>
        </div>
        ${AAF.infoRows([
            { key: 'التاريخ', value: AAF.appointment.date },
            { key: 'نافذة الوصول', value: AAF.appointment.arrivalWindow, dir: 'ltr' },
            { key: 'الطبيب', value: AAF.appointment.doctor }
        ])}
      </section>

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('إثبات الحجز', AAF.button('عرض الرمز', 'secondary', { compact: true, icon: 'qr' }))}
        ${AAF.infoRows([
            { key: 'رقم الحجز', value: AAF.appointment.bookingNumber, dir: 'ltr' },
            { key: 'الحالة', value: appointmentLabel }
        ])}
      </section>

      ${AAF.statusBlock(cancelled ? 'warning' : 'success', cancelled ? 'clock' : 'card', 'حالة الدفع', cancelled ? 'الموعد ملغي، وحالة الاسترداد تُتابع بشكل مستقل في تفاصيل الدفع.' : paymentVariant ? 'حالة الدفع قيد المراجعة. الموعد وحالة الدفع يظلان منفصلين حتى اكتمال التحقق.' : 'تم التحقق من الدفع الكامل.', cancelled ? 'متابعة مستقلة' : paymentVariant ? 'قيد المراجعة' : 'مدفوع')}

      ${AAF.statusBlock(manualLate ? 'warning' : cancelled ? 'info' : 'info', 'queue', 'حالة الزيارة والطابور', manualLate ? 'تم قبول وصولك المتأخر يدويًا. لا نعرض ترتيبًا رقميًا مضمونًا.' : cancelled ? 'لا توجد متابعة زيارة لموعد ملغي.' : visitQueueVariant ? 'تم تسجيل الوصول وأنت في انتظار النداء ضمن مجموعتك.' : 'لم يبدأ تسجيل الوصول بعد.', manualLate ? 'تعامل يدوي' : cancelled ? 'غير نشط' : visitQueueVariant ? 'في الانتظار' : 'قبل الوصول')}

      <section class="surface policy-card">
        <div class="policy-title">${AAF.icon('clock')}<span>تعليمات الوصول</span></div>
        <ul>
          <li>احضر ضمن نافذة الوصول الموضحة أعلاه.</li>
          <li>نافذة الوصول ليست وقت دخول مضمونًا للطبيب.</li>
          <li>يتم تسجيل الوصول بواسطة موظف المنشأة فقط.</li>
        </ul>
      </section>

      ${manualLate ? AAF.notice('تم قبول الوصول المتأخر يدويًا. تتولى المنشأة متابعة حالتك ولا يوجد ترتيب رقمي مضمون.', 'warning') : ''}
      ${cancelledFacility ? AAF.notice('ألغت المنشأة هذا الموعد لأسباب تشغيلية. راجع تفاصيل الدفع لمعرفة حالة الاسترداد إن وُجد.', 'warning') : ''}

      ${AAF.button('عرض الاتجاهات', 'secondary', { block: true, icon: 'location', nav: 'PAT-05' })}
      ${!cancelled && !manualLate ? AAF.button('إلغاء الموعد', 'destructive', { block: true, nav: 'PAT-12:cancelled-by-patient' }) : ''}
    </div>`;
    }
    AAF.register({
        id: 'PAT-12', title: 'تفاصيل الموعد', defaultState: 'confirmed',
        states: ['confirmed', 'cancelled-by-patient', 'cancelled-by-facility', 'payment-variants', 'visit-queue-variants', 'manual-late', 'loading', 'offline'],
        render: (state) => AAF.shell({ screenId: 'PAT-12', title: 'تفاصيل الموعد', body: PAT12Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT13Body(state) {
        if (state === 'loading')
            return AAF.skeleton([{ h: 112 }, { h: 96 }, { h: 140 }]);
        if (state === 'error')
            return `<div class="screen-stack">
      ${AAF.notice('تعذر تحديث تفاصيل الدفع. سنُبقي آخر حالة موثوقة ظاهرة عند توفرها.', 'error')}
      ${AAF.button('إعادة المحاولة', 'primary', { block: true, icon: 'refresh', nav: 'PAT-13:succeeded' })}
    </div>`;
        if (state === 'due-at-facility')
            return `<div class="screen-stack">
      ${AAF.statusBlock('info', 'money', 'الدفع مستحق في المنشأة', 'لم يتم إنشاء PaymentIntent إلكتروني لهذا الموعد. المبلغ سيُدفع للمنشأة عند الوصول.', 'مستحق في المنشأة')}
      <section class="surface amount-block">
        <div class="caption">المبلغ المستحق</div>
        <div class="amount big">${AAF.appointment.amount}</div>
      </section>
      ${AAF.notice('لا توجد إيصال دفع إلكتروني أو حالة استرداد لهذا المسار لأن الدفع سيتم في المنشأة.', 'info')}
      ${AAF.button('العودة إلى تفاصيل الموعد', 'secondary', { block: true, nav: 'PAT-12' })}
    </div>`;
        const cfg = {
            processing: { tone: 'info', icon: 'clock', tag: 'قيد المعالجة', title: 'الدفع قيد المعالجة', copy: 'لا تزال النتيجة المالية قيد التحقق.' },
            succeeded: { tone: 'success', icon: 'check', tag: 'مدفوع', title: 'تم الدفع', copy: 'تم التحقق من الدفع الكامل بنجاح.' },
            failed: { tone: 'error', icon: 'close', tag: 'فشل', title: 'فشل الدفع', copy: 'لم تكتمل عملية الدفع لهذه المحاولة.' },
            expired: { tone: 'error', icon: 'warning', tag: 'منتهي', title: 'انتهت محاولة الدفع', copy: 'انتهت صلاحية المحاولة دون نتيجة دفع ناجحة.' },
            'under-review': { tone: 'warning', icon: 'warning', tag: 'قيد المراجعة', title: 'الدفع قيد المراجعة', copy: 'تحتاج النتيجة الحالية إلى مراجعة قبل اعتمادها.' },
            'refund-pending': { tone: 'warning', icon: 'clock', tag: 'استرداد قيد المعالجة', title: 'جارٍ معالجة الاسترداد', copy: 'بدأ مسار استرداد المبلغ الكامل.', refund: 'REF-2026-031' },
            refunded: { tone: 'success', icon: 'check', tag: 'تم الاسترداد', title: 'تم الاسترداد', copy: 'تم تسجيل اكتمال استرداد المبلغ الكامل.', refund: 'REF-2026-031' }
        };
        const c = cfg[state] || cfg.succeeded;
        return `<div class="screen-stack">
      ${AAF.statusBlock(c.tone, c.icon, c.title, c.copy, c.tag)}
      <section class="surface amount-block">
        <div class="caption">المبلغ</div>
        <div class="amount big">${AAF.appointment.amount}</div>
      </section>

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('إيصال مبسط')}
        <div class="receipt-grid">
          <div class="receipt-row"><div class="label">مرجع الدفع</div><div class="value ltr">${AAF.appointment.paymentReference}</div></div>
          <div class="receipt-row"><div class="label">رقم الحجز</div><div class="value ltr">${AAF.appointment.bookingNumber}</div></div>
          <div class="receipt-row"><div class="label">الخدمة</div><div class="value">${AAF.appointment.service}</div></div>
          <div class="receipt-row"><div class="label">المنشأة</div><div class="value">${AAF.appointment.facility}</div></div>
        </div>
      </section>

      ${c.refund ? `<section class="surface pad section-stack">
        ${AAF.sectionHeading('الاسترداد')}
        ${AAF.infoRows([
            { key: 'الحالة', value: state === 'refunded' ? 'تم الاسترداد' : 'جارٍ معالجة الاسترداد' },
            { key: 'مرجع الاسترداد', value: c.refund, dir: 'ltr' }
        ])}
      </section>` : ''}

      ${AAF.button('تحديث الحالة', 'text', { block: true, icon: 'refresh', nav: 'PAT-13:succeeded' })}
      ${AAF.button('العودة إلى تفاصيل الموعد', 'secondary', { block: true, nav: 'PAT-12' })}
    </div>`;
    }
    AAF.register({
        id: 'PAT-13', title: 'تفاصيل الدفع والاسترداد', defaultState: 'succeeded',
        states: ['due-at-facility', 'processing', 'succeeded', 'failed', 'expired', 'under-review', 'refund-pending', 'refunded', 'loading', 'error'],
        render: (state) => AAF.shell({ screenId: 'PAT-13', title: 'تفاصيل الدفع', body: PAT13Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT14Body(state) {
        if (state === 'offline' || state === 'stale')
            return `<div class="screen-stack">
      ${AAF.appointmentSummary()}
      ${AAF.notice(state === 'offline' ? 'أنت غير متصل. نعرض آخر حالة موثوقة للطابور، وقد تتغير عند عودة الاتصال.' : 'آخر تحديث قديم. حدّث الحالة قبل الاعتماد على رقم الانتظار.', 'warning')}
      ${AAF.statusBlock('info', 'queue', 'حالة الطابور', 'آخر حالة موثوقة: في الانتظار.', 'قديمة')}
      ${AAF.button('تحديث الحالة', 'primary', { block: true, icon: 'refresh', nav: 'PAT-14' })}
    </div>`;
        const map = {
            'not-checked-in': { visitTone: 'info', visitIcon: 'clock', visitTag: 'قبل الوصول', visitTitle: 'لم يتم تسجيل وصولك بعد', visitCopy: 'يتم تسجيل الوصول بواسطة موظف المنشأة فقط.' },
            'checked-in-waiting': { visitTone: 'success', visitIcon: 'check', visitTag: 'تم تسجيل الوصول', visitTitle: 'أنت داخل مسار الزيارة', visitCopy: 'تم تسجيل وصولك وأُضيفت حالتك إلى طابور مجموعتك.', queue: 'waiting' },
            'called': { visitTone: 'success', visitIcon: 'check', visitTag: 'تم تسجيل الوصول', visitTitle: 'تم تسجيل وصولك', visitCopy: 'انتظر تعليمات موظف المنشأة.', queue: 'called' },
            'in-service': { visitTone: 'primary', visitIcon: 'doctor', visitTag: 'داخل الخدمة', visitTitle: 'بدأت الخدمة', visitCopy: 'تم تحديث حالة الزيارة إلى داخل الخدمة.' },
            'completed': { visitTone: 'success', visitIcon: 'check', visitTag: 'مكتملة', visitTitle: 'اكتملت الزيارة', visitCopy: 'تم تسجيل اكتمال الزيارة.' },
            'not-completed': { visitTone: 'warning', visitIcon: 'warning', visitTag: 'لم تكتمل', visitTitle: 'لم تكتمل الزيارة', visitCopy: 'سجلت المنشأة أن الزيارة لم تكتمل.' },
            'no-show': { visitTone: 'error', visitIcon: 'close', visitTag: 'عدم حضور', visitTitle: 'تم تسجيل عدم الحضور', visitCopy: 'انتهت نافذة الوصول دون تسجيل وصول صالح.' },
            'manual-late': { visitTone: 'warning', visitIcon: 'warning', visitTag: 'وصول متأخر مقبول', visitTitle: 'تم قبول وصولك المتأخر يدويًا', visitCopy: 'تتولى المنشأة متابعة حالتك يدويًا ولا يوجد ترتيب رقمي مضمون.', queue: 'manual' }
        };
        const c = map[state] || map['checked-in-waiting'];
        return `<div class="screen-stack">
      ${AAF.appointmentSummary()}
      <section class="surface arrival-window">
        <div class="caption">نافذة الوصول الأصلية</div>
        <div class="time">${AAF.appointment.arrivalWindow}</div>
        <div class="body-sm text-secondary">يبقى الموعد ومجموعة الوصول الأصلية دون نقل تلقائي.</div>
      </section>

      ${AAF.statusBlock(c.visitTone, c.visitIcon, c.visitTitle, c.visitCopy, c.visitTag)}

      ${c.queue === 'waiting' ? `<div class="metric-grid">
        <section class="surface metric"><div class="value">3</div><div class="label">مرضى أمامك تقريبًا</div></section>
        <section class="surface metric"><div class="value">12:04</div><div class="label">آخر تحديث</div></section>
      </div>` : ''}

      ${c.queue === 'called' ? `<section class="queue-callout">
        <div class="caption" style="color:rgba(255,255,255,.72)">حالة الطابور</div>
        <div class="big">تم النداء عليك</div>
        <div class="copy">يرجى التوجه إلى غرفة الخدمة وفق توجيه موظف المنشأة. النداء لا يغيّر حالة الزيارة إلى داخل الخدمة تلقائيًا.</div>
      </section>` : ''}

      ${c.queue === 'manual' ? AAF.notice('لأن الوصول المتأخر تم قبوله يدويًا، لا نعرض عدد المرضى أمامك أو أولوية رقمية.', 'warning') : ''}

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('آخر تحديث', '12:04 م')}
        <div class="body-sm text-secondary">لا يوجد زر تسجيل وصول ذاتي أو إعادة دخول للطابور في تطبيق المريض.</div>
      </section>
    </div>`;
    }
    AAF.register({
        id: 'PAT-14', title: 'حالة الزيارة والطابور', defaultState: 'checked-in-waiting',
        states: ['not-checked-in', 'checked-in-waiting', 'called', 'in-service', 'completed', 'not-completed', 'no-show', 'manual-late', 'offline', 'stale'],
        render: (state) => AAF.shell({ screenId: 'PAT-14', title: 'حالة الزيارة والطابور', body: PAT14Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function notificationItem(n) {
        const iconName = n.kind === 'queue' ? 'queue' : n.kind === 'payment' ? 'card' : 'calendar';
        const nav = n.kind === 'payment' ? 'PAT-13:succeeded' : 'PAT-12';
        return `<article class="notification-item ${n.unread ? 'unread' : ''}" data-nav="${nav}">
      <div>
        <div class="title">${n.title}</div>
        <div class="message">${n.message}</div>
        <div class="time">${n.time}${n.unread ? ' · غير مقروء' : ''}</div>
      </div>
      <div class="status-icon ${n.kind === 'queue' ? 'primary' : n.kind === 'payment' ? 'success' : 'info'}" style="width:40px;height:40px;border-radius:12px">${AAF.icon(iconName)}</div>
    </article>`;
    }
    function PAT15Body(state) {
        if (state === 'loading')
            return AAF.skeleton([{ h: 110 }, { h: 110 }, { h: 110 }]);
        if (state === 'empty')
            return AAF.emptyState('لا توجد إشعارات حتى الآن', 'ستظهر هنا إشعارات الحجز والدفع والزيارة والتوفر عند حدوثها.');
        if (state === 'offline' || state === 'error')
            return `<div class="screen-stack">
      ${AAF.notice(state === 'offline' ? 'أنت غير متصل. نعرض آخر إشعارات محفوظة، وقد تتغير الحالة عند الاتصال.' : 'تعذر تحديث الإشعارات الآن. يمكنك إعادة المحاولة.', 'info')}
      ${AAF.notifications.map(notificationItem).join('')}
      ${AAF.button('إعادة المحاولة', 'text', { block: true, icon: 'refresh', nav: 'PAT-15' })}
    </div>`;
        if (state === 'deep-link-stale')
            return `<div class="screen-stack">
      ${AAF.notice('تم تحديث حالة هذا الموعد. سنعرض لك الحالة الحالية بدل تنفيذ إجراء قديم من الإشعار.', 'warning')}
      ${AAF.notifications.map(notificationItem).join('')}
    </div>`;
        const data = state === 'populated-read' ? AAF.notifications.map(n => ({ ...n, unread: false })) : AAF.notifications;
        return `<div class="notification-list">${data.map(notificationItem).join('')}</div>`;
    }
    AAF.register({
        id: 'PAT-15', title: 'مركز الإشعارات', defaultState: 'populated-unread',
        states: ['loading', 'empty', 'populated-unread', 'populated-read', 'deep-link-stale', 'offline', 'error'],
        render: (state) => AAF.shell({ screenId: 'PAT-15', title: 'الإشعارات', body: PAT15Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT16Body(state) {
        if (state === 'loading')
            return AAF.skeleton([{ h: 126 }, { h: 96 }, { h: 56 }, { h: 56 }]);
        if (state === 'error')
            return `<div class="screen-stack">
      ${AAF.notice('تعذر تحميل بيانات الحساب. يمكنك إعادة المحاولة.', 'error')}
      ${AAF.button('إعادة المحاولة', 'primary', { block: true, icon: 'refresh', nav: 'PAT-16' })}
    </div>`;
        if (state === 'session-expired')
            return `<div class="screen-stack">
      ${AAF.statusBlock('warning', 'warning', 'انتهت الجلسة', 'يلزم التحقق من رقم الهاتف مجددًا باستخدام رمز واتساب لمرة واحدة.', 'يلزم تسجيل الدخول')}
      ${AAF.button('متابعة التحقق', 'primary', { block: true, nav: 'PAT-19' })}
      ${AAF.button('العودة للتصفح', 'text', { block: true, nav: 'PAT-01' })}
    </div>`;
        if (state === 'logging-out')
            return `<div class="screen-stack">
      <section class="profile-hero"><div class="profile-avatar">أب</div><div><div class="name">أحمد بلال</div><div class="phone-value">+[رمز الدولة] ••• ••15</div></div></section>
      ${AAF.notice('جارٍ تسجيل الخروج وإزالة سياق الشاشات المحمية…', 'info')}
      ${AAF.button('جارٍ تسجيل الخروج…', 'secondary', { block: true, disabled: true })}
    </div>`;
        if (state === 'logged-out')
            return `<div class="screen-stack">
      ${AAF.statusBlock('success', 'check', 'تم تسجيل الخروج', 'يمكنك متابعة التصفح العام دون الوصول إلى بيانات الحساب المحمية.', 'مكتمل')}
      ${AAF.button('العودة إلى الرئيسية', 'primary', { block: true, nav: 'PAT-01' })}
    </div>`;
        return `<div class="screen-stack">
      <section class="profile-hero">
        <div class="profile-avatar">أب</div>
        <div><div class="name">أحمد بلال</div><div class="body-sm text-secondary">ملف مريض أساسي</div></div>
      </section>

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('بيانات الحساب')}
        ${AAF.infoRows([
            { key: 'الاسم الكامل', value: 'أحمد بلال' },
            { key: 'رقم الهاتف الموثق', value: '+[رمز الدولة] ••• ••15', dir: 'ltr' }
        ])}
      </section>

      ${AAF.button('تعديل البيانات', 'primary', { block: true, icon: 'edit', nav: 'PAT-17' })}
      ${AAF.button('تسجيل الخروج', 'secondary', { block: true, icon: 'logout', nav: 'PAT-16:logged-out' })}
    </div>`;
    }
    AAF.register({
        id: 'PAT-16', title: 'حسابي', defaultState: 'loaded',
        states: ['loaded', 'loading', 'error', 'session-expired', 'logging-out', 'logged-out'],
        render: (state) => AAF.shell({ screenId: 'PAT-16', title: 'حسابي', root: true, active: 'profile', brandHeader: false, body: PAT16Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT17Body(state) {
        const error = state === 'validation-error';
        const saveFailed = state === 'save-failed';
        const saved = state === 'saved';
        const offline = state === 'offline';
        const saving = state === 'saving';
        return `<div class="screen-stack">
      ${saved ? AAF.notice('تم حفظ التغييرات بنجاح.', 'success') : ''}
      ${saveFailed ? AAF.notice('تعذر حفظ التغييرات. احتفظنا ببياناتك، حاول مرة أخرى.', 'error') : ''}
      ${offline ? AAF.notice('لا يمكن حفظ التغييرات دون اتصال. ستبقى القيم المدخلة كما هي.', 'warning') : ''}
      ${saving ? AAF.notice('جارٍ حفظ التغييرات مع إبقاء البيانات الحالية ظاهرة.', 'info') : ''}

      <div class="form-stack">
        ${AAF.inputField('الاسم الكامل', error ? 'أ' : 'أحمد بلال', error ? 'أدخل الاسم الكامل كما تريد ظهوره في حسابك.' : 'يمكنك تعديل الاسم وحفظ التغييرات عند الانتهاء.', error ? 'error' : 'default')}
      </div>

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('رقم الهاتف الموثق')}
        <div class="phone-preview">+[رمز الدولة] ••• ••15</div>
        <div class="body-sm text-secondary">رقم الهاتف هو هوية الدخول الموثقة ولا يتم تعديله من هذا الحقل.</div>
      </section>

      ${AAF.button(saving ? 'جارٍ الحفظ…' : 'حفظ التغييرات', 'primary', { block: true, disabled: saving || offline, nav: 'PAT-17:saved' })}
    </div>`;
    }
    AAF.register({
        id: 'PAT-17', title: 'تعديل الملف الشخصي', defaultState: 'editing',
        states: ['pristine', 'editing', 'validation-error', 'saving', 'saved', 'save-failed', 'offline'],
        render: (state) => AAF.shell({ screenId: 'PAT-17', title: 'تعديل البيانات', body: PAT17Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT18Body(state) {
        const returnIntent = state === 'return-intent';
        const expired = state === 'session-expired-context';
        return `<div class="screen-stack">
      <section class="auth-hero">
        <div class="auth-mark"></div>
        <div class="eyebrow">${expired ? 'انتهت الجلسة' : returnIntent ? 'خطوة قبل إكمال الحجز' : 'حساب المريض'}</div>
        <h1 class="h1">${expired ? 'تحقق من هويتك للمتابعة' : returnIntent ? 'سجّل دخولك لإكمال الحجز' : 'الدخول إلى حسابك'}</h1>
        <div class="body text-secondary">${expired
            ? 'نحتاج إلى التحقق من رقم الهاتف مرة أخرى قبل الوصول إلى البيانات المحمية.'
            : returnIntent
                ? 'لن نفقد اختيارك الحالي. بعد التحقق سنعود إلى نية الحجز ثم نتحقق من التوفر من جديد.'
                : 'استخدم رقم هاتفك ورمز تحقق لمرة واحدة يُرسل عبر واتساب.'}</div>
      </section>

      ${expired ? AAF.notice('انتهت جلسة الدخول. لن نعيد تنفيذ أي إجراء محمي تلقائيًا بعد التحقق.', 'warning') : ''}

      <section class="surface pad-lg section-stack">
        <div class="status-head">
          <div class="status-icon secondary">${AAF.icon('whats')}</div>
          <div>
            <div class="h3">دخول بدون كلمة مرور</div>
            <div class="body-sm text-secondary">التحقق يتم برمز لمرة واحدة عبر واتساب الرسمي. لا توجد كلمة مرور أو SMS.</div>
          </div>
        </div>
      </section>

      <div class="auth-actions">
        ${AAF.button('تسجيل الدخول', 'primary', { block: true, nav: 'PAT-19' })}
        ${AAF.button('إنشاء حساب مريض', 'tonal', { block: true, nav: 'PAT-19' })}
        ${AAF.button('العودة للتصفح', 'text', { block: true, nav: 'PAT-01' })}
      </div>
    </div>`;
    }
    AAF.register({
        id: 'PAT-18', title: 'الدخول إلى الحساب', defaultState: 'default',
        states: ['default', 'return-intent', 'session-expired-context'],
        render: (state) => AAF.shell({ screenId: 'PAT-18', title: 'الدخول إلى الحساب', body: PAT18Body(state) })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT19Body(state) {
        const invalid = state === 'invalid';
        const requesting = state === 'requesting-otp';
        const provider = state === 'provider-unavailable';
        const rate = state === 'rate-limited';
        const existingOnRegistration = state === 'existing-identity';
        const unknownOnLogin = state === 'unknown-identity';
        const accepted = state === 'accepted';
        return `<div class="screen-stack">
      <section class="auth-hero">
        <div class="eyebrow">التحقق برقم الهاتف</div>
        <h1 class="h1">أدخل رقم هاتفك</h1>
        <div class="body text-secondary">سنستخدم رقم الهاتف الموثق كهوية دخول، ثم نرسل رمز تحقق لمرة واحدة عبر واتساب.</div>
      </section>

      ${provider ? AAF.notice('خدمة إرسال رمز واتساب غير متاحة مؤقتًا. حاول لاحقًا دون تغيير رقمك المدخل.', 'error') : ''}
      ${rate ? AAF.notice('وصلت إلى حد المحاولات الحالي. ستتمكن من إعادة المحاولة عندما يصبح الإرسال متاحًا.', 'warning') : ''}
      ${existingOnRegistration ? AAF.notice('هذا الرقم مرتبط بحساب مريض موجود. يمكنك متابعة تسجيل الدخول بدل إنشاء حساب جديد.', 'info') : ''}
      ${unknownOnLogin ? AAF.notice('لم نجد حساب مريض مرتبطًا بهذا الرقم. يمكنك بدء إنشاء حساب بعد التحقق.', 'info') : ''}
      ${accepted ? AAF.notice('تم قبول الطلب. انتقل إلى شاشة رمز واتساب لإكمال التحقق.', 'success') : ''}
      ${requesting ? AAF.notice('جارٍ طلب رمز التحقق عبر واتساب. لا حاجة لإرسال الطلب مرة أخرى.', 'info') : ''}

      <div class="form-stack">
        ${AAF.inputField('رقم الهاتف', '+[رمز الدولة] [رقم الهاتف]', invalid ? 'تحقق من رقم الهاتف وأعد إدخاله بالصيغة المطلوبة.' : 'سيظهر تنسيق الرقم المطلوب وفق إعدادات الخدمة عند اعتمادها.', invalid ? 'error' : 'default', 'tel')}
      </div>

      <section class="surface pad section-stack">
        <div class="status-head">
          <div class="status-icon secondary">${AAF.icon('whats')}</div>
          <div>
            <div class="status-title">سيصل الرمز عبر واتساب</div>
            <div class="status-copy">لن نستخدم SMS أو كلمة مرور لهذا المسار.</div>
          </div>
        </div>
      </section>
    </div>`;
    }
    AAF.register({
        id: 'PAT-19', title: 'رقم الهاتف', defaultState: 'idle',
        states: ['idle', 'editing', 'invalid', 'requesting-otp', 'existing-identity', 'unknown-identity', 'provider-unavailable', 'rate-limited', 'accepted'],
        render: (state) => AAF.shell({
            screenId: 'PAT-19', title: 'رقم الهاتف', body: PAT19Body(state),
            bottomAction: AAF.button(state === 'requesting-otp' ? 'جارٍ إرسال الرمز…' : 'إرسال رمز التحقق عبر واتساب', 'primary', { disabled: state === 'requesting-otp' || state === 'provider-unavailable' || state === 'rate-limited', icon: 'whats', nav: 'PAT-20' })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function otpCells(state) {
        const rawLength = Number(window.__AAF_OTP_LENGTH__);
        const configuredLength = Number.isFinite(rawLength) && rawLength >= 4 && rawLength <= 8 ? rawLength : 6;
        const filled = state === 'waiting' ? 2 : state === 'verifying' ? configuredLength : state.startsWith('verified') ? configuredLength : 3;
        return `<div class="otp-grid" style="grid-template-columns:repeat(${configuredLength},1fr)" aria-label="رمز التحقق — عدد الخانات حسب إعداد النظام">
      ${Array.from({ length: configuredLength }, (_, i) => `<div class="otp-cell ${state === 'invalid' || state === 'expired' || state === 'already-used' ? 'error' : ''} ${i === filled && state === 'waiting' ? 'active' : ''}">${i < filled ? '•' : ''}</div>`).join('')}
    </div>`;
    }
    function PAT20Body(state) {
        const verifying = state === 'verifying';
        const invalid = state === 'invalid';
        const expired = state === 'expired';
        const used = state === 'already-used';
        const rate = state === 'rate-limited';
        const provider = state === 'provider-unavailable';
        const existing = state === 'verified-existing';
        const fresh = state === 'verified-new';
        return `<div class="screen-stack">
      <section class="auth-hero">
        <div class="eyebrow">التحقق عبر واتساب</div>
        <h1 class="h1">أدخل رمز التحقق</h1>
        <div class="body text-secondary">أرسلنا رمزًا لمرة واحدة إلى الرقم <span class="ltr">+[رمز الدولة] ••• ••15</span>. اكتب الرمز كما وصلك في واتساب. عدد الخانات ومدة الصلاحية يتبعان إعدادات الخدمة.</div>
      </section>

      <section class="surface pad-lg otp-context">
        ${otpCells(state)}
        ${invalid ? `<div class="input-helper input-error">الرمز غير صحيح. راجعه وحاول مرة أخرى.</div>` : ''}
        ${expired ? `<div class="input-helper input-error">انتهت صلاحية الرمز. اطلب رمزًا جديدًا عندما يسمح النظام بذلك.</div>` : ''}
        ${used ? `<div class="input-helper input-error">تم استخدام هذا الرمز من قبل. اطلب رمزًا جديدًا.</div>` : ''}
        ${verifying ? `<div class="input-helper">جارٍ التحقق من الرمز…</div>` : ''}
        ${existing ? `<div class="input-helper text-success">تم التحقق من حساب موجود. يمكنك متابعة المسار المحمي.</div>` : ''}
        ${fresh ? `<div class="input-helper text-success">تم التحقق من رقم جديد. الخطوة التالية هي استكمال بيانات المريض الأساسية.</div>` : ''}
      </section>

      ${rate ? AAF.notice('إعادة الإرسال غير متاحة الآن بسبب حد المحاولات. حاول مجددًا عندما يصبح الإرسال متاحًا.', 'warning') : ''}
      ${provider ? AAF.notice('تعذر الوصول إلى مزود واتساب حاليًا. احتفظنا بسياق التحقق ويمكنك المحاولة لاحقًا.', 'error') : ''}

      <section class="surface pad section-stack">
        <div class="info-row"><div class="key">إعادة الإرسال</div><div class="value">تتاح عند السماح بإعادة الإرسال</div></div>
        <div class="info-row"><div class="key">الرقم الحالي</div><div class="value ltr">+[رمز الدولة] ••• ••15</div></div>
        <div class="otp-actions">
          ${AAF.button('تغيير الرقم', 'secondary', { block: true, nav: 'PAT-19' })}
          ${AAF.button('إعادة الإرسال', 'tonal', { block: true, disabled: rate || provider, nav: 'PAT-20:waiting' })}
        </div>
      </section>
    </div>`;
    }
    AAF.register({
        id: 'PAT-20', title: 'التحقق برمز واتساب', defaultState: 'waiting',
        states: ['waiting', 'verifying', 'invalid', 'expired', 'already-used', 'rate-limited', 'provider-unavailable', 'verified-existing', 'verified-new'],
        render: (state) => AAF.shell({
            screenId: 'PAT-20', title: 'التحقق برمز واتساب', body: PAT20Body(state),
            bottomAction: AAF.button(state === 'verifying' ? 'جارٍ التحقق…' : state.startsWith('verified') ? 'متابعة' : 'تحقق من الرمز', 'primary', { disabled: state === 'verifying' || state === 'provider-unavailable' || state === 'rate-limited',
                nav: state.startsWith('verified') ? 'PAT-21' : 'PAT-20:verified-existing' })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function PAT21Body(state) {
        const error = state === 'validation-error';
        const creating = state === 'creating';
        const success = state === 'success';
        const failed = state === 'recoverable-failure';
        const duplicate = state === 'duplicate-identity-conflict';
        if (success)
            return `<div class="screen-stack">
      ${AAF.statusBlock('success', 'check', 'تم إنشاء ملف المريض', 'اكتملت البيانات الأساسية ويمكنك متابعة المسار الذي بدأته قبل التسجيل.', 'مكتمل')}
      ${AAF.button('متابعة', 'primary', { block: true, nav: 'PAT-01' })}
    </div>`;
        if (duplicate)
            return `<div class="screen-stack">
      ${AAF.statusBlock('warning', 'warning', 'تعذر إنشاء ملف جديد', 'وجد النظام هوية مريض مرتبطة مسبقًا بهذا الرقم الموثق. لن ننشئ ملفًا مكررًا.', 'تعارض هوية')}
      ${AAF.button('العودة إلى تسجيل الدخول', 'primary', { block: true, nav: 'PAT-18' })}
    </div>`;
        return `<div class="screen-stack">
      <section class="auth-hero">
        <div class="eyebrow">خطوة أخيرة</div>
        <h1 class="h1">استكمل بيانات المريض الأساسية</h1>
        <div class="body text-secondary">رقم الهاتف موثق بالفعل. نحتاج إلى بيانات أساسية قليلة لإكمال حساب المريض.</div>
      </section>

      ${failed ? AAF.notice('تعذر إنشاء ملف المريض. احتفظنا بالاسم المدخل ويمكنك المحاولة مرة أخرى.', 'error') : ''}
      ${creating ? AAF.notice('جارٍ إنشاء ملف المريض مع الاحتفاظ بالبيانات المدخلة.', 'info') : ''}

      <section class="surface pad section-stack">
        ${AAF.sectionHeading('رقم الهاتف الموثق')}
        <div class="phone-preview">+[رمز الدولة] ••• ••15</div>
      </section>

      <div class="form-stack">
        ${AAF.inputField('الاسم الكامل', error ? 'أ' : 'أحمد بلال', error ? 'أدخل الاسم الكامل قبل إكمال التسجيل.' : 'يمكنك تحديث بياناتك الأساسية لاحقًا من حسابك.', error ? 'error' : 'default')}
      </div>
    </div>`;
    }
    AAF.register({
        id: 'PAT-21', title: 'استكمال بيانات المريض', defaultState: 'editing',
        states: ['pristine', 'editing', 'validation-error', 'creating', 'success', 'recoverable-failure', 'duplicate-identity-conflict'],
        render: (state) => AAF.shell({
            screenId: 'PAT-21', title: 'استكمال بيانات المريض', body: PAT21Body(state),
            bottomAction: AAF.button(state === 'creating' ? 'جارٍ إنشاء الحساب…' : 'إكمال التسجيل', 'primary', { disabled: state === 'creating', nav: 'PAT-21:success' })
        })
    });
})(AAF || (AAF = {}));
var AAF;
(function (AAF) {
    function parseRoute() {
        const hash = location.hash.replace(/^#\/?/, '');
        if (hash) {
            const parts = hash.split('/').filter(Boolean);
            if (parts[0]) {
                return { screen: parts[0].toUpperCase(), state: parts[1] ? parts[1].toLowerCase() : undefined };
            }
        }
        const qs = new URLSearchParams(location.search);
        const qsScreen = qs.get('screen');
        return { screen: (qsScreen || 'PAT-01').toUpperCase(), state: qs.get('state') || undefined };
    }
    AAF.parseRoute = parseRoute;
    function navigate(id, state) {
        const target = '#/' + id + (state ? '/' + state : '');
        if (location.hash === target) {
            AAF.render();
            return;
        }
        location.hash = target;
    }
    AAF.navigate = navigate;
    function render() {
        const route = AAF.parseRoute();
        const screen = AAF.registry[route.screen];
        if (!screen) {
            document.querySelector('#app').innerHTML = `<div class="prototype-canvas"><div class="phone"><main class="screen">${AAF.emptyState('الشاشة غير متاحة في هذه النسخة', 'سيتم إضافتها ضمن مسار التنفيذ المرحلي.', 'العودة إلى الرئيسية', 'PAT-01')}</main></div></div>`;
            document.title = 'عافيتك — النموذج التفاعلي';
            return;
        }
        const requested = (((window.__AAF_STATE__) || route.state || screen.defaultState));
        const state = String(requested).toLowerCase();
        document.querySelector('#app').innerHTML = `<div class="prototype-canvas">${screen.render(state)}</div>`;
        document.title = `${screen.title} — عافيتك`;
        window.scrollTo(0, 0);
    }
    AAF.render = render;
    function mount() {
        document.addEventListener('click', (event) => {
            const target = event.target;
            if (!target || !target.closest)
                return;
            const navEl = target.closest('[data-nav]');
            if (navEl) {
                event.preventDefault();
                const nav = navEl.getAttribute('data-nav') || '';
                if (nav === 'back') {
                    if (history.length > 1)
                        history.back();
                    else
                        AAF.navigate('PAT-01');
                    return;
                }
                const parts = nav.split(':');
                const id = parts[0] ? parts[0].toUpperCase() : AAF.parseRoute().screen;
                AAF.navigate(id, parts[1] ? parts[1].toLowerCase() : undefined);
                return;
            }
            const toggleEl = target.closest('[data-toggle]');
            if (toggleEl && toggleEl.parentElement) {
                const group = toggleEl.parentElement;
                Array.prototype.forEach.call(group.querySelectorAll('[data-toggle]'), (el) => el.classList.remove('active'));
                toggleEl.classList.add('active');
            }
        });
        window.addEventListener('hashchange', AAF.render);
        AAF.render();
    }
    AAF.mount = mount;
})(AAF || (AAF = {}));
AAF.mount();
