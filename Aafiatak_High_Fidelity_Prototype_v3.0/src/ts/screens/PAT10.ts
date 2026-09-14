
namespace AAF {
  function PAT10Body(state:string):string {
    const payAtFacility = state==='confirmed-pay-at-facility';
    return `<div class="screen-stack">
      <section class="confirmation-hero">
        <div class="confirmation-icon">${icon('check')}</div>
        <div>${badge('موعد مؤكد','success')}</div>
        <h1 class="h2">تم تأكيد موعدك</h1>
        <div class="body-sm text-secondary">احتفظ برقم الحجز، واحضر ضمن نافذة الوصول الموضحة.</div>
        <div class="booking-number">${appointment.bookingNumber}</div>
        ${button('عرض رمز التحقق','secondary',{icon:'qr',nav:'PAT-12'})}
      </section>

      ${appointmentSummary('secondary')}

      ${statusBlock(
        payAtFacility?'info':'success',
        payAtFacility?'money':'card',
        payAtFacility?'الدفع في المنشأة':'تم الدفع',
        payAtFacility?'لا يوجد PaymentIntent إلكتروني لهذا الحجز. المبلغ مستحق في المنشأة.':'تم التحقق من الدفع الكامل لهذا الموعد.',
        payAtFacility?'مستحق في المنشأة':'مدفوع'
      )}

      <section class="surface policy-card">
        <div class="policy-title">${icon('clock')}<span>تعليمات الوصول</span></div>
        <ul>
          <li>احضر ضمن نافذة الوصول ${appointment.arrivalWindow}.</li>
          <li>نافذة الوصول ليست وقت دخول مضمونًا للطبيب.</li>
          <li>أبرز رقم الحجز عند طلب موظف الاستقبال.</li>
        </ul>
      </section>

      <div class="section-stack">
        ${button('عرض تفاصيل الموعد','primary',{block:true,nav:'PAT-12'})}
        ${button('عرض الاتجاهات','secondary',{block:true,icon:'location',nav:'PAT-05'})}
        ${button('العودة إلى الرئيسية','text',{block:true,nav:'PAT-01'})}
      </div>
    </div>`;
  }

  register({
    id:'PAT-10',title:'تأكيد الحجز',defaultState:'confirmed-paid',
    states:['confirmed-paid','confirmed-pay-at-facility'],
    render:(state)=>shell({screenId:'PAT-10',title:'تأكيد الحجز',body:PAT10Body(state)})
  });
}
