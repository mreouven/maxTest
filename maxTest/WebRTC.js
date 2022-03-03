
(function() {
  if (!window.navigator) window.navigator = {};
  window.navigator.getUserMedia = function() {
    webkit.messageHandlers.callbackHandler.postMessage(arguments);
  }
})();
