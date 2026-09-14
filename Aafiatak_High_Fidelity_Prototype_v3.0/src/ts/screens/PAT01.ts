
namespace AAF {
  function PAT01Body(state:string):string {
    if(state==='loading') {
      return `<div class="screen-stack">
        ${skeleton([{h:26,w:'32%'},{h:78,w:'88%'},{h:58},{h:94},{h:196},{h:84},{h:84}])}
      </div>`;
    }
    if(state==='empty-discovery') {
      return `<div class="screen-stack">
        <section class="home-hero">
          <div class="eyebrow">الرعاية أقرب مما تتوقع</div>
          <h1 class="display">ابدأ رحلتك الصحية <em>بوضوح وطمأنينة.</em></h1>
          <div class="copy">ابحث عن طبيب أو تخصص أو قسم أو خدمة، ثم اطّلع على التوفر قبل بدء الحجز.</div>
        </section>
        ${searchField('', undefined, 'PAT-02:results')}
        ${button('احجز موعدًا','primary',{block:true,nav:'PAT-06'})}
        ${emptyState('لا يوجد محتوى استكشاف متاح الآن','يمكنك البحث مباشرة، أو المحاولة مرة أخرى عندما تتوفر بيانات الاستكشاف.','إعادة المحاولة','PAT-01')}
      </div>`;
    }

    const offline = state==='offline' ? notice('أنت غير متصل الآن. يمكنك تصفح آخر بيانات محفوظة، وسنحدّث التوفر عند عودة الاتصال.','info') : state==='error' ? notice('تعذر تحديث محتوى الاستكشاف الآن. يمكنك البحث مباشرة أو إعادة المحاولة.','error') : '';
    const upcoming = state==='guest-populated' ? '' : `<section class="section-stack">
      ${sectionHeading('موعدك القادم','يتطلب تسجيل الدخول')}
      <section class="surface pad elevated section-stack">
        <div>${badge('موعد قادم','secondary')}</div>
        <div>
          <div class="h3">${appointment.doctor}</div>
          <div class="body-sm text-secondary">${appointment.service}</div>
        </div>
        ${infoRows([
          {key:'التاريخ',value:appointment.date},
          {key:'نافذة الوصول',value:appointment.arrivalWindow,dir:'ltr'}
        ])}
        ${button('عرض تفاصيل الموعد','text',{block:true,nav:'PAT-12'})}
      </section>
    </section>`;

    return `<div class="home-discovery">
      <section class="home-hero">
        <div class="eyebrow">الرعاية أقرب مما تتوقع</div>
        <h1 class="display">ابدأ رحلتك الصحية <em>بوضوح وطمأنينة.</em></h1>
        <div class="copy">ابحث عن طبيب أو تخصص أو قسم أو خدمة، ثم اطّلع على التوفر وأكمل الحجز بخطوات واضحة.</div>
      </section>

      ${offline}
      ${searchField('', undefined, 'PAT-02:results')}
      ${button('احجز موعدًا','primary',{block:true,nav:'PAT-06'})}

      <div class="quick-actions" aria-label="اختصارات الاستكشاف">
        <button class="quick-action" data-nav="PAT-02:results"><span class="icon-wrap">${icon('doctor')}</span><span class="label">الأطباء</span></button>
        <button class="quick-action" data-nav="PAT-04"><span class="icon-wrap">${icon('service')}</span><span class="label">الخدمات</span></button>
        <button class="quick-action" data-nav="PAT-05"><span class="icon-wrap">${icon('place')}</span><span class="label">المنشآت</span></button>
      </div>

      ${upcoming}

      <section class="feature-panel care-window">
        ${badge('نافذة وصول واضحة','hold')}
        <div class="title">اعرف التوفر قبل أن تبدأ الحجز</div>
        <div class="copy">اختر الخدمة واليوم، وسيعرض النظام نافذة الوصول المتاحة دون أن يوهمك بوقت دخول مضمون للطبيب.</div>
        ${button('استكشف التوفر','secondary',{icon:'arrow',nav:'PAT-06'})}
      </section>

      <section class="section-stack">
        ${sectionHeading('اكتشف الأطباء','')}
        ${doctorCard()}
        ${doctorCard('د. محمد حسن','الطب العام','12,000 ر.ي')}
      </section>

      <section class="section-stack">
        ${sectionHeading('خدمات شائعة','اختيار سريع')}
        ${serviceCard('استشارة طب الأسرة','15,000 ر.ي','الدفع الكامل إلكترونيًا')}
        ${serviceCard('متابعة طبية','12,000 ر.ي','الدفع في المنشأة')}
      </section>
    </div>`;
  }

  register({
    id:'PAT-01',
    title:'الرئيسية / اكتشف',
    defaultState:'patient-populated',
    states:['guest-populated','patient-populated','loading','empty-discovery','offline','error'],
    render:(state)=>shell({
      screenId:'PAT-01',
      title:'الرئيسية',
      root:true,
      active:'home',
      brandHeader:true,
      body:PAT01Body(state)
    })
  });
}
