// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"

const userId = document.getElementById('userId').textContent;
const sessionId = document.getElementById('sessionId').textContent;
const authToken = document.getElementById('authToken').textContent;

const socket = new Socket("/socket", {params: {token: authToken, sessionId: sessionId}});
socket.connect();

const channel = socket.channel('user:' + userId, {});

channel.on('join_failed', (response) => {
  console.log('join failed');
});
channel.join().receive('ok', () => console.log('---'));

