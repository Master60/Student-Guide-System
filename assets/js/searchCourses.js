const socket = io();

let searchDiv = document.getElementById("Search");
let searchInput = document.getElementById("searchInput");
let start = 1;

socket.on("coursesSearched", function (coursesSearched) {
    searchDiv.innerHTML = "";
    coursesSearched.forEach(function (val) {
        searchDiv.innerHTML += `
        
        <div class="p-2 bd-highlight">
                    <div class="flex-item">
                    <div class="flex-shrink-0">
                        <img src="..." alt="...">
                    </div>
                    <div>
                        <a href="/courseinfo/` + val.CourseID + `>"><h5>` + val.Prefix + `></h5></a>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6>` + val.Course_Name + `</h6>
                    </div>
                    </div>
                </div>
        
        `;
    });
});
window.onload = function (ev) {
    searchInput.addEventListener("input", function (ev1) {
        socket.emit("searchOfcourses", this.value);
    });
}