document.addEventListener("turbo:load", function() {
  const mainImage = document.getElementById('mainImage');
  const thumbnails = document.querySelectorAll('.thumbnail-image');

  // Iterate over all thumbnails and add click event
  thumbnails.forEach(thumbnail => {
    thumbnail.addEventListener('click', function() {
      const newImageSrc = this.getAttribute('data-key'); // Get the data-key value from the thumbnail
      mainImage.src = newImageSrc; // Update the main image src
    });
  });
});
