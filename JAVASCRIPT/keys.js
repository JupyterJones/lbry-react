
      window.addEventListener("keydown", function(e) {
      // space and arrow keys
           if([32, 37, 38, 39, 40].indexOf(e.keyCode) > -1) {
           e.preventDefault();
           }
     }, false);

  var ie=document.all;
  var nn6=document.getElementById&&!document.all;
  var isdrag=false;
  var x,y;
  var dobj;
  function movemouse(e)
  {
    if (isdrag)
    {
      dobj.style.left = nn6 ? tx + e.clientX - x : tx + event.clientX - x;
      dobj.style.top  = nn6 ? ty + e.clientY - y : ty + event.clientY - y;
      return false;
    }
  }

  function selectmouse(e) 
  {
    var fobj       = nn6 ? e.target : event.srcElement;
    var topelement = nn6 ? "HTML" : "BODY";

    while (fobj.tagName != topelement && fobj.className != "dragme")
    {
      fobj = nn6 ? fobj.parentNode : fobj.parentElement;
    }

    if (fobj.className=="dragme")
    {
      isdrag = true;
      dobj = fobj;
      tx = parseInt(dobj.style.left+0);
      ty = parseInt(dobj.style.top+0);
      x = nn6 ? e.clientX : event.clientX;
      y = nn6 ? e.clientY : event.clientY;
      document.onmousemove=movemouse;
      return false;
    }
  }
  document.onmousedown=selectmouse;
  document.onmouseup=new Function("isdrag=false");


//-->

  function leftArrowPressed() {
    var element = document.getElementById("image1");
    element.style.left = parseInt(element.style.left) - 1 + 'px';
  }
  function rightArrowPressed() {
    var element = document.getElementById("image1");
    element.style.left = parseInt(element.style.left) + 1 + 'px';
  }
  function upArrowPressed() {
    var element = document.getElementById("image1");
    element.style.top = parseInt(element.style.top) - 1 + 'px';
  }
  function downArrowPressed() {
    var element = document.getElementById("image1");
    element.style.top = parseInt(element.style.top) + 1 + 'px';
  }

  function leftFastPressed() {
    var element = document.getElementById("image1");
    element.style.left = parseInt(element.style.left) - 10 + 'px';
  }
  function rightFastPressed() {
    var element = document.getElementById("image1");
    element.style.left = parseInt(element.style.left) + 10 + 'px';
  }
  function upFastPressed() {
    var element = document.getElementById("image1");
    element.style.top = parseInt(element.style.top) - 10 + 'px';
  }
 function downFastPressed() {
    var element = document.getElementById("image1");
    element.style.top = parseInt(element.style.top) + 10 + 'px';
  }


  function moveSelection(evt) {
    switch (evt.keyCode) {
      case 37:
      leftArrowPressed();
      break;
      case 83:
      leftFastPressed();
      break;
      case 39:
      rightArrowPressed();
      break;
      case 70:
      rightFastPressed();
      break;
      case 38:
      upArrowPressed();
      break;
      case 69:
      upFastPressed();
      break;
      case 40:
      downArrowPressed();
      break;
      case 68:
      downFastPressed();
       break;
    }
  };

  function docReady()
  {

    window.addEventListener('keydown', moveSelection);
  }

