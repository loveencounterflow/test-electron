(function() {
  var BrowserWindow, CND, alert, app, badge, debug, echo, help, info, ipc, log, njs_fs, options, rpr, urge, warn, whisper, windows;

  njs_fs = require('fs');

  CND = require('cnd');

  rpr = CND.rpr;

  badge = 'test-electron/main';

  log = CND.get_logger('plain', badge);

  info = CND.get_logger('info', badge);

  whisper = CND.get_logger('whisper', badge);

  alert = CND.get_logger('alert', badge);

  debug = CND.get_logger('debug', badge);

  warn = CND.get_logger('warn', badge);

  help = CND.get_logger('help', badge);

  urge = CND.get_logger('urge', badge);

  echo = CND.echo.bind(CND);

  app = require('app');

  BrowserWindow = require('browser-window');

  ipc = require('ipc');

  options = {
    windows: {
      main: {
        width: 1200,
        height: 800,
        dev: true
      },
      settings: {
        width: 400,
        height: 400,
        show: false
      }
    }
  };

  windows = {};

  app.on('ready', function() {
    log("app ready");
    return (function() {
      var file_route, ref, ref1, ref2, results, show_devtools, template_name, url, w, window_name, window_settings;
      ref = options['windows'];
      results = [];
      for (window_name in ref) {
        window_settings = ref[window_name];
        w = new BrowserWindow(window_settings);
        template_name = (ref1 = window_settings['template']) != null ? ref1 : window_name;
        file_route = __dirname + '/' + template_name + '.html';
        if (!njs_fs.existsSync(file_route)) {

          /* makeshift measure until https://github.com/atom/electron/issues/2213 gets resolved */
          alert('©2213', "missing file " + (rpr(file_route)));
          throw new Error("missing file " + (rpr(file_route)));
        }
        url = 'file://' + file_route;
        show_devtools = (ref2 = window_settings['dev']) != null ? ref2 : false;
        windows[window_name] = w;
        w.loadUrl(url);
        if (show_devtools) {
          w.openDevTools();
        }
        results.push(log(url));
      }
      return results;
    })();
  });

  app.on('gpu-process-crashed', function() {
    return whisper('gpu-process-crashed');
  });

  app.on('select-certificate', function() {
    return whisper('select-certificate');
  });

  app.on('activate-with-no-open-windows', function() {
    return whisper('activate-with-no-open-windows');
  });

  app.on('before-quit', function() {
    return whisper('before-quit');
  });

  app.on('browser-window-blur', function() {
    return whisper('browser-window-blur');
  });

  app.on('browser-window-focus', function() {
    return whisper('browser-window-focus');
  });

  app.on('open-file', function() {
    return whisper('open-file');
  });

  app.on('open-url', function() {
    return whisper('open-url');
  });

  app.on('quit', function() {
    return whisper('quit');
  });

  app.on('ready', function() {
    return whisper('ready');
  });

  app.on('will-finish-launching', function() {
    return whisper('will-finish-launching');
  });

  app.on('will-quit', function() {
    return whisper('will-quit');
  });

  app.on('window-all-closed', function() {
    return whisper('window-all-closed');
  });

  ipc.on('show', function(event, window_name) {
    var w;
    help("show: " + (rpr(window_name)));
    if ((w = windows[window_name]) == null) {

      /* makeshift measure until https://github.com/atom/electron/issues/2213 gets resolved */
      alert('©2213', "unknwon window " + (rpr(window_name)));
      throw new Error("unknwon window " + (rpr(window_name)));
    }
    return w.show();
  });

  ipc.on('hide', function(event, window_name) {
    var w;
    help("hide: " + (rpr(window_name)));
    if ((w = windows[window_name]) == null) {

      /* makeshift measure until https://github.com/atom/electron/issues/2213 gets resolved */
      alert('©2213', "unknwon window " + (rpr(window_name)));
      throw new Error("unknwon window " + (rpr(window_name)));
    }
    return w.hide();
  });

}).call(this);

//# sourceMappingURL=../sourcemaps/app.js.map