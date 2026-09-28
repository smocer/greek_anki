{{flutter_js}}
{{flutter_build_config}}

// Keep the whole release together, including fonts and the rendering engine.
const appBase = new URL('.', document.currentScript.src).href;
const config = {
  entrypointBaseUrl: appBase,
  assetBase: appBase,
  canvasKitBaseUrl: `${appBase}canvaskit/`,
};
_flutter.loader.load({
  config,
  onEntrypointLoaded: async (engineInitializer) => {
    try {
      const runner = await engineInitializer.initializeEngine(config);
      await runner.runApp();
      document.getElementById('loading')?.remove();
    } catch (error) {
      window.greekAnki.showError(error);
    }
  },
}).catch(window.greekAnki.showError);
