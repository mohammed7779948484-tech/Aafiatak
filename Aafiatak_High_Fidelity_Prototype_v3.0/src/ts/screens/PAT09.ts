
namespace AAF {
  type OutcomeCfg = {tone:string;icon:string;tag:string;payTitle:string;payCopy:string;apptTone:string;apptIcon:string;apptTitle:string;apptCopy:string;action:string;nav:string;notice?:string;};
  function outcomeCfg(state:string):OutcomeCfg {
    const map:Record<string,OutcomeCfg>={
      'success-confirmed':{
        tone:'success',icon:'check',tag:'تم الدفع',payTitle:'تمت معالجة الدفع بنجاح',payCopy:'تم التحقق من نجاح الدفع الكامل.',
        apptTone:'success',apptIcon:'calendar',apptTitle:'تم تأكيد الموعد',apptCopy:'تم إنشاء موعد مؤكد لهذا الحجز.',
        action:'عرض تفاصيل الموعد',nav:'PAT-10'
      },
      'processing':{
        tone:'info',icon:'clock',tag:'تحت التحقق',payTitle:'جاري التحقق من عملية الدفع',payCopy:'استلمنا العودة من مزود الدفع وما زالت النتيجة قيد التحقق.',
        apptTone:'info',apptIcon:'calendar',apptTitle:'نتيجة الحجز لم تُحسم بعد',apptCopy:'لن نعرض تأكيدًا قبل وصول نتيجة موثوقة.',
        action:'تحديث الحالة',nav:'PAT-09:success-confirmed',notice:'قد يستغرق التحقق بضع لحظات.'
      },
      'failed':{
        tone:'error',icon:'close',tag:'فشل الدفع',payTitle:'تعذر إتمام عملية الدفع',payCopy:'لم يكتمل الدفع الكامل لهذه المحاولة.',
        apptTone:'info',apptIcon:'calendar',apptTitle:'الموعد غير مؤكد',apptCopy:'تحقق من صلاحية الحجز المؤقت قبل إعادة محاولة الدفع.',
        action:'إعادة المحاولة',nav:'PAT-08'
      },
      'expired':{
        tone:'error',icon:'warning',tag:'انتهت المحاولة',payTitle:'انتهت صلاحية محاولة الدفع',payCopy:'لا توجد نتيجة دفع ناجحة لهذه المحاولة.',
        apptTone:'error',apptIcon:'calendar',apptTitle:'لا يوجد موعد مؤكد',apptCopy:'انتهت الحماية المؤقتة ويجب العودة إلى التوفر.',
        action:'العودة إلى التوفر',nav:'PAT-06'
      },
      'under-review':{
        tone:'warning',icon:'warning',tag:'قيد المراجعة',payTitle:'الدفع قيد المراجعة',payCopy:'وصلت نتيجة تحتاج مراجعة قبل اعتماد الحالة المالية.',
        apptTone:'info',apptIcon:'calendar',apptTitle:'تأكيد الموعد غير محسوم',apptCopy:'سنفصل نتيجة الحجز عن نتيجة الدفع حتى يتم الحسم.',
        action:'تحديث الحالة',nav:'PAT-09:success-confirmed'
      },
      'payment-succeeded-booking-unresolved':{
        tone:'success',icon:'check',tag:'الدفع ناجح',payTitle:'تم التحقق من الدفع',payCopy:'العملية المالية ناجحة.',
        apptTone:'warning',apptIcon:'warning',apptTitle:'تأكيد الحجز ما زال غير محسوم',apptCopy:'نجاح الدفع لا يعني تلقائيًا أن الموعد أصبح مؤكدًا.',
        action:'متابعة حالة الحجز',nav:'PAT-12:payment-variants',notice:'إذا تعذر تأكيد الموعد فسيتم التعامل مع المبلغ وفق مسار الاسترداد.'
      },
      'refund-pending':{
        tone:'warning',icon:'clock',tag:'استرداد قيد المعالجة',payTitle:'بدأت معالجة الاسترداد',payCopy:'المبلغ في مسار الاسترداد الكامل وفق الحالة الحالية.',
        apptTone:'error',apptIcon:'calendar',apptTitle:'الموعد غير قائم',apptCopy:'حالة الموعد مستقلة عن اكتمال الاسترداد.',
        action:'عرض تفاصيل الدفع',nav:'PAT-13:refund-pending'
      },
      'refunded':{
        tone:'success',icon:'check',tag:'تم الاسترداد',payTitle:'اكتمل الاسترداد',payCopy:'تم تسجيل اكتمال استرداد المبلغ وفق الحالة الموثوقة.',
        apptTone:'error',apptIcon:'calendar',apptTitle:'الموعد غير قائم',apptCopy:'انتهاء الاسترداد لا يغيّر حالة الموعد الملغي.',
        action:'عرض تفاصيل الدفع',nav:'PAT-13:refunded'
      },
      'offline':{
        tone:'warning',icon:'warning',tag:'تعذر التحديث',payTitle:'لا يمكن التحقق من أحدث حالة',payCopy:'نعرض آخر حالة موثوقة دون افتراض نتيجة جديدة.',
        apptTone:'info',apptIcon:'calendar',apptTitle:'حالة الموعد تحتاج تحديثًا',apptCopy:'أعد الاتصال قبل اتخاذ قرار جديد.',
        action:'إعادة التحقق',nav:'PAT-09:success-confirmed'
      }
    };
    return map[state] || map['success-confirmed'];
  }

  function PAT09Body(state:string):string {
    const c=outcomeCfg(state);
    return `<div class="screen-stack">
      ${statusBlock(c.tone,c.icon,c.payTitle,c.payCopy,c.tag)}
      ${statusBlock(c.apptTone,c.apptIcon,c.apptTitle,c.apptCopy,'حالة الحجز')}
      <section class="surface pad section-stack">
        ${sectionHeading('تفاصيل العملية')}
        ${infoRows([
          {key:'المبلغ',value:appointment.amount,dir:'ltr'},
          {key:'مرجع الدفع',value:appointment.paymentReference,dir:'ltr'},
          {key:'رقم الحجز',value:appointment.bookingNumber,dir:'ltr'}
        ])}
      </section>
      ${c.notice?notice(c.notice,'info'):''}
    </div>`;
  }

  register({
    id:'PAT-09',title:'نتيجة الدفع والمعالجة',defaultState:'success-confirmed',
    states:['processing','success-confirmed','failed','expired','under-review','payment-succeeded-booking-unresolved','refund-pending','refunded','offline'],
    render:(state)=>shell({
      screenId:'PAT-09',title:'نتيجة الدفع والمعالجة',body:PAT09Body(state),
      bottomAction:button(outcomeCfg(state).action,state==='expired'?'secondary':'primary',{nav:outcomeCfg(state).nav})
    })
  });
}
