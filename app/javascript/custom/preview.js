console.log('こんにちは')

document.addEventListener("DOMContentLoaded", function() {
  const input = document.getElementById("image-input");
  const preview = document.getElementById("image-preview");

  // フォームが読み込まれたときに画像が設定されている場合、プレビューを表示
  if (preview && preview.src !== "") {
    preview.classList.remove("hidden");
  }

  input.addEventListener("change", function() {
    const file = this.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(event) {
        preview.src = event.target.result;
        preview.classList.remove("hidden");
      }
      reader.readAsDataURL(file);
    } else {
      preview.src = "";
      preview.classList.add("hidden");
    }
  });
});