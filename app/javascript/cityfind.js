
    const stateSelect = document.getElementById('state-select');
    const districtContainer = document.getElementById('district-container');
    const districtSelect = document.getElementById('district-select');

    stateSelect.addEventListener('change', function() {
      const selectedStateId = stateSelect.value;
      fetch(`https://cdn-api.co-vin.in/api/v2/admin/location/districts/${selectedStateId}`)
        .then(response => response.json())
        .then(data => {
          const districts = data.districts;
          districtSelect.innerHTML = ''; // Clear previous options
          districts.forEach(district => {
            const option = document.createElement('option');
            option.value = district.district_id;
            option.textContent = district.district_name;
            districtSelect.appendChild(option);
          });
        // Show district select input
        })
        .catch(error => {
          console.error('Error fetching districts:', error);
        });
    });
