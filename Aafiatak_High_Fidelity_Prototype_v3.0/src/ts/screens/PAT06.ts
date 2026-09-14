
namespace AAF {
  function availabilityDay(dow:string,num:string,kind:string,label:string):string {
    return `<button class="day ${kind}" data-toggle="day"><span class="dow">${dow}</span><span class="num">${num}</span><span class="state">${label}</span></button>`;
  }

  function PAT06Body(state:string):string {
    if(state==='loading') return skeleton([{h:150},{h:132},{h:116},{h:68}]);
    if(state==='offline' || state==='error') return `<div class="screen-stack">
      ${appointmentSummary()}
      ${notice(state==='offline'?'لا يمكن التحقق من السعة الحالية دون اتصال. لن نعرض سعة قديمة على أنها قابلة للحجز.':'تعذر التحقق من التوفر الآن. حاول مرة أخرى.','error')}
      ${button('إعادة المحاولة','primary',{block:true,icon:'refresh',nav:'PAT-06'})}
    </div>`;

    const noCapacity = ['no-capacity','last-seat-held','time-cutoff'].includes(state);
    let contextual = '';
    if(state==='no-capacity') contextual = notice('لا توجد سعة قابلة للحجز لهذا اليوم حاليًا. يمكنك اختيار يوم آخر أو طلب تنبيه عند التوفر.','info');
    if(state==='last-seat-held') contextual = notice('آخر سعة متاحة محمية حاليًا بحجز مؤقت لمستخدم آخر. التنبيه لا يحجز لك مقعدًا أو أولوية.','warning');
    if(state==='time-cutoff') contextual = notice('انتهى وقت إنشاء حجز مؤقت صالح لهذا اليوم، حتى لو ظهرت سعة رقمية متبقية. اختر يومًا آخر.','warning');
    if(state==='stale') contextual = notice('قد تكون بيانات التوفر قديمة. حدّث الحالة قبل المتابعة حتى لا نعتمد على سعة منتهية.','warning');

    const selectedKind = noCapacity ? 'disabled' : 'selected';

    return `<div class="screen-stack">
      ${appointmentSummary()}
      <section class="surface availability-calendar section-stack">
        ${sectionHeading('اختر اليوم','اختيار يوم فقط')}
        <div class="calendar-strip">
          ${availabilityDay('سبت','14','disabled','مغلق')}
          ${availabilityDay('أحد','15','available','متاح')}
          ${availabilityDay('إثنين','16','available','متاح')}
          ${availabilityDay('ثلاثاء','17','warning','آخر سعة')}
          ${availabilityDay('أربعاء','18',selectedKind,noCapacity?'غير متاح':'محدد')}
          ${availabilityDay('خميس','19','available','متاح')}
          ${availabilityDay('جمعة','20','disabled','مغلق')}
        </div>
      </section>

      <section class="surface arrival-window">
        <div class="caption">نافذة الوصول التي خصصها النظام</div>
        <div class="time">${noCapacity?'—':appointment.arrivalWindow}</div>
        <div class="body-sm text-secondary">هذه نافذة وصول وليست وقت دخول مضمونًا للطبيب.</div>
      </section>

      ${contextual}

      ${noCapacity?`<section class="surface pad section-stack">
        ${sectionHeading('هل تريد معرفة متى تتوفر سعة؟')}
        <div class="body-sm text-secondary">يمكنك الاشتراك في تنبيه. التنبيه لا يحجز مقعدًا ولا يمنح أولوية.</div>
        ${button('أشعرني عند التوفر','tonal',{block:true,icon:'bell'})}
      </section>`:''}
    </div>`;
  }

  register({
    id:'PAT-06',title:'التوفر / اختيار اليوم',defaultState:'bookable',
    states:['loading','bookable','no-capacity','last-seat-held','time-cutoff','stale','offline','error'],
    render:(state)=>shell({
      screenId:'PAT-06',title:'اختر اليوم',body:PAT06Body(state),
      bottomAction:button(
        ['no-capacity','last-seat-held','time-cutoff','offline','error'].includes(state)?'اختر يومًا آخر':'مراجعة الحجز',
        ['no-capacity','last-seat-held','time-cutoff','offline','error'].includes(state)?'secondary':'primary',
        {disabled:['offline','error'].includes(state),nav:['no-capacity','last-seat-held','time-cutoff','offline','error'].includes(state)?'PAT-06':'PAT-07'}
      )
    })
  });
}
