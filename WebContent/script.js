	//load the autocomplete object and the map object
	function initialize() {
	  initMap();
	  initAutocomplete();
	}
	
	var map;
	var markers;
	var myLat, myLng
	
	function initMap() {
		var geocoder;
		
		//~~~~~Cal, Fill in HERE!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		var usrAddress = "Raleigh, NC";//<%= user address string here plz %>;
		
		//This big ugly string is for testing, swap it for the line commented out below
		var eventData = JSON.parse('['
		+ '{"title":"EventID 1","MarkerID":6,"lat":35.651079,"lng":-78.706949,"EventDescription":"Something happened here be safe", "username":"Sophie", "priorityLevelID":2, "date":"04/12/2017"},'
		+ '{"title":"EventID 2","MarkerID":2,"lat":35.779928,"lng":-78.639282,"EventDescription":"test id 2", "username":"Pete", "priorityLevelID":3, "date":"04/11/2017"},'
		+ '{"title":"EventID 3","MarkerID":9,"lat":35.778633,"lng":-78.643008,"EventDescription":"test id 3", "username":"Ricardo", "priorityLevelID":4, "date":"04/10/2017"},'
		+ '{"title":"EventID 4","MarkerID":4,"lat":35.651079,"lng":-78.706949,"EventDescription":"showthing showing", "username":"Susan", "priorityLevelID":4, "date":"04/19/2016"},'
		+ '{"title":"EventID 5","MarkerID":5,"lat":39.6392566,"lng":-84.226092700000014,"EventDescription":"maybe this time", "username":"Kendra", "priorityLevelID":2, "date":"04/08/2017"},'
		+ '{"title":"EventID 6","MarkerID":6,"lat":39.6392566,"lng":-84.227092700000014,"EventDescription":"maybe this time", "username":"Edna", "priorityLevelID":2, "date":"04/07/2017"},'
		+ '{"title":"EventID 7","MarkerID":7,"lat":35.7735709,"lng":-78.676003900000012,"EventDescription":"see if this works", "username":"Marley", "priorityLevelID":4, "date":"02/06/2017"},'
		+ '{"title":"EventID 8","MarkerID":8,"lat":35.7735709,"lng":-78.675003900000012,"EventDescription":"see if this works", "username":"Harley", "priorityLevelID":2, "date":"04/05/2017"},'
		+ '{"title":"EventID 9","MarkerID":3,"lat":39.6392566,"lng":-84.226092700000014,"EventDescription":"[oasfgl;kn", "username":"Farley", "priorityLevelID":3, "date":"04/04/2017"},'
		+ '{"title":"EventID 10","MarkerID":6,"lat":39.6392566,"lng":-84.227092700000014,"EventDescription":"[oahsfgl;kn", "username":"Charlie", "priorityLevelID":2, "date":"04/03/2017"},'
		+ '{"title":"EventID 11","MarkerID":7,"lat":39.6392566,"lng":-84.228092700000014,"EventDescription":"[oahadsfgl;kn", "username":"Tarley", "priorityLevelID":2, "date":"03/02/2017"}'
		+ ']');
		
		//(<%= your arraylist.toString here plz %>);
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		geocoder = new google.maps.Geocoder();
		
		//get lat and long of user address
		geocoder.geocode({ 'address': usrAddress }, function (results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				
				myLat = results[0].geometry.location.lat();
				myLng = results[0].geometry.location.lng();
				
				var mapOptions = { //user address = map center
					center: new google.maps.LatLng(myLat, myLng),
					zoom: 15
				}
				
				//put the map
				map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
				
				//loop through json object
				markers = [];
				var contentStrings = [];
				var infowindow = new google.maps.InfoWindow({
					content: ""
				});
				for (var i = 0; i  < eventData.length; i++) 
				{
					var data = eventData[i];
					var mapIconBase = "images/map_icons/";
					var mapIconURL;
					var catName;
					
					//set up category names and icon urls
					switch(data.MarkerID) {
						
						case 2:
							mapIconURL = mapIconBase + "assault.png";
							catName = "Assault/Violence";
							break;
						case 3:
							mapIconURL = mapIconBase + "robbery.png";
							catName = "Break-In";
							break;
						case 4: 
							mapIconURL = mapIconBase + "theft.png";
							catName = "Robbery/Theft";
							break;
						case 5:
							mapIconURL = mapIconBase + "fire.png";
							catName = "Arson";
							break;
						case 6:
							mapIconURL = mapIconBase + "paint.png";
							catName = "Vandalism";
							break;
						case 7:
							mapIconURL = mapIconBase + "shooting.png";
							catName = "Shooting";
							break;
						case 8:
							mapIconURL = mapIconBase + "bomb.png";
							catName = "Explosives/Bombing";
							break;
						case 9:
							mapIconURL = mapIconBase + "weird.png";
							catName = "Suspicious Activity";
							break;
					}
					
					//create marker for each event	
					markers[i] = new google.maps.Marker({
						position: {lat: data.lat, lng: data.lng},
						latlng: new google.maps.LatLng({lat: data.lat, lng: data.lng}),
						map: map,
						id: data.title,
						categoryID: data.MarkerID,
						categoryName: catName,
						icon: mapIconURL,
						priority: data.priorityLevelID,
						details: data.EventDescription,
						user: data.username,
						date: new Date(data.date),
						index: i
					});
					
					//html for infowindows
					contentStrings[i] = ("<div><h5>" + markers[i].categoryName + " Reported Here</h5>Event details:<br>" + markers[i].details
										+ "<br><br> logged by: " + markers[i].user + "</div>");
					
					//show infowindows on click
					google.maps.event.addListener(markers[i], 'click', function() {
						infowindow.setContent(contentStrings[this.index]);
						infowindow.open(map, this);
					});
					
					
				}
			} else {
			
				alert("Geocode was not successful for the following reason: " + status);
			}
		});	
	}
	
