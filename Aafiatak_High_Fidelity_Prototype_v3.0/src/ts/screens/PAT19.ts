
namespace AAF {
  function PAT19Body(state:string):string {
    const invalid = state==='invalid';
    const requesting = state==='requesting-otp';
    const provider = state==='provider-unavailable';
    const rate = state==='rate-limited';
    const existingOnRegistration = state==='existing-identity';
    const unknownOnLogin = state==='unknown-identity';
    const accepted = state==='accepted';

    return `<div class="screen-stack">
      <section class="auth-hero">
        <div class="eyebrow">التحقق برقم الهاتف</div>
        <h1 class="h1">أدخل رقم هاتفك</h1>
        <div class="body text-secondary">سنستخدم رقم الهاتف الموثق كهوية دخول، ثم نرسل رمز تحقق لمرة واحدة عبر واتساب.</div>
      </section>

      ${provider?notice('خدمة إرسال رمز واتساب غير متاحة مؤقتًا. حاول لاحقًا دون تغيير رقمك المدخل.','error'):''}
      ${rate?notice('وصلت إلى حد المحاولات الحالي. ستتمكن من إعادة المحاولة عندما يصبح الإرسال متاحًا.','warning'):''}
      ${existingOnRegistration?notice('هذا الرقم مرتبط بحساب مريض موجود. يمكنك متابعة تسجيل الدخول بدل إنشاء حساب جديد.','info'):''}
      ${unknownOnLogin?notice('لم نجد حساب مريض مرتبطًا بهذا الرقم. يمكنك بدء إنشاء حساب بعد التحقق.','info'):''}
      ${accepted?notice('تم قبول الطلب. انتقل إلى شاشة رمز واتساب لإكمال التحقق.','success'):''}
      ${requesting?notice('جارٍ طلب رمز التحقق عبر واتساب. لا حاجة لإرسال الطلب مرة أخرى.','info'):''}

      <div class="form-stack">
        ${inputField(
          'رقم الهاتف',
          '+[رمز الدولة] [رقم الهاتف]',
          invalid?'تحقق من رقم الهاتف وأعد إدخاله بالصيغة المطلوبة.':'سيظهر تنسيق الرقم المطلوب وفق إعدادات الخدمة عند اعتمادها.',
          invalid?'error':'default',
          'tel'
        )}
      </div>

      <section class="surface pad section-stack">
        <div class="status-head">
          <div class="status-icon secondary">${icon('whats')}</div>
          <div>
            <div class="status-title">سيصل الرمز عبر واتساب</div>
            <div class="status-copy">لن نستخدم SMS أو كلمة مرور لهذا المسار.</div>
          </div>
        </div>
      </section>
    </div>`;
  }

  register({
    id:'PAT-19',title:'رقم الهاتف',defaultState:'idle',
    states:['idle','editing','invalid','requesting-otp','existing-identity','unknown-identity','provider-unavailable','rate-limited','accepted'],
    render:(state)=>shell({
      screenId:'PAT-19',title:'رقم الهاتف',body:PAT19Body(state),
      bottomAction:button(
        state==='requesting-otp'?'جارٍ إرسال الرمز…':'إرسال رمز التحقق عبر واتساب',
        'primary',
        {disabled:state==='requesting-otp'||state==='provider-unavailable'||state==='rate-limited',icon:'whats',nav:'PAT-20'}
      )
    })
  });
}
