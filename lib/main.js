(function() {
  var Menu, ipc, menu, remote;

  remote = require('remote');

  ipc = require('ipc');

  Menu = remote.require('menu');

  menu = Menu.buildFromTemplate([
    {
      label: "name of app",
      submenu: [
        {
          label: 'Super Label here!',
          click: function() {
            console.log("clicked");
            return ipc.send('show', 'settings');
          }
        }
      ]
    }
  ]);

  Menu.setApplicationMenu(menu);

}).call(this);

//# sourceMappingURL=../sourcemaps/main.js.map