//address field autocomplete for new event form
	var placeSearch, autocomplete;
	
	function initAutocomplete() {
		autocomplete = new google.maps.places.Autocomplete(
			(document.getElementById('autocomplete')),
			{types: ['geocode']});
			
		autocomplete.addListener('place_changed', getAddressData);
	}
	
	//finds the coords of the chosen place
	function getAddressData() {
		var place = autocomplete.getPlace();
		document.getElementById('address-lat').value = (place.geometry.location.lat());
		document.getElementById('address-lng').value = (place.geometry.location.lng());
	}
	
	//asks for user's location to suggest places
	function geolocate() {
		if (navigator.geolocation) {
		  navigator.geolocation.getCurrentPosition(function(position) {
			var geolocation = {
			  lat: position.coords.latitude,
			  lng: position.coords.longitude
			};
			var circle = new google.maps.Circle({
			  center: geolocation,
			  radius: position.coords.accuracy
			});
			autocomplete.setBounds(circle.getBounds());
		  });
		}
	}
	
	//collect all elements that hold user filter input
	var priorityFilters = document.getElementsByName("priority");
	var categoryFilters = document.getElementsByName("category");
	var timeFilter = document.getElementsByName("time");
	var proximityFilter = document.getElementsByName("proximity");
	
	function resetFilters() {
		
		for (i = 0; i < priorityFilters.length; i++) 
			priorityFilters[i].checked = false;
			
		for (i = 0; i < categoryFilters.length; i++) 
			categoryFilters[i].checked = false;
			
		timeFilter[0].checked = true;
		
		proximityFilter[0].checked = true;
		
	}
	
	function filterMarkers() {
		
		
		//declare & initialize currentDate, without the time data
		var currentDate = new Date();
		currentDate.setHours(0);
		currentDate.setMinutes(0);
		currentDate.setSeconds(0);
		currentDate.setMilliseconds(0);
		
		//find out if priority/category are being filtered
		var pChecked = false;
		var cChecked = false;
		var tValue;
		var pValue;
		
		//pChecked will return true after loop if any priority boxes are checked
		for (i = 0; i < priorityFilters.length; i++) 
			if (priorityFilters[i].checked) pChecked = true;
		
		//cChecked will return true after loop if any category boxes are checked
		for (i = 0; i < categoryFilters.length; i++) 
			if (categoryFilters[i].checked) cChecked = true;
		
		//find out which time frame is selected
		for (i = 0; i < timeFilter.length; i++)
			if (timeFilter[i].checked) tValue = timeFilter[i].value;

		//find out which proximity is selected
		for (i = 0; i < proximityFilter.length; i++) 
			if (proximityFilter[i].checked) pValue = proximityFilter[i].value;
		
		//set visibility of each marker to false
		for(i = 0; i < markers.length; i++) markers[i].setVisible(false);
		
		//requalify markers via this loop, one by one, making sure they match all selected filters 
		for(i = 0; i < markers.length; i++)
		{
			//elapsedDays equals the number of days between 
			//the current date and the date the current marker was logged
			var elapsedDays = Math.round((currentDate - markers[i].date)/8.64e+7);
			
			//usrAddress holds a LatLng for users home address
			var usrLatLng = new google.maps.LatLng(myLat, myLng);
			
			//markerLatLng holds a LatLng for the current marker's position
			var markerLatLng = markers[i].latlng;
			
			//distanceFromHome now holds the number of miles between the user's home
			//and the position of the current marker
			var distanceFromHome = Math.round((google.maps.geometry.spherical
											.computeDistanceBetween(usrLatLng, markerLatLng))/1609.34);								
			//each marker will need to make it through time and distance constraints
			//then, if category and/or priority filters apply, each marker will need
			//to match those as well, or it won't find a setVisible(true) statement
				
			//if the elapsed time since the event was logged is less than
			//or equal to the selected time frame radio button
			if ((tValue == 0) || (elapsedDays <= tValue))
			{
				//and if the distance to user address is less than or equal 
				//to the selected proximity radio button
				if ((pValue == 0) || (distanceFromHome <= pValue))
				{
					//and if no priority filter elements are checked
					if (!pChecked)
					{
						//and if no category filter elements are checked either
						//set current marker to visible
						if (!cChecked) markers[i].setVisible(true);
						
						//else we need to filter by category before doing so
							//see if the category filter checkbox that corresponds with this marker's 
							//category is checked. If so, make this marker visible.
						else if (categoryFilters[markers[i].categoryID - 2].checked) markers[i].setVisible(true);
					}
					//else there's a priority check for us to do 
					else
					{
						//if there's no category filter
						if (!cChecked)
						{
							//just check the priority level and make the marker visible if they match
							if (priorityFilters[markers[i].priority - 2].checked) markers[i].setVisible(true);
						}
						//else we need to filter by category AND priority
						else if ((priorityFilters[markers[i].priority - 2].checked) 
								&& (categoryFilters[markers[i].categoryID - 2].checked)) markers[i].setVisible(true);
					}
				}
			}	
		}
	}
