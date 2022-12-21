const socket = io();

let searchDiv = document.getElementById("Search");
let searchInput = document.getElementById("searchInput");
let start = 1;

socket.on("coursesSearched", function (coursesSearched) {
    let i = 0;
    for (let k = 0; k < coursesSearched.length; k++) {
        if (coursesSearched.length < searchDiv.children.length && coursesSearched[k].CourseID.toString() != searchDiv.children[i].classList[2].toString()) {
            // change image as well when it is here.
            searchDiv.removeChild(searchDiv.children[i]);
            k--;
            i--;
        }
        else if (!searchDiv.children[i] || (coursesSearched.length > searchDiv.children.length && coursesSearched[k].CourseID.toString() != searchDiv.children[i].classList[2].toString())) {

            var newElement = new DOMParser().parseFromString(`
            
            <div class="p-2 bd-highlight">
                <div class="flex-item">
                    <div class="flex-shrink-0">
                        <img src="..." alt="...">
                    </div>
                    <div>
                        <a href="/courseinfo/` + coursesSearched[k].CourseID + `>"><h5>` + coursesSearched[k].Prefix + `></h5></a>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6>` + coursesSearched[k].Course_Name + `</h6>
                    </div>
                </div>
            </div>
            
            `, "text/html").body.children[0];


            newElement.classList.add(coursesSearched[k].CourseID);
            if (searchDiv.children[i]) {
                searchDiv.insertBefore(newElement, searchDiv.children[i]);
            }
            else {
                searchDiv.appendChild(newElement);
            }

        }
        i++;
    };
    let j = i;
    while (searchDiv.children.length != i) {
        searchDiv.removeChild(searchDiv.children[j]);
    }
});
window.onload = function (ev) {
    searchInput.addEventListener("input", function (ev1) {
        socket.emit("searchOfcourses", this.value);
    });
}