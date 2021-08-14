document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('profile_image_upload')) {
    const imageList = document.getElementById('image-list')

    function createImageHTML(blob) {
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('class', 'card-img-top')
      imageList.appendChild(blobImage);
    }

    document.getElementById('profile_image_upload').addEventListener('change', (e) => {
      const imageContent = document.querySelector('img');
      if (imageContent) {
        imageContent.remove();
      }
      const file = e.target.files[0]; 
      const blob = window.URL.createObjectURL(file); 
      createImageHTML(blob);
    });
  }
});
  