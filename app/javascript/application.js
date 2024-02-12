import "@hotwired/turbo-rails"



document.addEventListener("DOMContentLoaded", function() {
    fadeInImage();
});

function fadeInImage() {
    var image = document.getElementById("fadeInImage");
    var opacity = 0;
    var intervalId = setInterval(function() {
        if (opacity >= 1) {
            clearInterval(intervalId);
        } else {
            opacity += 0.01; // 0.01ずつ増やす（調整可能）
            image.style.opacity = opacity;
        }
    }, 10); // 10ミリ秒ごとに実行（調整可能）
}