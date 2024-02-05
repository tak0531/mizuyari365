document.addEventListener('turbolinks:load', function() {
      const mypageBtnContainer = document.getElementById('mypageBtnContainer');
      const mypageDropdown = document.getElementById('mypageDropdown');
    
      if (mypageBtnContainer) {
        mypageBtnContainer.addEventListener('mouseover', function() {
          mypageDropdown.style.display = 'block';
        });
    
        mypageBtnContainer.addEventListener('mouseout', function() {
          mypageDropdown.style.display = 'none';
        });
      }
    });      
