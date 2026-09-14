
namespace AAF {
  function PAT03Body(state:string):string {
    if(state==='loading') return skeleton([{h:110},{h:110},{h:92},{h:92},{h:92}]);
    if(state==='error') return `<div class="screen-stack">
      ${notice('تعذر تحميل تفاصيل الطبيب الآن. يمكنك إعادة المحاولة دون فقد مسار التصفح.','error')}
      ${button('إعادة المحاولة','primary',{block:true,icon:'refresh',nav:'PAT-03'})}
    </div>`;

    const inactive = state==='inactive';
    const noAvailability = state==='no-bookable-availability';
    return `<div class="screen-stack doctor-hero">
      <section class="doctor-profile">
        <div class="avatar large">${doctor.initials}</div>
        <div>
          <div class="specialty">${doctor.specialty}</div>
          <div class="name">${doctor.name}</div>
          <div class="dept">${doctor.department}</div>
        </div>
      </section>

      ${inactive?notice('هذا الطبيب غير متاح للحجز عبر عافيتك حاليًا. يمكنك الاطلاع على المعلومات العامة والخدمات المرتبطة.','warning'):''}
      ${noAvailability?notice('لا توجد سعة قابلة للحجز حاليًا. ستظل معلومات الطبيب متاحة ويمكنك مراجعة التوفر لاحقًا.','info'):''}

      <section class="surface pad section-stack">
        ${sectionHeading('نبذة مهنية')}
        <div class="body-sm text-secondary">${doctor.qualification}</div>
        <div class="bio">${doctor.biography}</div>
      </section>

      <section class="section-stack">
        ${sectionHeading('المنشأة والفرع')}
        ${facilitySummary()}
      </section>

      <section class="section-stack">
        ${sectionHeading('الخدمات','في هذا الفرع')}
        ${doctor.services.map(s=>serviceCard(s.name,s.amount,s.policy)).join('')}
      </section>

      <section class="surface pad section-stack">
        ${sectionHeading('أيام وساعات العمل','معلومات عامة')}
        ${infoRows([
          {key:'الأيام',value:doctor.workingDays},
          {key:'الساعات',value:doctor.workingHours,dir:'ltr'}
        ])}
      </section>
    </div>`;
  }

  register({
    id:'PAT-03',title:'تفاصيل الطبيب',defaultState:'active',
    states:['active','no-bookable-availability','inactive','loading','error'],
    render:(state)=>shell({
      screenId:'PAT-03',title:'تفاصيل الطبيب',body:PAT03Body(state),
      bottomAction:button(
        state==='inactive'?'غير متاح للحجز':'عرض المواعيد المتاحة',
        state==='inactive'?'secondary':'primary',
        {disabled:state==='inactive',icon:state==='inactive'?undefined:'calendar',nav:'PAT-06'}
      )
    })
  });
}
