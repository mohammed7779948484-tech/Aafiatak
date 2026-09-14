
namespace AAF {
  export const doctor: DoctorFixture = {
    id:'doc-001', initials:'س.ع', name:'د. سارة عبدالله', specialty:'طب الأسرة',
    department:'الرعاية الأولية', qualification:'زمالة في طب الأسرة',
    biography:'تهتم بتقديم رعاية واضحة ومتكاملة للبالغين، مع التركيز على الوقاية والمتابعة وتفسير الخطة للمريض بلغة بسيطة.',
    facility:'مركز عافيتك التخصصي', branch:'فرع التحرير',
    services:[
      {name:'استشارة طب الأسرة', amount:'15,000 ر.ي', policy:'الدفع الكامل إلكترونيًا'},
      {name:'متابعة طبية', amount:'12,000 ر.ي', policy:'الدفع في المنشأة'}
    ],
    workingDays:'الأحد – الخميس', workingHours:'9:00 ص – 4:00 م'
  };

  export const appointment: AppointmentFixture = {
    doctor:'د. سارة عبدالله', service:'استشارة طب الأسرة',
    facility:'مركز عافيتك التخصصي', branch:'فرع التحرير',
    date:'الأربعاء 18 سبتمبر 2026', arrivalWindow:'10:00 – 10:30',
    amount:'15,000 ر.ي', currency:'YER', bookingNumber:'AF-28931',
    paymentReference:'PAY-2026-1847'
  };

  export const facility = {
    name:'مركز عافيتك التخصصي', branch:'فرع التحرير',
    city:'صنعاء', region:'أمانة العاصمة',
    address:'شارع التحرير، بجوار الساحة العامة',
    phone:'+967 ••• ••• •••',
    hours:'الأحد – الخميس · 8:00 ص – 5:00 م'
  };

  export const notifications = [
    {kind:'queue', title:'تم النداء عليك', message:'يرجى التوجه إلى غرفة الخدمة عند توجيه موظف الاستقبال.', time:'اليوم · 12:04 م', unread:true},
    {kind:'appointment', title:'تم تأكيد موعدك', message:'موعدك مع د. سارة عبدالله مؤكد. نافذة الوصول 10:00 ص – 10:30 ص.', time:'أمس · 7:32 م', unread:true},
    {kind:'payment', title:'تمت معالجة الدفع', message:'تم التحقق من الدفع لموعد استشارة طب الأسرة.', time:'أمس · 7:31 م', unread:false}
  ];
}
