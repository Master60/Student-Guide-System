const socket = io();


window.onbeforeunload = function () {
    if (!window.location.pathname.includes("/login")) {
        socket.emit("Refer", window.location.pathname);
    }
}