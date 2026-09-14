
namespace AAF {
  function PAT08Body(state:string):string {
    const holdRemaining = String((window as any).__AAF_HOLD_REMAINING__ || '—');
    if(state==='hold-expired') return `<div class="screen-stack">
      ${appointmentSummary()}
      ${statusBlock('error','warning','انتهى الحجز المؤقت','لا يمكن بدء أو استكمال الدفع على سعة لم تعد محمية. ارجع إلى التوفر أولًا.')}
      ${notice('لن يتم عرض نجاح حجز أو دفع من هذه الحالة.','error')}
    </div>`;

    const handoff = state==='handoff';
    const returned = state==='returned-unverified';
    const interrupted = state==='connectivity-interrupted';
    const nearExpiry = state==='hold-near-expiry';

    return `<div class="screen-stack">
      <section class="payment-safe-panel care-window">
        <div class="caption" style="color:rgba(255,255,255,.72)">المبلغ الكامل</div>
        <div class="amount">15,000 ر.ي</div>
        <div class="copy">${appointment.doctor} · ${appointment.service}<br>${appointment.date}</div>
      </section>

      ${holdBanner(nearExpiry?'الحجز المؤقت يقترب من الانتهاء':'الحجز المؤقت نشط',holdRemaining)}

      ${returned
        ? statusBlock('info','clock','عدت من بوابة الدفع. جارٍ التحقق من النتيجة.','العودة من مزود الدفع ليست إثباتًا نهائيًا للنجاح. سننتقل إلى شاشة النتيجة بعد التحقق.')
        : handoff
          ? statusBlock('info','shield','جارٍ فتح تجربة الدفع','تم بدء محاولة واحدة فقط لهذا الحجز المؤقت. لا تبدأ محاولة مكررة.')
          : interrupted
            ? statusBlock('warning','warning','انقطع الاتصال أثناء الدفع','احتفظنا بسياق المحاولة الحالية. أعد التحقق قبل بدء أي محاولة جديدة.')
            : `<section class="surface pad section-stack">
                ${sectionHeading('الدفع الآمن')}
                <div class="body-sm text-secondary">سيتم تحويلك إلى تجربة الدفع الآمنة عبر مزود الدفع المعتمد عند إكمال الربط.</div>
              </section>`
      }

      ${notice('لن يتم تأكيد الموعد إلا بعد التحقق من الدفع وصلاحية الحجز المؤقت.','info')}
    </div>`;
  }

  register({
    id:'PAT-08',title:'الدفع الكامل',defaultState:'ready',
    states:['ready','handoff','returned-unverified','connectivity-interrupted','hold-near-expiry','hold-expired'],
    render:(state)=>shell({
      screenId:'PAT-08',title:'الدفع الكامل',body:PAT08Body(state),
      bottomAction:button(
        state==='returned-unverified'?'عرض حالة التحقق':
        state==='connectivity-interrupted'?'إعادة التحقق':
        state==='hold-expired'?'العودة إلى التوفر':
        state==='handoff'?'جارٍ فتح الدفع…':'متابعة الدفع',
        state==='hold-expired'?'secondary':'primary',
        {disabled:state==='handoff',icon:state==='ready'?'card':undefined,
         nav:state==='returned-unverified'?'PAT-09:processing':
             state==='connectivity-interrupted'?'PAT-08:handoff':
             state==='hold-expired'?'PAT-06':'PAT-08:handoff'}
      )
    })
  });
}
