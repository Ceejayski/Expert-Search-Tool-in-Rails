const shorten = require("jquery-shorten");

$("document").ready(function () {
  setTimeout(function () {
    $(".alert").slideUp();
  }, 6000);
});

function getLineHeight(el) {
  var temp = document.createElement(el.nodeName),
    ret;
  temp.setAttribute(
    "style",
    "margin:0; padding:0; " +
      "font-family:" +
      (el.style.fontFamily || "inherit") +
      "; " +
      "font-size:" +
      (el.style.fontSize || "inherit")
  );
  temp.innerHTML = "A";

  el.parentNode.appendChild(temp);
  ret = temp.clientHeight;
  temp.parentNode.removeChild(temp);

  return ret;
}

function showMore() {
  const parag = document.querySelectorAll(".desc");
  console.log(parag);
  for (var i = 0, element; (element = parag[i]); i++) {
    //work with element
    let height = element.offsetHeight;
    let line_height = getLineHeight(element);
    let text = element.innerText
    let lines = height / line_height;
    console.log(lines);
    const showMore = document.querySelectorAll(".show-more");
    if (lines > 1) {
      showMore[i].classList.remove("dnone");
      element.classList.add("h-em");
      showMore[i].onclick = (e) => {
        let tag = e.target

        if(tag.innerText === 'show more'){
          tag.innerText = 'show less'
          tag.previousElementSibling.classList.remove('h-em')
        }else {
          tag.innerText = 'show more'
          tag.previousElementSibling.classList.add('h-em')
        }
        e.preventDefault();
      }
    } else {
      showMore[i].classList.add("dnone");
    }
  }
}



window.onload = () => {
  showMore()
} 