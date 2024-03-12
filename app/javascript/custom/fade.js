document.addEventListener("DOMContentLoaded", function() {
  function fadeInImage() {
    const image = document.getElementById("fadeInImage");
    if (image) { // 要素が見つかった場合のみ実行
      let opacity = 0;
      const intervalId = setInterval(function() {
        opacity += 0.01;
        image.style.opacity = opacity;
        if (opacity >= 1) {
          clearInterval(intervalId);
        }
      }, 20);
    }
  }
  fadeInImage();
});