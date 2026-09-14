
namespace AAF {
  function PAT04Body(state:string):string {
    if(state==='loading') return skeleton([{h:86},{h:140},{h:108},{h:108},{h:108}]);
    if(state==='error') return `<div class="screen-stack">${notice('تعذر تحميل تفاصيل الخدمة. حاول مرة أخرى.','error')}${button('إعادة المحاولة','primary',{block:true,icon:'refresh',nav:'PAT-04'})}</div>`;

    const inactive = state==='inactive';
    const noCapacity = state==='no-capacity';

    return `<div class="screen-stack service-hero">
      <section class="section-stack">
        <div>${badge('طب الأسرة','secondary')}</div>
        <div class="service-title-row">
          <div>
            <h1 class="h1">استشارة طب الأسرة</h1>
            <div class="body-sm text-secondary">${doctor.name} · ${facility.name}</div>
          </div>
        </div>
      </section>

      ${inactive?notice('هذه الخدمة غير متاحة للحجز عبر عافيتك حاليًا.','warning'):''}
      ${noCapacity?notice('الخدمة فعّالة، لكن لا توجد سعة قابلة للحجز حاليًا. يمكنك مراجعة التوفر لاحقًا.','info'):''}

      <section class="service-price-panel">
        <div class="caption">السعر لهذه الخدمة</div>
        <div class="amount">15,000 ر.ي</div>
        <div>${badge('الدفع الكامل إلكترونيًا مطلوب','warning')}</div>
        <div class="body-sm text-secondary">سياسة الدفع معروضة للمعلومة فقط ولا يمكن للمريض تغييرها.</div>
      </section>

      <section class="surface policy-card">
        <div class="policy-title">${icon('shield')}<span>الإلغاء والاسترداد</span></div>
        <p>يمكن الإلغاء ضمن الشروط المحفوظة للموعد. إذا كان الإلغاء مؤهلًا للاسترداد فستظهر حالته بشكل مستقل عن حالة الموعد.</p>
      </section>

      <section class="surface policy-card">
        <div class="policy-title">${icon('warning')}<span>عدم الحضور</span></div>
        <p>تُطبق سياسة عدم الحضور الخاصة بهذه الخدمة إذا انتهت نافذة الوصول دون تسجيل وصول صالح.</p>
      </section>

      <section class="surface policy-card">
        <div class="policy-title">${icon('clock')}<span>تعليمات الحضور</span></div>
        <ul>
          <li>احضر ضمن نافذة الوصول التي سيعرضها النظام عند اختيار اليوم.</li>
          <li>نافذة الوصول ليست وقت دخول مضمونًا للطبيب.</li>
        </ul>
      </section>

      <section class="surface pad section-stack">
        ${sectionHeading('مدة الخدمة','معلومة تقديرية')}
        <div class="body-lg">30 دقيقة تقريبًا</div>
        <div class="body-sm text-secondary">مدة تقديرية للخدمة وليست وقت دخول مضمونًا.</div>
      </section>

      ${facilitySummary()}
    </div>`;
  }

  register({
    id:'PAT-04',title:'تفاصيل الخدمة',defaultState:'active',
    states:['active','no-capacity','inactive','loading','error'],
    render:(state)=>shell({
      screenId:'PAT-04',title:'تفاصيل الخدمة',body:PAT04Body(state),
      bottomAction:button(
        state==='inactive'?'الخدمة غير متاحة':'عرض التوفر',
        state==='inactive'?'secondary':'primary',
        {disabled:state==='inactive',icon:state==='inactive'?undefined:'calendar',nav:'PAT-06'}
      )
    })
  });
}
