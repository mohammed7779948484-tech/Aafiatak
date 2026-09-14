
namespace AAF {
  function PAT21Body(state:string):string {
    const error = state==='validation-error';
    const creating = state==='creating';
    const success = state==='success';
    const failed = state==='recoverable-failure';
    const duplicate = state==='duplicate-identity-conflict';

    if(success) return `<div class="screen-stack">
      ${statusBlock('success','check','تم إنشاء ملف المريض','اكتملت البيانات الأساسية ويمكنك متابعة المسار الذي بدأته قبل التسجيل.','مكتمل')}
      ${button('متابعة','primary',{block:true,nav:'PAT-01'})}
    </div>`;

    if(duplicate) return `<div class="screen-stack">
      ${statusBlock('warning','warning','تعذر إنشاء ملف جديد','وجد النظام هوية مريض مرتبطة مسبقًا بهذا الرقم الموثق. لن ننشئ ملفًا مكررًا.','تعارض هوية')}
      ${button('العودة إلى تسجيل الدخول','primary',{block:true,nav:'PAT-18'})}
    </div>`;

    return `<div class="screen-stack">
      <section class="auth-hero">
        <div class="eyebrow">خطوة أخيرة</div>
        <h1 class="h1">استكمل بيانات المريض الأساسية</h1>
        <div class="body text-secondary">رقم الهاتف موثق بالفعل. نحتاج إلى بيانات أساسية قليلة لإكمال حساب المريض.</div>
      </section>

      ${failed?notice('تعذر إنشاء ملف المريض. احتفظنا بالاسم المدخل ويمكنك المحاولة مرة أخرى.','error'):''}
      ${creating?notice('جارٍ إنشاء ملف المريض مع الاحتفاظ بالبيانات المدخلة.','info'):''}

      <section class="surface pad section-stack">
        ${sectionHeading('رقم الهاتف الموثق')}
        <div class="phone-preview">+[رمز الدولة] ••• ••15</div>
      </section>

      <div class="form-stack">
        ${inputField(
          'الاسم الكامل',
          error?'أ':'أحمد بلال',
          error?'أدخل الاسم الكامل قبل إكمال التسجيل.':'يمكنك تحديث بياناتك الأساسية لاحقًا من حسابك.',
          error?'error':'default'
        )}
      </div>
    </div>`;
  }

  register({
    id:'PAT-21',title:'استكمال بيانات المريض',defaultState:'editing',
    states:['pristine','editing','validation-error','creating','success','recoverable-failure','duplicate-identity-conflict'],
    render:(state)=>shell({
      screenId:'PAT-21',title:'استكمال بيانات المريض',body:PAT21Body(state),
      bottomAction:button(
        state==='creating'?'جارٍ إنشاء الحساب…':'إكمال التسجيل',
        'primary',
        {disabled:state==='creating',nav:'PAT-21:success'}
      )
    })
  });
}
