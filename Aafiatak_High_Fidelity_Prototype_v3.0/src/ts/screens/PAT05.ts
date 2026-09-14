
namespace AAF {
  function PAT05Body(state:string):string {
    if(state==='loading') return skeleton([{h:82},{h:88},{h:180},{h:96},{h:92},{h:92}]);
    if(state==='error') return `<div class="screen-stack">${notice('تعذر تحميل تفاصيل المنشأة الآن. يمكنك إعادة المحاولة.','error')}${button('إعادة المحاولة','primary',{block:true,icon:'refresh',nav:'PAT-05'})}</div>`;

    const locationUnavailable = state==='location-unavailable';

    return `<div class="screen-stack">
      <section class="facility-identity">
        <div>${badge(facility.branch,'info')}</div>
        <h1 class="facility-name">${facility.name}</h1>
        <div class="body-sm text-secondary">${facility.city} · ${facility.region}</div>
      </section>

      <section class="surface pad section-stack">
        ${sectionHeading('العنوان')}
        <div class="body">${facility.address}</div>
      </section>

      ${locationUnavailable
        ? `<section class="surface empty-state">
            <div class="status-icon info">${icon('location')}</div>
            <div class="title">تعذر عرض معاينة الموقع</div>
            <div class="copy">العنوان النصي ما زال متاحًا، ويمكن استخدامه حتى يكتمل تكامل خدمة الخرائط.</div>
          </section>`
        : `<section class="surface map-placeholder">
            <div class="map-pin">${icon('location')}</div>
            <div class="map-label">معاينة موقع المنشأة</div>
          </section>`
      }

      ${button('عرض الموقع','secondary',{block:true,icon:'location',nav:'PAT-05'})}

      <section class="surface pad section-stack">
        ${sectionHeading('التواصل وساعات العمل')}
        ${infoRows([
          {key:'رقم التواصل',value:facility.phone,dir:'ltr'},
          {key:'ساعات العمل',value:facility.hours}
        ])}
        ${button('اتصال','text',{icon:'phone'})}
      </section>

      <section class="section-stack">
        ${sectionHeading('أطباء في هذا الفرع','')}
        ${doctorCard()}
      </section>

      <section class="section-stack">
        ${sectionHeading('خدمات متاحة','')}
        ${serviceCard('استشارة طب الأسرة','15,000 ر.ي','الدفع الكامل إلكترونيًا')}
        ${serviceCard('متابعة طبية','12,000 ر.ي','الدفع في المنشأة')}
      </section>

      ${notice('المواعيد المعروضة هي السعة المنشورة في عافيتك وليست كامل جدول المنشأة.','info')}
    </div>`;
  }

  register({
    id:'PAT-05',title:'تفاصيل المنشأة والفرع',defaultState:'loaded',
    states:['loaded','location-unavailable','loading','error'],
    render:(state)=>shell({screenId:'PAT-05',title:'تفاصيل المنشأة والفرع',body:PAT05Body(state)})
  });
}
