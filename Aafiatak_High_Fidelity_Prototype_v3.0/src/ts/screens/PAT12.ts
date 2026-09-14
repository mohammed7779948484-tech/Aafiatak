
namespace AAF {
  function PAT12Body(state:string):string {
    if(state==='loading') return skeleton([{h:180},{h:126},{h:112},{h:112},{h:120}]);
    if(state==='offline') return `<div class="screen-stack">
      ${appointmentSummary()}
      ${notice('أنت غير متصل. نعرض آخر حالة موثوقة للموعد دون افتراض أي تغيير جديد.','info')}
      ${button('إعادة التحقق','primary',{block:true,icon:'refresh',nav:'PAT-12:confirmed'})}
    </div>`;

    const cancelledPatient = state==='cancelled-by-patient';
    const cancelledFacility = state==='cancelled-by-facility';
    const cancelled = cancelledPatient || cancelledFacility;
    const manualLate = state==='manual-late';
    const paymentVariant = state==='payment-variants';
    const visitQueueVariant = state==='visit-queue-variants';

    const appointmentTone = cancelled?'error':'success';
    const appointmentLabel = cancelledPatient?'أُلغي من طرفك':cancelledFacility?'أُلغي من المنشأة':'مؤكد';

    return `<div class="screen-stack">
      <section class="surface pad elevated section-stack">
        <div>${badge(appointmentLabel,appointmentTone)}</div>
        <div>
          <div class="h3">موعد ${appointment.service}</div>
          <div class="body-sm text-secondary">${appointment.facility} · ${appointment.branch}</div>
        </div>
        ${infoRows([
          {key:'التاريخ',value:appointment.date},
          {key:'نافذة الوصول',value:appointment.arrivalWindow,dir:'ltr'},
          {key:'الطبيب',value:appointment.doctor}
        ])}
      </section>

      <section class="surface pad section-stack">
        ${sectionHeading('إثبات الحجز',button('عرض الرمز','secondary',{compact:true,icon:'qr'}))}
        ${infoRows([
          {key:'رقم الحجز',value:appointment.bookingNumber,dir:'ltr'},
          {key:'الحالة',value:appointmentLabel}
        ])}
      </section>

      ${statusBlock(
        cancelled?'warning':'success',
        cancelled?'clock':'card',
        'حالة الدفع',
        cancelled?'الموعد ملغي، وحالة الاسترداد تُتابع بشكل مستقل في تفاصيل الدفع.':paymentVariant?'حالة الدفع قيد المراجعة. الموعد وحالة الدفع يظلان منفصلين حتى اكتمال التحقق.':'تم التحقق من الدفع الكامل.',
        cancelled?'متابعة مستقلة':paymentVariant?'قيد المراجعة':'مدفوع'
      )}

      ${statusBlock(
        manualLate?'warning':cancelled?'info':'info',
        'queue',
        'حالة الزيارة والطابور',
        manualLate?'تم قبول وصولك المتأخر يدويًا. لا نعرض ترتيبًا رقميًا مضمونًا.':cancelled?'لا توجد متابعة زيارة لموعد ملغي.':visitQueueVariant?'تم تسجيل الوصول وأنت في انتظار النداء ضمن مجموعتك.':'لم يبدأ تسجيل الوصول بعد.',
        manualLate?'تعامل يدوي':cancelled?'غير نشط':visitQueueVariant?'في الانتظار':'قبل الوصول'
      )}

      <section class="surface policy-card">
        <div class="policy-title">${icon('clock')}<span>تعليمات الوصول</span></div>
        <ul>
          <li>احضر ضمن نافذة الوصول الموضحة أعلاه.</li>
          <li>نافذة الوصول ليست وقت دخول مضمونًا للطبيب.</li>
          <li>يتم تسجيل الوصول بواسطة موظف المنشأة فقط.</li>
        </ul>
      </section>

      ${manualLate?notice('تم قبول الوصول المتأخر يدويًا. تتولى المنشأة متابعة حالتك ولا يوجد ترتيب رقمي مضمون.','warning'):''}
      ${cancelledFacility?notice('ألغت المنشأة هذا الموعد لأسباب تشغيلية. راجع تفاصيل الدفع لمعرفة حالة الاسترداد إن وُجد.','warning'):''}

      ${button('عرض الاتجاهات','secondary',{block:true,icon:'location',nav:'PAT-05'})}
      ${!cancelled && !manualLate?button('إلغاء الموعد','destructive',{block:true,nav:'PAT-12:cancelled-by-patient'}):''}
    </div>`;
  }

  register({
    id:'PAT-12',title:'تفاصيل الموعد',defaultState:'confirmed',
    states:['confirmed','cancelled-by-patient','cancelled-by-facility','payment-variants','visit-queue-variants','manual-late','loading','offline'],
    render:(state)=>shell({screenId:'PAT-12',title:'تفاصيل الموعد',body:PAT12Body(state)})
  });
}
