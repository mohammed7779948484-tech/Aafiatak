
namespace AAF {
  function PAT14Body(state:string):string {
    if(state==='offline' || state==='stale') return `<div class="screen-stack">
      ${appointmentSummary()}
      ${notice(state==='offline'?'أنت غير متصل. نعرض آخر حالة موثوقة للطابور، وقد تتغير عند عودة الاتصال.':'آخر تحديث قديم. حدّث الحالة قبل الاعتماد على رقم الانتظار.','warning')}
      ${statusBlock('info','queue','حالة الطابور','آخر حالة موثوقة: في الانتظار.','قديمة')}
      ${button('تحديث الحالة','primary',{block:true,icon:'refresh',nav:'PAT-14'})}
    </div>`;

    const map:Record<string,{visitTone:string;visitIcon:string;visitTag:string;visitTitle:string;visitCopy:string;queue?:string}> = {
      'not-checked-in':{visitTone:'info',visitIcon:'clock',visitTag:'قبل الوصول',visitTitle:'لم يتم تسجيل وصولك بعد',visitCopy:'يتم تسجيل الوصول بواسطة موظف المنشأة فقط.'},
      'checked-in-waiting':{visitTone:'success',visitIcon:'check',visitTag:'تم تسجيل الوصول',visitTitle:'أنت داخل مسار الزيارة',visitCopy:'تم تسجيل وصولك وأُضيفت حالتك إلى طابور مجموعتك.',queue:'waiting'},
      'called':{visitTone:'success',visitIcon:'check',visitTag:'تم تسجيل الوصول',visitTitle:'تم تسجيل وصولك',visitCopy:'انتظر تعليمات موظف المنشأة.',queue:'called'},
      'in-service':{visitTone:'primary',visitIcon:'doctor',visitTag:'داخل الخدمة',visitTitle:'بدأت الخدمة',visitCopy:'تم تحديث حالة الزيارة إلى داخل الخدمة.'},
      'completed':{visitTone:'success',visitIcon:'check',visitTag:'مكتملة',visitTitle:'اكتملت الزيارة',visitCopy:'تم تسجيل اكتمال الزيارة.'},
      'not-completed':{visitTone:'warning',visitIcon:'warning',visitTag:'لم تكتمل',visitTitle:'لم تكتمل الزيارة',visitCopy:'سجلت المنشأة أن الزيارة لم تكتمل.'},
      'no-show':{visitTone:'error',visitIcon:'close',visitTag:'عدم حضور',visitTitle:'تم تسجيل عدم الحضور',visitCopy:'انتهت نافذة الوصول دون تسجيل وصول صالح.'},
      'manual-late':{visitTone:'warning',visitIcon:'warning',visitTag:'وصول متأخر مقبول',visitTitle:'تم قبول وصولك المتأخر يدويًا',visitCopy:'تتولى المنشأة متابعة حالتك يدويًا ولا يوجد ترتيب رقمي مضمون.',queue:'manual'}
    };
    const c=map[state] || map['checked-in-waiting'];

    return `<div class="screen-stack">
      ${appointmentSummary()}
      <section class="surface arrival-window">
        <div class="caption">نافذة الوصول الأصلية</div>
        <div class="time">${appointment.arrivalWindow}</div>
        <div class="body-sm text-secondary">يبقى الموعد ومجموعة الوصول الأصلية دون نقل تلقائي.</div>
      </section>

      ${statusBlock(c.visitTone,c.visitIcon,c.visitTitle,c.visitCopy,c.visitTag)}

      ${c.queue==='waiting'?`<div class="metric-grid">
        <section class="surface metric"><div class="value">3</div><div class="label">مرضى أمامك تقريبًا</div></section>
        <section class="surface metric"><div class="value">12:04</div><div class="label">آخر تحديث</div></section>
      </div>`:''}

      ${c.queue==='called'?`<section class="queue-callout">
        <div class="caption" style="color:rgba(255,255,255,.72)">حالة الطابور</div>
        <div class="big">تم النداء عليك</div>
        <div class="copy">يرجى التوجه إلى غرفة الخدمة وفق توجيه موظف المنشأة. النداء لا يغيّر حالة الزيارة إلى داخل الخدمة تلقائيًا.</div>
      </section>`:''}

      ${c.queue==='manual'?notice('لأن الوصول المتأخر تم قبوله يدويًا، لا نعرض عدد المرضى أمامك أو أولوية رقمية.','warning'):''}

      <section class="surface pad section-stack">
        ${sectionHeading('آخر تحديث','12:04 م')}
        <div class="body-sm text-secondary">لا يوجد زر تسجيل وصول ذاتي أو إعادة دخول للطابور في تطبيق المريض.</div>
      </section>
    </div>`;
  }

  register({
    id:'PAT-14',title:'حالة الزيارة والطابور',defaultState:'checked-in-waiting',
    states:['not-checked-in','checked-in-waiting','called','in-service','completed','not-completed','no-show','manual-late','offline','stale'],
    render:(state)=>shell({screenId:'PAT-14',title:'حالة الزيارة والطابور',body:PAT14Body(state)})
  });
}
