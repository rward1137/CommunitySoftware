<!doctype=html>
<html><!-- InstanceBegin template="/Templates/prelogin.dwt" codeOutsideHTMLIsLocked="false" -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- InstanceBeginEditable name="doctitle" -->
<title>Welcome to Community Watch</title>
<!-- InstanceEndEditable -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" >
        <link href="CSS/style.css" rel="stylesheet" type="text/css"> 
        
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
    </head>

<body>
	<div class="container" id="content">
        <div class="row no-gutters" id="header">
            <div class="col-auto">
                <img id="headlogo" src="images/logo.jpg" alt="community software logo"/>
            </div>
            <div class="col">
                <section id="title">
                    Community Watch
                </section>
            </div> 
        </div>
        <div id="main-content" class="row no-gutters">
    <!-- InstanceBeginEditable name="main-content" -->
    		<div class="col">
                <div id="formbox">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                        	<a class="nav-link" data-toggle="tab" href="#login" role="tab">Login</a>
                        </li>
                        <li class="nav-item">
                        	<a class="nav-link active" data-toggle="tab" href="#register" role="tab">Register</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane" id="login">
                            <form action="LoginServlet" method="post" id="log">
                            <label>Username: </label>
                            <input type="text" name="username"/><br>
                            <label>Password: </label>
                            <input type="password" name="password"/><br>
                            <input type="submit" value="Login" id="logbutton"/>
                            </form>
                        </div>
                        <div class="tab-pane active" id="register">
                            <form action="RegisterServlet" method="post" id="reg">
                            <label>Full Name: </label>
                            <input type="text" name="first" class="nameinput" placeholder="First" />
                            <input type="text" name="last" class="nameinput" placeholder="Last" /><br>
                            <label>Community ID: </label>
                            <input type="text" name="communityID" placeholder="(943940 - Wake Tech ID)" /><br>
                            <label>Choose Username: </label>
                            <input type="text" name="username" /><br>
                            <label>Choose Password: </label>
                            <input type="password" name="password1" /><br>
                            <label>Confirm Password: </label>
                            <input type="password" name="password2" /><br>
                            <label>Email Address: </label>
                            <input type="email" name="email" /><br>
                            <label>Home Address: </label> 
                            <input id="autocomplete" name="address" placeholder="Enter your address"
                             onFocus="geolocate()" type="text" ></input><br>
                            <input type="text" id="address-lat" hidden="true"/>
                            <input type="text" id="address-lng" hidden="true"/>
                            <input type="submit" value="Register" id="regbutton"/>
                            </form>  
                        </div> <!-- /#tab-pane fade --> 
                    </div> <!-- /#tab-content --> 
                </div> <!-- /#formbox --> 
            </div>
  	<!-- InstanceEndEditable -->
        </div><!-- /.row#content -->
        <div class="row no-gutters" id="footer">
            <section id="footcopy" class="col-sm-4">
            &copy; Community Software 2017
            </section>
            
            <section id="footcontact" class="col-sm-4">
                9101 Fayetteville Road<br>
                Raleigh, NC 27603<br>
                (919)866-5000<br> 
            </section>
            
            <section id="footsocial" class="col-sm-4">
                <a href="mailto:CommunitySoftwareWakeTech@gmail.com">Contact Us</a>
            </section>
        </div>
    </div>
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
