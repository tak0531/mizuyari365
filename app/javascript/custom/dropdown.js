document.addEventListener('turbo:load', function() {
    const headerBtnContainer = document.getElementById('headerBtnContainer');
    const headerDropdown = document.getElementById('headerDropdown');

    if (headerBtnContainer) {
        headerBtnContainer.addEventListener('mouseover', function() {
          headerDropdown.style.display = 'block';
        });
        headerBtnContainer.addEventListener('mouseout', function() {
          headerDropdown.style.display = 'none';
        });
    }
  });


  document.addEventListener('turbo:load', function() {
    const header2BtnContainer = document.getElementById('header2BtnContainer');
    const header2Dropdown = document.getElementById('header2Dropdown');

    if (header2BtnContainer) {
        header2BtnContainer.addEventListener('mouseover', function() {
          header2Dropdown.style.display = 'block';
        });
        header2BtnContainer.addEventListener('mouseout', function() {
          header2Dropdown.style.display = 'none';
        });
    }
  });
