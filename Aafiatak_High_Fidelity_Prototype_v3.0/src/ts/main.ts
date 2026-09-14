
namespace AAF {
  export interface RouteTarget { screen: string; state?: string; }

  export function parseRoute(): RouteTarget {
    const hash = location.hash.replace(/^#\/?/, '');
    if (hash) {
      const parts = hash.split('/').filter(Boolean);
      if (parts[0]) {
        return { screen: parts[0].toUpperCase(), state: parts[1] ? parts[1].toLowerCase() : undefined };
      }
    }
    const qs = new URLSearchParams(location.search);
    const qsScreen = qs.get('screen');
    return { screen: (qsScreen || 'PAT-01').toUpperCase(), state: qs.get('state') || undefined };
  }

  export function navigate(id: string, state?: string): void {
    const target = '#/' + id + (state ? '/' + state : '');
    if (location.hash === target) { AAF.render(); return; }
    location.hash = target;
  }

  export function render(): void {
    const route = AAF.parseRoute();
    const screen = registry[route.screen];
    if (!screen) {
      document.querySelector('#app')!.innerHTML = `<div class="prototype-canvas"><div class="phone"><main class="screen">${emptyState('الشاشة غير متاحة في هذه النسخة','سيتم إضافتها ضمن مسار التنفيذ المرحلي.','العودة إلى الرئيسية','PAT-01')}</main></div></div>`;
      document.title = 'عافيتك — النموذج التفاعلي';
      return;
    }
    const requested = ((((window as any).__AAF_STATE__) || route.state || screen.defaultState));
    const state = String(requested).toLowerCase();
    document.querySelector('#app')!.innerHTML = `<div class="prototype-canvas">${screen.render(state)}</div>`;
    document.title = `${screen.title} — عافيتك`;
    window.scrollTo(0, 0);
  }

  export function mount(): void {
    document.addEventListener('click', (event) => {
      const target = event.target as Element;
      if (!target || !(target as Element).closest) return;
      const navEl = target.closest('[data-nav]') as HTMLElement | null;
      if (navEl) {
        event.preventDefault();
        const nav = navEl.getAttribute('data-nav') || '';
        if (nav === 'back') {
          if (history.length > 1) history.back(); else AAF.navigate('PAT-01');
          return;
        }
        const parts = nav.split(':');
        const id = parts[0] ? parts[0].toUpperCase() : AAF.parseRoute().screen;
        AAF.navigate(id, parts[1] ? parts[1].toLowerCase() : undefined);
        return;
      }
      const toggleEl = target.closest('[data-toggle]') as HTMLElement | null;
      if (toggleEl && toggleEl.parentElement) {
        const group = toggleEl.parentElement;
        Array.prototype.forEach.call(group.querySelectorAll('[data-toggle]'), (el: Element) => el.classList.remove('active'));
        toggleEl.classList.add('active');
      }
    });
    window.addEventListener('hashchange', AAF.render);
    AAF.render();
  }
}
AAF.mount();
