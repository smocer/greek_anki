/* A stable entry page loads a fresh release pointer; app files have unique URLs.
   Browser storage stays at the same origin across weekly deployments. */
(() => {
  const russian = navigator.language.toLowerCase().startsWith('ru');
  const message = document.getElementById('loading-message');
  const retry = document.getElementById('retry');
  message.textContent = russian ? 'Открываем уроки…' : 'Opening your lessons…';
  retry.textContent = russian ? 'Попробовать снова' : 'Try again';
  retry.addEventListener('click', () => location.reload());

  function showError(error) {
    console.error('Greek Anki could not start:', error);
    message.textContent = russian
      ? 'Не удалось открыть уроки. Проверьте интернет и попробуйте ещё раз.'
      : 'Could not open your lessons. Check your connection and try again.';
    retry.hidden = false;
  }

  async function readRelease() {
    const url = new URL('release.json', document.baseURI);
    // Bypass both browser and CDN caching of the tiny release pointer.
    url.searchParams.set('check', Date.now().toString());
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 15000);
    let response;
    try {
      response = await fetch(url, {cache: 'no-store', signal: controller.signal});
    } finally {
      clearTimeout(timeout);
    }
    if (!response.ok) throw new Error(`Release request failed: ${response.status}`);
    const release = await response.json();
    if (typeof release.id !== 'string' ||
        !/^(\.\/|app\/[a-f0-9]{16}\/)$/.test(release.base)) {
      throw new Error('Invalid release metadata');
    }
    return release;
  }

  async function start() {
    const release = await readRelease();
    window.greekAnki = {
      buildId: release.id,
      checkForUpdate: async () => (await readRelease()).id !== release.id,
      reload: () => location.reload(),
      showError,
    };
    const script = document.createElement('script');
    script.src = new URL(`${release.base}flutter_bootstrap.js`, document.baseURI).href;
    script.addEventListener('error', () => showError(new Error('App download failed')));
    document.body.appendChild(script);
  }

  start().catch(showError);
})();
