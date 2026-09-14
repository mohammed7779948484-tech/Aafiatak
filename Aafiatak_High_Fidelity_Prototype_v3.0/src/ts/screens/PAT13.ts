
namespace AAF {
  function PAT13Body(state:string):string {
    if(state==='loading') return skeleton([{h:112},{h:96},{h:140}]);
    if(state==='error') return `<div class="screen-stack">
      ${notice('تعذر تحديث تفاصيل الدفع. سنُبقي آخر حالة موثوقة ظاهرة عند توفرها.','error')}
      ${button('إعادة المحاولة','primary',{block:true,icon:'refresh',nav:'PAT-13:succeeded'})}
    </div>`;

    if(state==='due-at-facility') return `<div class="screen-stack">
      ${statusBlock('info','money','الدفع مستحق في المنشأة','لم يتم إنشاء PaymentIntent إلكتروني لهذا الموعد. المبلغ سيُدفع للمنشأة عند الوصول.','مستحق في المنشأة')}
      <section class="surface amount-block">
        <div class="caption">المبلغ المستحق</div>
        <div class="amount big">${appointment.amount}</div>
      </section>
      ${notice('لا توجد إيصال دفع إلكتروني أو حالة استرداد لهذا المسار لأن الدفع سيتم في المنشأة.','info')}
      ${button('العودة إلى تفاصيل الموعد','secondary',{block:true,nav:'PAT-12'})}
    </div>`;

    const cfg:Record<string,{tone:string;icon:string;tag:string;title:string;copy:string;refund?:string}> = {
      processing:{tone:'info',icon:'clock',tag:'قيد المعالجة',title:'الدفع قيد المعالجة',copy:'لا تزال النتيجة المالية قيد التحقق.'},
      succeeded:{tone:'success',icon:'check',tag:'مدفوع',title:'تم الدفع',copy:'تم التحقق من الدفع الكامل بنجاح.'},
      failed:{tone:'error',icon:'close',tag:'فشل',title:'فشل الدفع',copy:'لم تكتمل عملية الدفع لهذه المحاولة.'},
      expired:{tone:'error',icon:'warning',tag:'منتهي',title:'انتهت محاولة الدفع',copy:'انتهت صلاحية المحاولة دون نتيجة دفع ناجحة.'},
      'under-review':{tone:'warning',icon:'warning',tag:'قيد المراجعة',title:'الدفع قيد المراجعة',copy:'تحتاج النتيجة الحالية إلى مراجعة قبل اعتمادها.'},
      'refund-pending':{tone:'warning',icon:'clock',tag:'استرداد قيد المعالجة',title:'جارٍ معالجة الاسترداد',copy:'بدأ مسار استرداد المبلغ الكامل.',refund:'REF-2026-031'},
      refunded:{tone:'success',icon:'check',tag:'تم الاسترداد',title:'تم الاسترداد',copy:'تم تسجيل اكتمال استرداد المبلغ الكامل.',refund:'REF-2026-031'}
    };
    const c=cfg[state] || cfg.succeeded;
    return `<div class="screen-stack">
      ${statusBlock(c.tone,c.icon,c.title,c.copy,c.tag)}
      <section class="surface amount-block">
        <div class="caption">المبلغ</div>
        <div class="amount big">${appointment.amount}</div>
      </section>

      <section class="surface pad section-stack">
        ${sectionHeading('إيصال مبسط')}
        <div class="receipt-grid">
          <div class="receipt-row"><div class="label">مرجع الدفع</div><div class="value ltr">${appointment.paymentReference}</div></div>
          <div class="receipt-row"><div class="label">رقم الحجز</div><div class="value ltr">${appointment.bookingNumber}</div></div>
          <div class="receipt-row"><div class="label">الخدمة</div><div class="value">${appointment.service}</div></div>
          <div class="receipt-row"><div class="label">المنشأة</div><div class="value">${appointment.facility}</div></div>
        </div>
      </section>

      ${c.refund?`<section class="surface pad section-stack">
        ${sectionHeading('الاسترداد')}
        ${infoRows([
          {key:'الحالة',value:state==='refunded'?'تم الاسترداد':'جارٍ معالجة الاسترداد'},
          {key:'مرجع الاسترداد',value:c.refund,dir:'ltr'}
        ])}
      </section>`:''}

      ${button('تحديث الحالة','text',{block:true,icon:'refresh',nav:'PAT-13:succeeded'})}
      ${button('العودة إلى تفاصيل الموعد','secondary',{block:true,nav:'PAT-12'})}
    </div>`;
  }

  register({
    id:'PAT-13',title:'تفاصيل الدفع والاسترداد',defaultState:'succeeded',
    states:['due-at-facility','processing','succeeded','failed','expired','under-review','refund-pending','refunded','loading','error'],
    render:(state)=>shell({screenId:'PAT-13',title:'تفاصيل الدفع',body:PAT13Body(state)})
  });
}
