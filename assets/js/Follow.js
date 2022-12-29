var socket = io();

window.onload = function (ev) {
    var b = document.getElementById("Following").innerText;
    document.getElementById("Following").addEventListener("click", function (ev) {
        if (b == "Follow") {
            socket.emit("AddFollow", {
                CourseID: document.getElementById("Byeeeee").innerText,
                UserID: document.getElementById("Hi").innerText
            });
            this.innerText = "Unfollow";
            b = document.getElementById("Following").innerText;
        }
        else {
            socket.emit("DeleteFollow", {
                CourseID: document.getElementById("Byeeeee").innerText,
                UserID: document.getElementById("Hi").innerText
            });
            this.innerText = "Follow";
            b = document.getElementById("Following").innerText;
        }
    })

}