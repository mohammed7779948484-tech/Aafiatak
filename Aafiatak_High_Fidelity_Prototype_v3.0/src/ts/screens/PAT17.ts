
namespace AAF {
  function PAT17Body(state:string):string {
    const error = state==='validation-error';
    const saveFailed = state==='save-failed';
    const saved = state==='saved';
    const offline = state==='offline';
    const saving = state==='saving';

    return `<div class="screen-stack">
      ${saved?notice('تم حفظ التغييرات بنجاح.','success'):''}
      ${saveFailed?notice('تعذر حفظ التغييرات. احتفظنا ببياناتك، حاول مرة أخرى.','error'):''}
      ${offline?notice('لا يمكن حفظ التغييرات دون اتصال. ستبقى القيم المدخلة كما هي.','warning'):''}
      ${saving?notice('جارٍ حفظ التغييرات مع إبقاء البيانات الحالية ظاهرة.','info'):''}

      <div class="form-stack">
        ${inputField(
          'الاسم الكامل',
          error?'أ':'أحمد بلال',
          error?'أدخل الاسم الكامل كما تريد ظهوره في حسابك.':'يمكنك تعديل الاسم وحفظ التغييرات عند الانتهاء.',
          error?'error':'default'
        )}
      </div>

      <section class="surface pad section-stack">
        ${sectionHeading('رقم الهاتف الموثق')}
        <div class="phone-preview">+[رمز الدولة] ••• ••15</div>
        <div class="body-sm text-secondary">رقم الهاتف هو هوية الدخول الموثقة ولا يتم تعديله من هذا الحقل.</div>
      </section>

      ${button(
        saving?'جارٍ الحفظ…':'حفظ التغييرات',
        'primary',
        {block:true,disabled:saving||offline,nav:'PAT-17:saved'}
      )}
    </div>`;
  }

  register({
    id:'PAT-17',title:'تعديل الملف الشخصي',defaultState:'editing',
    states:['pristine','editing','validation-error','saving','saved','save-failed','offline'],
    render:(state)=>shell({screenId:'PAT-17',title:'تعديل البيانات',body:PAT17Body(state)})
  });
}
