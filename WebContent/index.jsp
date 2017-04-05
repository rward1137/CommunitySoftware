<!doctype html>
<html><!-- InstanceBegin template="/Templates/postlogin.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<!-- InstanceBeginEditable name="doctitle" -->
<title>Welcome to Communtiy Watch</title>
<!-- InstanceEndEditable -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="CSS/style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
</head>

<body>

<%
//allow access only if session exists
if(session.getAttribute("user") == null){
	response.sendRedirect("login.jsp");
}
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
	for(Cookie cookie : cookies){
		if(cookie.getName().equals("user")) userName = cookie.getValue();
	}
}
%>

<header>
    <img id="headlogo" src="images/logo.jpg" width="100" alt="community software logo"/> 
    <section id="title">
    Community Watch
    </section>
    
  <section id="headcontact">
        
    </section>
</header>

<div id="content">
	
    <nav>
    	<ul>
        	<li><a href="index.html">Event Log</a></li>
            <li><a href="forum.html">Bulletin Board</a></li>
            <li><a href="profile.html">Account</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>
    <!-- InstanceBeginEditable name="main" -->
    <div id="main-content">
    <h5>Welcome to your Community Watch homepage</h5>
    </div>
<%@ page import="community.objects.Event" %> 
<% 
java.sql.Connection connect;
java.sql.Statement stmt;
java.sql.ResultSet result;
java.sql.PreparedStatement prep;
java.util.ArrayList<Event> events = new java.util.ArrayList<>();
Event tempEvent;
int mostRecentEvent = 0;

try{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
	stmt = connect.createStatement();
	
	result = stmt.executeQuery("select ID from events");
	while (result.next()) {mostRecentEvent = Integer.parseInt(result.getString("ID")); }
//	System.out.println(mostRecentEvent);
	mostRecentEvent = mostRecentEvent - 4;
//	System.out.println(mostRecentEvent);
	
	result = stmt.executeQuery("select * from events where ID >= " + mostRecentEvent);
	while (result.next()) {
	//	System.out.println(result.getString("Details"));
		tempEvent = new Event();
		tempEvent.setID(Integer.parseInt(result.getString("ID")));
		tempEvent.setDate(result.getString("EventDate"));
		tempEvent.setMarker(Integer.parseInt(result.getString("MarkerID")));
		tempEvent.setUser(Integer.parseInt(result.getString("UserID")));
		tempEvent.setDetails(result.getString("Details"));
		tempEvent.setAnon(false);
		tempEvent.setPriorityLevel(Integer.parseInt(result.getString("PriorityLevelID")));
		events.add(tempEvent);
	}
}
catch(ClassNotFoundException c){ c.printStackTrace();}
catch(java.sql.SQLException s) { s.printStackTrace(); }

%>
    <aside><br>
    	<ul class="nav nav-tabs">
        	<li class="active"><a data-toggle="tab" href="#recent">Recent Events</a></li>
            <li><a data-toggle="tab" href="#new">New Event</a></li>
        </ul>
        <div class="tab-content">
        	<div id="recent" class="tab-pane fade in active">
            	<div id="recent-events">
            		<table width="250">
  					 <tbody>
                        <tr>
                          <!-- MOST RECENT EVENT -->
                          <td><%= events.get(4).getID() %> </td>
                          <td><%= events.get(4).getDetails() %></td>
                          <td><%= events.get(4).createdOn() %> </td>
                        </tr>
                        <tr>
                          <!-- 2ND MOST RECENT -->
                          <td><%= events.get(3).getID() %> </td>
                          <td><%= events.get(3).getDetails() %></td>
                          <td><%= events.get(3).createdOn() %> </td>
                        </tr>
                        <tr>
                          <!-- 3RD MOST RECENT -->
                          <td><%= events.get(2).getID() %> </td>
                          <td><%= events.get(2).getDetails() %></td>
                          <td><%= events.get(2).createdOn() %> </td>
                        </tr>
                        <tr>
                          <!-- 4TH MOST RECENT -->
                          <td><%= events.get(1).getID() %> </td>
                          <td><%= events.get(1).getDetails() %></td>
                          <td><%= events.get(1).createdOn() %> </td>
                        </tr>
                        <tr>
                          <!-- 5TH MOST RECENT -->
                          <td><%= events.get(0).getID() %> </td>
                          <td><%= events.get(0).getDetails() %></td>
                          <td><%= events.get(0).createdOn() %> </td>
                        </tr>
                      </tbody>
                    </table>
				</div>
            </div>
            <div id="new" class="tab-pane fade">
                <form action="EventServlet" method="post" class="log-event">
                    <h5>Log New Event</h5>
                    <input id="autocomplete" placeholder="Enter location or address" onFocus="geolocate()" type="text"></input>
                    <input type="text" id="address-lat" hidden="true"/>
                    <input type="text" id="address-lng" hidden="true"/>
                    <div id="cat-container">
                    	<select >
                            <option value="select">Select a category</option>       
                            <option value="assault">Assault</option>
                            <option value="breakin">Break-in</option>
                            <option value="robbery">Robbery</option>
                            <option value="arson">Arson</option>
                            <option value="vandalism">Vandalism</option>
                            <option value="shooter">Active Shooter</option>
                        </select>
                    </div>
                    <label>Brief description: </label>
                    <textarea cols="28" rows="2" name="description"></textarea>
                    <div id="anonbox">
                    <input type="checkbox" name="anon"> <label>Remain anonymous</label></div>
                    <input name="eventbutton" type="submit" id="eventbutton">
                </form>
			</div>
		</div>
    </aside>
    <!-- InstanceEndEditable -->


</div>

<footer>
	<section id="footcopy">
		&copy; Community Software 2017
    </section>
    
    <section id="footcontact">
    	901 Fayetteville Rd<br>
        Raleigh, NC 27603<br>
        (919)866-5000<br>
    </section>
    
    <section id="footsocial">
        <a href="mailto:CommunitySoftwareWakeTech@gmail.com">Contact Us</a>
    </section>
    
	

</footer>
<!-- InstanceBeginEditable name="js" -->

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
		document.getElementById('address-lat').value = (place.geometry.location.lat());
		document.getElementById('address-lng').value = (place.geometry.location.lng());
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
