const initImagePreview = () => {
  const input = document.getElementById("image-input");
  const preview = document.getElementById("image-preview");

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
      preview.src = "#";
      preview.classList.add("hidden");
    }
  });
};

export { initImagePreview };