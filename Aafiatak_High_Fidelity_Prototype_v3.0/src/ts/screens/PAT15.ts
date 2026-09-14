
namespace AAF {
  function notificationItem(n:{kind:string;title:string;message:string;time:string;unread:boolean}):string {
    const iconName=n.kind==='queue'?'queue':n.kind==='payment'?'card':'calendar';
    const nav=n.kind==='payment'?'PAT-13:succeeded':'PAT-12';
    return `<article class="notification-item ${n.unread?'unread':''}" data-nav="${nav}">
      <div>
        <div class="title">${n.title}</div>
        <div class="message">${n.message}</div>
        <div class="time">${n.time}${n.unread?' · غير مقروء':''}</div>
      </div>
      <div class="status-icon ${n.kind==='queue'?'primary':n.kind==='payment'?'success':'info'}" style="width:40px;height:40px;border-radius:12px">${icon(iconName)}</div>
    </article>`;
  }

  function PAT15Body(state:string):string {
    if(state==='loading') return skeleton([{h:110},{h:110},{h:110}]);
    if(state==='empty') return emptyState('لا توجد إشعارات حتى الآن','ستظهر هنا إشعارات الحجز والدفع والزيارة والتوفر عند حدوثها.');
    if(state==='offline' || state==='error') return `<div class="screen-stack">
      ${notice(state==='offline'?'أنت غير متصل. نعرض آخر إشعارات محفوظة، وقد تتغير الحالة عند الاتصال.':'تعذر تحديث الإشعارات الآن. يمكنك إعادة المحاولة.','info')}
      ${notifications.map(notificationItem).join('')}
      ${button('إعادة المحاولة','text',{block:true,icon:'refresh',nav:'PAT-15'})}
    </div>`;
    if(state==='deep-link-stale') return `<div class="screen-stack">
      ${notice('تم تحديث حالة هذا الموعد. سنعرض لك الحالة الحالية بدل تنفيذ إجراء قديم من الإشعار.','warning')}
      ${notifications.map(notificationItem).join('')}
    </div>`;

    const data = state==='populated-read' ? notifications.map(n=>({...n,unread:false})) : notifications;
    return `<div class="notification-list">${data.map(notificationItem).join('')}</div>`;
  }

  register({
    id:'PAT-15',title:'مركز الإشعارات',defaultState:'populated-unread',
    states:['loading','empty','populated-unread','populated-read','deep-link-stale','offline','error'],
    render:(state)=>shell({screenId:'PAT-15',title:'الإشعارات',body:PAT15Body(state)})
  });
}
