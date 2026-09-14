
namespace AAF {
  function appointmentCard(status:string, tone:string, past=false):string {
    return `<article class="surface appointment-card elevated">
      <div class="top"><div><div>${badge(status,tone)}</div><div style="margin-top:8px" class="name">${appointment.doctor}</div><div class="service">${appointment.service}</div></div><div class="caption">${past?'سابق':'قادم'}</div></div>
      ${infoRows([
        {key:'المنشأة',value:appointment.facility+' · '+appointment.branch},
        {key:'التاريخ',value:past?'الخميس 22 أغسطس 2026':appointment.date},
        {key:'نافذة الوصول',value:past?'11:00 – 11:30':appointment.arrivalWindow,dir:'ltr'},
        {key:'الدفع',value:past?'تم الدفع':'تم الدفع'}
      ])}
      ${button('عرض تفاصيل الموعد','text',{block:true,nav:'PAT-12'})}
    </article>`;
  }

  function PAT11Body(state:string):string {
    if(state==='loading') return `<div class="screen-stack">${segmented([{label:'القادمة',active:true,nav:'PAT-11:upcoming-populated'},{label:'السابقة',nav:'PAT-11:past-populated'}])}${skeleton([{h:210},{h:210}])}</div>`;
    const past = state.startsWith('past');
    const empty = state.endsWith('empty');
    const offline = state==='offline' || state==='error';

    return `<div class="screen-stack">
      ${segmented([{label:'القادمة',active:!past,nav:'PAT-11:upcoming-populated'},{label:'السابقة',active:past,nav:'PAT-11:past-populated'}])}
      ${offline?notice(state==='offline'?'أنت غير متصل. نعرض آخر المواعيد المحفوظة ويمكنك تحديثها لاحقًا.':'تعذر تحديث المواعيد. يمكنك إعادة المحاولة.','info'):''}
      ${state==='refreshing'?notice('جارٍ تحديث المواعيد مع إبقاء القائمة الحالية ظاهرة.','info'):''}
      ${empty
        ? emptyState(
            past?'لا توجد مواعيد سابقة':'لا توجد لديك مواعيد قادمة',
            past?'ستظهر هنا المواعيد المكتملة أو الملغاة عند توفرها.':'ابدأ حجزًا جديدًا عندما تحتاج إلى موعد.',
            past?undefined:'احجز موعدًا',
            past?undefined:'PAT-06'
          )
        : `<div class="list">
            ${appointmentCard(past?'مكتمل':'مؤكد',past?'success':'success',past)}
            ${past?appointmentCard('أُلغي من طرفك','error',true):''}
          </div>`
      }
    </div>`;
  }

  register({
    id:'PAT-11',title:'مواعيدي',defaultState:'upcoming-populated',
    states:['loading','upcoming-populated','upcoming-empty','past-populated','past-empty','refreshing','offline','error'],
    render:(state)=>shell({screenId:'PAT-11',title:'مواعيدي',root:true,active:'appointments',brandHeader:false,body:PAT11Body(state)})
  });
}
