
namespace AAF {
  function PAT07Body(state:string):string {
    const holdRemaining = String((window as any).__AAF_HOLD_REMAINING__ || '—');
    if(state==='acquiring-hold') return `<div class="screen-stack">
      ${appointmentSummary()}
      ${skeleton([{h:80},{h:116}])}
      ${notice('جارٍ التحقق من السعة وإنشاء حجز مؤقت صالح. لا تضغط الإجراء مرة أخرى.','info')}
    </div>`;

    if(state==='capacity-loss' || state==='hold-expired' || state==='target-invalid') {
      const title = state==='hold-expired'?'انتهت مدة الحجز المؤقت':state==='capacity-loss'?'لم تعد السعة متاحة':'تغيرت صلاحية وجهة الحجز';
      const copy = state==='hold-expired'
        ? 'لم يعد المقعد محميًا لك. ارجع إلى التوفر للحصول على أحدث سعة قابلة للحجز.'
        : state==='capacity-loss'
          ? 'تم أخذ السعة قبل إتمام الحماية المؤقتة. حدّث التوفر واختر من السعة الحالية.'
          : 'لم يعد الطبيب أو الخدمة أو اليوم صالحًا لإكمال هذا الحجز. ارجع إلى التوفر لمراجعة الخيارات.';
      return `<div class="screen-stack">
        ${appointmentSummary()}
        ${statusBlock('error','warning',title,copy)}
        ${notice('لا توجد حالة موعد مؤكدة ناتجة عن هذا الحجز المؤقت.','error')}
      </div>`;
    }

    if(state==='offline-unknown') return `<div class="screen-stack">
      ${appointmentSummary()}
      ${statusBlock('warning','warning','تعذر التحقق من حالة الحجز المؤقت','لا نعرف إن كانت الحماية المؤقتة ما زالت فعّالة. لا ننشئ محاولة جديدة قبل إعادة التحقق.')}
      ${button('إعادة التحقق','primary',{block:true,icon:'refresh',nav:'PAT-07:active-hold'})}
    </div>`;

    const active = state==='active-hold';
    return `<div class="screen-stack">
      ${appointmentSummary()}

      <section class="surface amount-block">
        ${sectionHeading('الدفع والسياسة',badge('دفع كامل','warning'))}
        <div class="amount big">15,000 ر.ي</div>
        <div class="body-sm text-secondary">سياسة الدفع محددة للخدمة ولا يمكن تغييرها من المريض.</div>
      </section>

      <section class="surface policy-card">
        <div class="policy-title">${icon('shield')}<span>قبل التأكيد</span></div>
        <ul>
          <li>الحجز المؤقت يحمي السعة لفترة قصيرة فقط.</li>
          <li>سياسة الإلغاء والاسترداد محفوظة مع الموعد عند التأكيد.</li>
          <li>نافذة الوصول ليست وقت دخول مضمونًا للطبيب.</li>
        </ul>
      </section>

      ${active?holdBanner('تم حجز السعة لك مؤقتًا',holdRemaining):''}
      ${active?notice('الحجز المؤقت ليس موعدًا مؤكدًا بعد. أكمل الدفع قبل انتهاء الحماية.','hold'):''}
    </div>`;
  }

  register({
    id:'PAT-07',title:'مراجعة الحجز والحجز المؤقت',defaultState:'pre-hold-review',
    states:['pre-hold-review','acquiring-hold','active-hold','capacity-loss','hold-expired','target-invalid','offline-unknown'],
    render:(state)=>shell({
      screenId:'PAT-07',title:'مراجعة الحجز',body:PAT07Body(state),
      bottomAction:button(
        state==='active-hold'?'الانتقال إلى الدفع':
        ['capacity-loss','hold-expired','target-invalid'].includes(state)?'العودة إلى التوفر':
        state==='offline-unknown'?'إعادة التحقق':'إنشاء الحجز المؤقت',
        ['capacity-loss','hold-expired','target-invalid'].includes(state)?'secondary':'primary',
        {disabled:state==='acquiring-hold',
         nav:state==='active-hold'?'PAT-08':
             ['capacity-loss','hold-expired','target-invalid'].includes(state)?'PAT-06':
             state==='offline-unknown'?'PAT-07:active-hold':'PAT-07:active-hold'}
      )
    })
  });
}
