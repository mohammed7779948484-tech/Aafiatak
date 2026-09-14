
namespace AAF {
  function PAT16Body(state:string):string {
    if(state==='loading') return skeleton([{h:126},{h:96},{h:56},{h:56}]);
    if(state==='error') return `<div class="screen-stack">
      ${notice('تعذر تحميل بيانات الحساب. يمكنك إعادة المحاولة.','error')}
      ${button('إعادة المحاولة','primary',{block:true,icon:'refresh',nav:'PAT-16'})}
    </div>`;
    if(state==='session-expired') return `<div class="screen-stack">
      ${statusBlock('warning','warning','انتهت الجلسة','يلزم التحقق من رقم الهاتف مجددًا باستخدام رمز واتساب لمرة واحدة.','يلزم تسجيل الدخول')}
      ${button('متابعة التحقق','primary',{block:true,nav:'PAT-19'})}
      ${button('العودة للتصفح','text',{block:true,nav:'PAT-01'})}
    </div>`;
    if(state==='logging-out') return `<div class="screen-stack">
      <section class="profile-hero"><div class="profile-avatar">أب</div><div><div class="name">أحمد بلال</div><div class="phone-value">+[رمز الدولة] ••• ••15</div></div></section>
      ${notice('جارٍ تسجيل الخروج وإزالة سياق الشاشات المحمية…','info')}
      ${button('جارٍ تسجيل الخروج…','secondary',{block:true,disabled:true})}
    </div>`;
    if(state==='logged-out') return `<div class="screen-stack">
      ${statusBlock('success','check','تم تسجيل الخروج','يمكنك متابعة التصفح العام دون الوصول إلى بيانات الحساب المحمية.','مكتمل')}
      ${button('العودة إلى الرئيسية','primary',{block:true,nav:'PAT-01'})}
    </div>`;

    return `<div class="screen-stack">
      <section class="profile-hero">
        <div class="profile-avatar">أب</div>
        <div><div class="name">أحمد بلال</div><div class="body-sm text-secondary">ملف مريض أساسي</div></div>
      </section>

      <section class="surface pad section-stack">
        ${sectionHeading('بيانات الحساب')}
        ${infoRows([
          {key:'الاسم الكامل',value:'أحمد بلال'},
          {key:'رقم الهاتف الموثق',value:'+[رمز الدولة] ••• ••15',dir:'ltr'}
        ])}
      </section>

      ${button('تعديل البيانات','primary',{block:true,icon:'edit',nav:'PAT-17'})}
      ${button('تسجيل الخروج','secondary',{block:true,icon:'logout',nav:'PAT-16:logged-out'})}
    </div>`;
  }

  register({
    id:'PAT-16',title:'حسابي',defaultState:'loaded',
    states:['loaded','loading','error','session-expired','logging-out','logged-out'],
    render:(state)=>shell({screenId:'PAT-16',title:'حسابي',root:true,active:'profile',brandHeader:false,body:PAT16Body(state)})
  });
}
