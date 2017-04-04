<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Community Watch</title>

<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" >
<link href="CSS/style.css" rel="stylesheet" type="text/css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
</head>

<body>
<header>
    <img id="headlogo" src="images/logo.jpg" width="100" alt="community software logo"/> 
    <section id="title">
    Community Watch
    </section>
    
    <section id="headcontact">
    
    	123 Main St<br>
        Anytown, NC 99999<br>
        (987)654-3210<br>
        
    </section>
</header>

<div id="content">
	<div id="formbox">
		<ul class="nav nav-tabs">
		<li><a data-toggle="tab" href="#login">Login</a></li>
		<li class="active"><a data-toggle="tab" href="#register">Register</a></li>
	    </ul>
	    <div class="tab-content">
		<div id="login" class="tab-pane fade">
		    <form action="LoginServlet" method="post" id="log">
			<label>Username: </label>
			<input type="text" name="username"/>
			<label>Password: </label>
			<input type="password" name="password"/>
			<input type="submit" value="Login" id="logbutton"/>
		    </form>
		</div>
		<div class="tab-pane fade in active" id="register">
		    <form action="RegisterServlet" method="post" id="reg">
			<label>Full Name: </label>
			<input type="text" name="first" class="nameinput" placeholder="First" />
			<input type="text" name="last" class="nameinput" placeholder="Last" />
			<label>Community ID: </label>
			<input type="text" name="communityID" placeholder="Wake Tech" />
			<label>Choose Username: </label>
			<input type="text" name="username" />
			<label>Choose Password: </label>
			<input type="password" name="password" />
			<label>Confirm Password: </label>
			<input type="password" name="password" />
			<label>Email Address: </label>
			<input type="email" name="email" />
			<label>Home Address: </label> 
			<input id="autocomplete" placeholder="Enter your address" onFocus="geolocate()" type="text" ></input>
			<input type="text" id="address-lat" hidden="true"/>
			<input type="text" id="address-lng" hidden="true"/>
			<input type="submit" value="Register" id="regbutton"/>
		    </form>  
		</div>
	    </div>
	</div>
</div>
<footer>
    <section id="footcopy">
	&copy; Community Software 2017
    </section>
    
    <section id="footsocial">
        <a href="mailto:CommunitySoftwareWakeTech@gmail.com">Contact Us</a>
    </section>
    
    <section id="footcontact">
    	123 Main St<br>
        Anytown, NC 99999<br>
        (987)654-3210<br> 
    </section>
</footer>
<script>
	var placeSearch, autocomplete;
	
	function initAutocomplete() {
		autocomplete = new google.maps.places.Autocomplete(
			(document.getElementById('autocomplete')),
			{types: ['geocode']});
			
		autocomplete.addListener('place_changed', getAddressData);
	}
	
	function getAddressData() {
	  var place = autocomplete.getPlace();
	  document.getElementById('address-lat').value = (place.geometry[0][0]);
	  document.getElementById('address-lng').value = (place.geometry[0][1]);
	}
	
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
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=KEY_HERE&libraries=places&callback=initAutocomplete"
        async defer></script>
</body>
</html>
