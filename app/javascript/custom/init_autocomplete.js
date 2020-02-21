import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('bar_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

const initAutocompleteSearch = () => {
  const addressInput = document.getElementById('search_query');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
export { initAutocompleteSearch };
