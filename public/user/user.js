// Get the modal elements
var modal1 = document.getElementById("modal-1");
var modal2 = document.getElementById("modal-2");
var modal3 = document.getElementById("modal-3");
var modal4 = document.getElementById("modal-4");
var modal5 = document.getElementById("modal-5");
// Get the button elements
var btn1 = document.getElementById("modal-btn-1");
var btn2 = document.getElementById("modal-btn-2");
var btn3 = document.getElementById("modal-btn-3");
var btn5 = document.getElementById("modal-btn-4");
var btn4 = document.getElementById("modal-btn-5");
// Get the close elements
var close1 = modal1.getElementsByClassName("close")[0];
var close2 = modal2.getElementsByClassName("close")[0];
var close3 = modal3.getElementsByClassName("close")[0];
var close4 = modal2.getElementsByClassName("close")[0];
var close5 = modal3.getElementsByClassName("close")[0];
// When the user clicks the button, open the corresponding modal and close others
btn1.onclick = function() {
  modal1.style.display = "block";
  modal2.style.display = "none";
  modal3.style.display = "none";
}

btn2.onclick = function() {
  modal1.style.display = "none";
  modal2.style.display = "block";
  modal3.style.display = "none";
}

btn3.onclick = function() {
  modal1.style.display = "none";
  modal2.style.display = "none";
  modal3.style.display = "block";
}
btn5.onclick = function() {
  modal1.style.display = "none";
  modal2.style.display = "none";
  modal5.style.display = "block";
  modal2.style.display = "none";
  modal4.style.display = "none";
}

btn4.onclick = function() {
  modal1.style.display = "none";
  modal2.style.display = "none";
  modal4.style.display = "block";
  modal5.style.display = "none";
  modal3.style.display = "none";
}

 

// When the user clicks on the close button, close the corresponding modal
close1.onclick = function() {
  modal1.style.display = "none";
}

close2.onclick = function() {
  modal2.style.display = "none";
}

close3.onclick = function() {
  modal3.style.display = "none";
}
close4.onclick = function() {
  modal4.style.display = "none";
}
close5.onclick = function() {
  modal5.style.display = "none";
}

// When the user clicks outside the modal, close the corresponding modal
window.onclick = function(event) {
  if (event.target == modal1) {
    modal1.style.display = "none";
  } else if (event.target == modal2) {
    modal2.style.display = "none";
  } else if (event.target == modal3) {
    modal3.style.display = "none";
  }
  else if (event.target == modal4) {
    modal4.style.display = "none";
  }
  else if (event.target == modal5) {
    modal5.style.display = "none";
  }
}

// When the user drags down the modal, close the corresponding modal
var modals = document.getElementsByClassName("modal");
for (var i = 0; i < modals.length; i++) {
  var modal = modals[i];
  var header = modal.getElementsByClassName("modal-header")[0];
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  header.onmousedown = dragMouseDown;
  header.addEventListener("touchstart", dragMouseDown, { passive: false });

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    pos3 = e.clientX || e.touches[0].clientX;
    pos4 = e.clientY || e.touches[0].clientY;
    document.onmouseup = closeDragElement;
    document.addEventListener("touchend", closeDragElement, { passive: false });
    document.onmousemove = elementDrag;
    document.addEventListener("touchmove", elementDrag, { passive: false });
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    pos1 = pos3 - (e.clientX || e.touches[0].clientX);
    pos2 = pos4 - (e.clientY || e.touches[0].clientY);
    pos3 = e.clientX || e.touches[0].clientX;
    pos4 = e.clientY || e.touches[0].clientY;
    modal.style.top = (modal.offsetTop - pos2) + "px";
    modal.style.left = (modal.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    document.onmouseup = null;
  }} 
    