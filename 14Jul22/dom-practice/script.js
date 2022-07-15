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

  // --- your code here!



});
