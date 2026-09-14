
namespace AAF {
  function PAT18Body(state:string):string {
    const returnIntent = state==='return-intent';
    const expired = state==='session-expired-context';
    return `<div class="screen-stack">
      <section class="auth-hero">
        <div class="auth-mark"></div>
        <div class="eyebrow">${expired?'انتهت الجلسة':returnIntent?'خطوة قبل إكمال الحجز':'حساب المريض'}</div>
        <h1 class="h1">${expired?'تحقق من هويتك للمتابعة':returnIntent?'سجّل دخولك لإكمال الحجز':'الدخول إلى حسابك'}</h1>
        <div class="body text-secondary">${expired
          ? 'نحتاج إلى التحقق من رقم الهاتف مرة أخرى قبل الوصول إلى البيانات المحمية.'
          : returnIntent
            ? 'لن نفقد اختيارك الحالي. بعد التحقق سنعود إلى نية الحجز ثم نتحقق من التوفر من جديد.'
            : 'استخدم رقم هاتفك ورمز تحقق لمرة واحدة يُرسل عبر واتساب.'}</div>
      </section>

      ${expired?notice('انتهت جلسة الدخول. لن نعيد تنفيذ أي إجراء محمي تلقائيًا بعد التحقق.','warning'):''}

      <section class="surface pad-lg section-stack">
        <div class="status-head">
          <div class="status-icon secondary">${icon('whats')}</div>
          <div>
            <div class="h3">دخول بدون كلمة مرور</div>
            <div class="body-sm text-secondary">التحقق يتم برمز لمرة واحدة عبر واتساب الرسمي. لا توجد كلمة مرور أو SMS.</div>
          </div>
        </div>
      </section>

      <div class="auth-actions">
        ${button('تسجيل الدخول','primary',{block:true,nav:'PAT-19'})}
        ${button('إنشاء حساب مريض','tonal',{block:true,nav:'PAT-19'})}
        ${button('العودة للتصفح','text',{block:true,nav:'PAT-01'})}
      </div>
    </div>`;
  }

  register({
    id:'PAT-18',title:'الدخول إلى الحساب',defaultState:'default',
    states:['default','return-intent','session-expired-context'],
    render:(state)=>shell({screenId:'PAT-18',title:'الدخول إلى الحساب',body:PAT18Body(state)})
  });
}
