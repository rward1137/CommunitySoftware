<!doctype=html>
<html><!-- InstanceBegin template="/Templates/prelogin.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<!-- InstanceBeginEditable name="doctitle" -->
<title>Welcome to Community Watch</title>
<!-- InstanceEndEditable -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" >
<link href="CSS/style.css" rel="stylesheet" type="text/css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- InstanceBeginEditable name="head" -->

<!-- InstanceEndEditable -->
</head>

<body>
<header>
    <img id="headlogo" src="images/logo.jpg" width="100" alt="community software logo"/> 
    <section id="title">
    Community Watch
    </section>
</header>
<!-- InstanceBeginEditable name="main-content" -->
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
			<input type="password" name="password1" />
			<label>Confirm Password: </label>
			<input type="password" name="password2" />
			<label>Email Address: </label>
			<input type="email" name="email" />
            <label>Home Address: </label> 
            <input id="autocomplete" placeholder="Enter your address"
             onFocus="geolocate()" type="text" ></input>
            <input type="text" id="address-lat" hidden="true"/>
            <input type="text" id="address-lng" hidden="true"/>
            <input type="submit" value="Register" id="regbutton"/>
		    </form>  
		</div>
     </div>
  </div>
</div>
<!-- InstanceEndEditable -->
<footer>
    <section id="footcopy">
	&copy; Community Software 2017
    </section>
    
    <section id="footsocial">
        <a href="mailto:CommunitySoftwareWakeTech@gmail.com">Contact Us</a>
    </section>
    
    <section id="footcontact">
    	9101 Fayetteville Road<br>
        Raleigh, NC 27603<br>
        (919)866-5000<br> 
    </section>
</footer>
<!-- InstanceBeginEditable name="script" -->

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
	  document.getElementById('address-lat').value = (place.geometry.location.lat);
	  document.getElementById('address-lng').value = (place.geometry.location.lng);
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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD4FYJZ396Xk6RYTy5963wl9pVsB0N5g5w&libraries=places&callback=initAutocomplete"
        async defer></script>

<!-- InstanceEndEditable -->

</body>
<!-- InstanceEnd --></html>
