console.log('良い')

document.addEventListener("DOMContentLoaded", () => {
  const createImagePreview = (file) => {
    const reader = new FileReader();
    reader.onload = (event) => {
      const imgElement = document.createElement("img");
      imgElement.src = event.target.result;
      imgElement.classList.add("preview-image");
      const previewContainer = document.getElementById("new-image");
      if (previewContainer) {
        previewContainer.innerHTML = "";
        previewContainer.appendChild(imgElement);
      } else {
        console.error("Preview container not found.");
      }
    };
    reader.readAsDataURL(file);
  };

  const fileInput = document.getElementById("plant_image");
  if (fileInput) {
    fileInput.addEventListener("change", (event) => {
      const selectedFile = event.target.files[0];
      if (selectedFile) {
        createImagePreview(selectedFile);
      }
    });

    // Check if an image already exists
    const existingImage = document.getElementById("existing_image");
    if (existingImage && existingImage.src) {
      const imgElement = document.createElement("img");
      imgElement.src = existingImage.src;
      imgElement.classList.add("preview-image");
      const previewContainer = document.getElementById("new-image");
      if (previewContainer) {
        previewContainer.innerHTML = "";
        previewContainer.appendChild(imgElement);
      } else {
        console.error("Preview container not found.");
      }
    }
  } else {
    console.error("Element with id 'plant_image' not found.");
  }
});
