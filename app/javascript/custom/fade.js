function fadeInImage() {
    // 画像の要素を取得
    const image = document.getElementById('fadeInImage');
    // 画像の不透明度を徐々に変化させるアニメーションを適用
    let opacity = 0;
    const intervalId = setInterval(function() {
      opacity += 0.01; // 不透明度を少しずつ増やす
      image.style.opacity = opacity;
      if (opacity >= 1) {
        clearInterval(intervalId);
      }
    }, 20);
  }
  // リダイレクト後に画像を徐々に表示する関数を呼び出す
  fadeInImage();