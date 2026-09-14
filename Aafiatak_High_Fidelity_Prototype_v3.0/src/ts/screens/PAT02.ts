
namespace AAF {
  function PAT02Results():string {
    const row=(tone:string,type:string,title:string,sub:string,nav:string)=>`<article class="list-row interactive" data-nav="${nav}">
      <div><div>${badge(type,tone)}</div><div style="margin-top:8px" class="title">${title}</div><div class="subtitle">${sub}</div></div>
      <div class="chevron">${icon('chevron')}</div>
    </article>`;
    return `<div class="list">
      ${row('secondary','طبيب','د. سارة عبدالله','طب الأسرة · مركز عافيتك التخصصي','PAT-03')}
      ${row('primary','خدمة','استشارة طب الأسرة','15,000 ر.ي · الدفع الكامل إلكترونيًا','PAT-04')}
      ${row('info','منشأة','مركز عافيتك التخصصي · فرع التحرير','صنعاء · شارع التحرير','PAT-05')}
    </div>`;
  }

  function PAT02Body(state:string):string {
    if(state==='searching') return `<div class="screen-stack">
      ${searchField('طب الأسرة')}
      ${skeleton([{h:40,w:'72%'},{h:106},{h:106},{h:106}])}
    </div>`;

    if(state==='offline' || state==='error') return `<div class="screen-stack">
      ${searchField('طب الأسرة')}
      ${notice(state==='offline'?'تعذر تحديث النتائج لأنك غير متصل. سنُبقي الاستعلام ظاهرًا لتتمكن من المحاولة مجددًا.':'تعذر تحميل نتائج البحث. احتفظنا بعبارة البحث ويمكنك إعادة المحاولة.','error')}
      ${button('إعادة المحاولة','primary',{block:true,icon:'refresh',nav:'PAT-02:results'})}
    </div>`;

    if(state==='initial') return `<div class="screen-stack">
      ${searchField()}
      <section class="surface empty-state">
        <div class="status-icon primary">${icon('search')}</div>
        <div class="title">ابحث عن الرعاية المناسبة</div>
        <div class="copy">يمكنك البحث باسم الطبيب أو التخصص أو القسم أو الخدمة.</div>
      </section>
    </div>`;

    if(state==='no-results') return `<div class="screen-stack">
      ${searchField('طب الأعصاب للأطفال')}
      ${chips([{label:'الكل',active:true},{label:'أطباء'},{label:'خدمات'},{label:'منشآت'}])}
      <section class="surface empty-state">
        <div class="status-icon info">${icon('search')}</div>
        <div class="title">لا توجد نتائج مطابقة</div>
        <div class="copy">لم نعثر على نتائج لعبارة البحث الحالية. يمكنك تعديلها أو العودة لتصفح الخيارات المتاحة.</div>
        ${button('مسح البحث','tonal',{nav:'PAT-02:initial'})}
      </section>
    </div>`;

    return `<div class="screen-stack">
      ${searchField('طب الأسرة')}
      ${chips([{label:'الكل',active:true},{label:'أطباء'},{label:'خدمات'},{label:'منشآت'}])}
      <div class="search-summary"><div class="h3">النتائج</div><div class="caption">3 نتائج</div></div>
      ${PAT02Results()}
    </div>`;
  }

  register({
    id:'PAT-02',title:'البحث والنتائج',defaultState:'results',
    states:['initial','searching','results','no-results','offline','error'],
    render:(state)=>shell({screenId:'PAT-02',title:'البحث والنتائج',body:PAT02Body(state)})
  });
}
