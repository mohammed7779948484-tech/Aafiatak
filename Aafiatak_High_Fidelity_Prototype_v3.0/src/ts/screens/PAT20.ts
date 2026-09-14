
namespace AAF {
  function otpCells(state:string):string {
    const rawLength = Number((window as any).__AAF_OTP_LENGTH__);
    const configuredLength = Number.isFinite(rawLength) && rawLength >= 4 && rawLength <= 8 ? rawLength : 6;
    const filled = state==='waiting' ? 2 : state==='verifying' ? configuredLength : state.startsWith('verified') ? configuredLength : 3;
    return `<div class="otp-grid" style="grid-template-columns:repeat(${configuredLength},1fr)" aria-label="رمز التحقق — عدد الخانات حسب إعداد النظام">
      ${Array.from({length:configuredLength},(_,i)=>`<div class="otp-cell ${state==='invalid' || state==='expired' || state==='already-used'?'error':''} ${i===filled && state==='waiting'?'active':''}">${i<filled?'•':''}</div>`).join('')}
    </div>`;
  }

  function PAT20Body(state:string):string {
    const verifying = state==='verifying';
    const invalid = state==='invalid';
    const expired = state==='expired';
    const used = state==='already-used';
    const rate = state==='rate-limited';
    const provider = state==='provider-unavailable';
    const existing = state==='verified-existing';
    const fresh = state==='verified-new';

    return `<div class="screen-stack">
      <section class="auth-hero">
        <div class="eyebrow">التحقق عبر واتساب</div>
        <h1 class="h1">أدخل رمز التحقق</h1>
        <div class="body text-secondary">أرسلنا رمزًا لمرة واحدة إلى الرقم <span class="ltr">+[رمز الدولة] ••• ••15</span>. اكتب الرمز كما وصلك في واتساب. عدد الخانات ومدة الصلاحية يتبعان إعدادات الخدمة.</div>
      </section>

      <section class="surface pad-lg otp-context">
        ${otpCells(state)}
        ${invalid?`<div class="input-helper input-error">الرمز غير صحيح. راجعه وحاول مرة أخرى.</div>`:''}
        ${expired?`<div class="input-helper input-error">انتهت صلاحية الرمز. اطلب رمزًا جديدًا عندما يسمح النظام بذلك.</div>`:''}
        ${used?`<div class="input-helper input-error">تم استخدام هذا الرمز من قبل. اطلب رمزًا جديدًا.</div>`:''}
        ${verifying?`<div class="input-helper">جارٍ التحقق من الرمز…</div>`:''}
        ${existing?`<div class="input-helper text-success">تم التحقق من حساب موجود. يمكنك متابعة المسار المحمي.</div>`:''}
        ${fresh?`<div class="input-helper text-success">تم التحقق من رقم جديد. الخطوة التالية هي استكمال بيانات المريض الأساسية.</div>`:''}
      </section>

      ${rate?notice('إعادة الإرسال غير متاحة الآن بسبب حد المحاولات. حاول مجددًا عندما يصبح الإرسال متاحًا.','warning'):''}
      ${provider?notice('تعذر الوصول إلى مزود واتساب حاليًا. احتفظنا بسياق التحقق ويمكنك المحاولة لاحقًا.','error'):''}

      <section class="surface pad section-stack">
        <div class="info-row"><div class="key">إعادة الإرسال</div><div class="value">تتاح عند السماح بإعادة الإرسال</div></div>
        <div class="info-row"><div class="key">الرقم الحالي</div><div class="value ltr">+[رمز الدولة] ••• ••15</div></div>
        <div class="otp-actions">
          ${button('تغيير الرقم','secondary',{block:true,nav:'PAT-19'})}
          ${button('إعادة الإرسال','tonal',{block:true,disabled:rate||provider,nav:'PAT-20:waiting'})}
        </div>
      </section>
    </div>`;
  }

  register({
    id:'PAT-20',title:'التحقق برمز واتساب',defaultState:'waiting',
    states:['waiting','verifying','invalid','expired','already-used','rate-limited','provider-unavailable','verified-existing','verified-new'],
    render:(state)=>shell({
      screenId:'PAT-20',title:'التحقق برمز واتساب',body:PAT20Body(state),
      bottomAction:button(
        state==='verifying'?'جارٍ التحقق…':state.startsWith('verified')?'متابعة':'تحقق من الرمز',
        'primary',
        {disabled:state==='verifying'||state==='provider-unavailable'||state==='rate-limited',
         nav:state.startsWith('verified')?'PAT-21':'PAT-20:verified-existing'}
      )
    })
  });
}
