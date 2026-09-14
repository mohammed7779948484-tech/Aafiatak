
namespace AAF {
  const paths: Record<string,string> = {
    bell:'<path d="M18 8a6 6 0 0 0-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9"/><path d="M10 21h4"/>',
    search:'<circle cx="11" cy="11" r="7"/><path d="m20 20-4-4"/>',
    doctor:'<circle cx="12" cy="8" r="3"/><path d="M5 20c.8-4.2 3.2-6 7-6s6.2 1.8 7 6"/>',
    service:'<path d="M12 4v16M4 12h16"/><circle cx="12" cy="12" r="9"/>',
    place:'<path d="M20 10c0 5-8 11-8 11S4 15 4 10a8 8 0 1 1 16 0Z"/><circle cx="12" cy="10" r="2.5"/>',
    arrow:'<path d="M5 12h14M13 6l6 6-6 6"/>',
    chevron:'<path d="m9 18 6-6-6-6"/>',
    back:'<path d="M19 12H5"/><path d="m11 18-6-6 6-6"/>',
    home:'<path d="M3 11 12 4l9 7v9h-6v-6H9v6H3z"/>',
    calendar:'<rect x="3" y="5" width="18" height="16" rx="3"/><path d="M8 3v4M16 3v4M3 10h18"/>',
    user:'<circle cx="12" cy="8" r="4"/><path d="M4 21c1-5 4-7 8-7s7 2 8 7"/>',
    check:'<path d="M20 6 9 17l-5-5"/>',
    clock:'<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
    warning:'<path d="M12 3 2 21h20L12 3Z"/><path d="M12 9v5"/><path d="M12 17h.01"/>',
    close:'<path d="M18 6 6 18M6 6l12 12"/>',
    qr:'<rect x="4" y="4" width="6" height="6"/><rect x="14" y="4" width="6" height="6"/><rect x="4" y="14" width="6" height="6"/><path d="M14 14h2v2h-2zM18 14h2v6h-6v-2h4z"/>',
    card:'<rect x="3" y="6" width="18" height="12" rx="3"/><path d="M3 10h18"/>',
    queue:'<path d="M6 7h12M6 12h10M6 17h8"/>',
    phone:'<path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1A19.3 19.3 0 0 1 5.2 13 19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1 1 .4 2 .7 2.9a2 2 0 0 1-.5 2.1L8 10a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5c.9.3 1.9.6 2.9.7A2 2 0 0 1 22 16.9Z"/>',
    info:'<circle cx="12" cy="12" r="9"/><path d="M12 11v5"/><path d="M12 8h.01"/>',
    edit:'<path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L8 18l-4 1 1-4Z"/>',
    logout:'<path d="M10 17l5-5-5-5"/><path d="M15 12H3"/><path d="M21 19V5a2 2 0 0 0-2-2h-6"/>',
    refresh:'<path d="M20 11a8 8 0 1 0 2 5"/><path d="M20 4v7h-7"/>',
    building:'<path d="M4 21V3h12v18M16 8h4v13M8 7h4M8 11h4M8 15h4M2 21h20"/>',
    money:'<circle cx="12" cy="12" r="9"/><path d="M16 8.5c-.7-.8-1.8-1.2-3-1.2-1.7 0-3 .8-3 2s1 1.8 3 2.2 3 1 3 2.3-1.3 2.2-3 2.2c-1.3 0-2.5-.5-3.2-1.3M13 5.8v12.4"/>',
    location:'<path d="M20 10c0 5-8 11-8 11S4 15 4 10a8 8 0 1 1 16 0Z"/><circle cx="12" cy="10" r="2.5"/>',
    shield:'<path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10Z"/><path d="m9 12 2 2 4-4"/>',
    whats:'<path d="M20 11.5A8.5 8.5 0 0 1 7 18.7L3 20l1.3-3.9A8.5 8.5 0 1 1 20 11.5Z"/><path d="M9 8.8c.3-.8.6-.8.8-.8h.7c.2 0 .4 0 .6.5.2.5.7 1.6.8 1.7.1.1.1.3 0 .5-.1.2-.2.3-.4.5-.2.2-.3.3-.1.7.2.3.8 1.2 1.8 1.9 1.2.9 2.1 1.1 2.5 1.3.4.2.6.1.8-.1.2-.2.7-.8.9-1 .2-.3.4-.2.6-.1.3.1 1.7.8 2 .9.3.2.5.3.6.5.1.2.1 1.1-.3 2.1"/>'
  };
  export function icon(name:string, cls=''):string {
    const directional = ['arrow','chevron','back'].includes(name) ? 'rtl-mirror' : '';
    const classes = [directional,cls].filter(Boolean).join(' ');
    return `<svg class="${classes}" viewBox="0 0 24 24" aria-hidden="true">${paths[name] || paths.info}</svg>`;
  }
}
