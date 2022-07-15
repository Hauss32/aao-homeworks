document.addEventListener("DOMContentLoaded", () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });



  // adding SF places as list items

  const newPlaceInput = document.getElementsByClassName( "favorite-input" )[0];
  const newPlaceSubmit = document.getElementsByClassName("favorite-submit")[0];

  newPlaceSubmit.addEventListener( 'click', event => {
    event.preventDefault();

    const inputValue = newPlaceInput.value;

    if( inputValue ) {
      const placesUl = document.getElementById('sf-places');
      const newLi = document.createElement('li');
      newLi.innerHTML = inputValue;

      placesUl.append(newLi);

      newPlaceInput.value = '';
    }
  })



  // adding new photos

  const photoShowBtn = document.getElementsByClassName('photo-show-button')[0];
  const photoForm = document.getElementsByClassName('photo-form-container')[0];

  photoShowBtn.addEventListener( 'click', () => {
    photoForm.classList.toggle('hidden');
  })

  const photoUrlInput = document.getElementsByClassName("photo-url-input")[0];
  const photoUrlSubmit = document.getElementsByClassName("photo-url-submit")[0];

  photoUrlSubmit.addEventListener('click', event => {
    event.preventDefault();

    const inputValue = photoUrlInput.value;

    if (inputValue) {
      const photosUl = document.getElementsByClassName('dog-photos')[0];
      const newLi = document.createElement('li');
      const newImg = document.createElement('img');
      newImg.setAttribute( 'src', inputValue );

      newLi.append(newImg);
      photosUl.append(newLi);

      photoUrlInput.value = '';
    }
  })



});
