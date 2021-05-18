function count () {
  const introduceText = document.getElementById("introduce_text");
  const counter = document.getElementById("counter")
  counter.innerHTML = introduceText.value.length

  introduceText.addEventListener("keyup", () => {
    counter.innerHTML = introduceText.value.length
  });
}

window.addEventListener('load', count);