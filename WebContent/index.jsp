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
</header>

<div id="content">
	
    <nav>
    	<ul>
        	<li><a href="index.jps">Event Log</a></li>
            <li><a href="bulletinboard.jsp">Bulletin Board</a></li>
            <li><a href="profile.jsp">Account</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>
    <!-- InstanceBeginEditable name="main" -->
    <div id="main-content">
        <div id="map-canvas">
        </div>
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
    int anonlogged = 0;
    String username;
    int userID;
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
            String timestring = result.getString("EventTime");
            tempEvent.setTime(timestring.substring(0, 5));
            tempEvent.setMarker(Integer.parseInt(result.getString("MarkerID")));
            tempEvent.setDetails(result.getString("Details"));
            anonlogged = Integer.parseInt(result.getString("AnonymousLogged"));
            if (anonlogged == 0) {
                tempEvent.setUserID(Integer.parseInt(result.getString("UserID")));
                tempEvent.setUser("PlaceHolding");
            }
            else tempEvent.setUser("Anonymous");
            tempEvent.setPriorityLevel(Integer.parseInt(result.getString("PriorityLevelID")));
            events.add(tempEvent);
        }
        
        for (Event e : events) {
            if (!e.getUser().equals("Anonymous")) {
                int id = e.getUserID();
                result = stmt.executeQuery("select UserName from Users where ID = " + id);
                while (result.next()) {
                    e.setUser(result.getString("UserName"));
                }
            }
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
            		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    	<div class="panel panel-default">
                        	<div class="panel-heading" role="tab" id="headingOne">
                            	<p class="panel-title">
                                	<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    	<!-- MOST RECENT EVENT -->
                                        <%= events.get(4).createdOn() %>
                                        <%= events.get(4).createdAt() %>
                                    </a>
                                </p>
                             </div>
                             <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                             	<div class="panel-body">
                                	<%= events.get(4).getDetails() %>
								</div>
                            </div>
                        </div>
                    	  <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingTwo">
                              <p class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                  <!-- 2ND MOST RECENT -->
                                  <%= events.get(3).createdOn() %>
                                  <%= events.get(3).createdAt() %>
                                </a>
                              </p>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                              <div class="panel-body">
                                <%= events.get(3).getDetails() %>
                              </div>
                            </div>
                          </div>
                          <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingThree">
                              <p class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                  <!-- 3RD MOST RECENT -->
                          		  <%= events.get(2).createdOn() %>
                                  <%= events.get(2).createdAt() %>
                                </a>
                              </p>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                              <div class="panel-body">
                                <%= events.get(2).getDetails() %>
                              </div>
                            </div>
                          </div>  
                          <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingFour">
                              <p class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                  <!-- 4TH MOST RECENT -->
                          		  <%= events.get(1).createdOn() %>
                                  <%= events.get(1).createdAt() %>
                                </a>
                              </p>
                            </div>
                            <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                              <div class="panel-body">
                                <%= events.get(1).getDetails() %>
                              </div>
                            </div>
                          </div>
                          <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingFive">
                              <p class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                                  <!-- 5TH MOST RECENT -->
                          		  <%= events.get(0).createdOn() %>
                                  <%= events.get(0).createdAt() %>
                                </a>
                              </p>
                            </div>
                            <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                              <div class="panel-body">
                                <%= events.get(0).getDetails() %>
                              </div>
                            </div>
                          </div>
                    </div>
				</div>
            </div>
            <div id="new" class="tab-pane fade">
                <form action="EventServlet" method="post" class="log-event">
                    <h5>Log New Event</h5>
                    <input id="autocomplete" name="address" placeholder="Enter location or address" onFocus="geolocate()" type="text"></input>
                    <input type="text" id="address-lat" name="latitude" hidden="true"/>
                    <input type="text" id="address-lng" name="longitude" hidden="true"/>
                    <div id="cat-container">
                    	<select name="cat-select">
                            <option value="1">Category</option>       
                            <option value="2">Assault</option>
                            <option value="3">Break-in</option>
                            <option value="4">Robbery</option>
                            <option value="5">Arson</option>
                            <option value="6">Vandalism</option>
                            <option value="7">Active Shooter</option>
                        </select>
                        
                        <select name="priority-select">
                            <option value="select">Priority level</option>       
                            <option value="1">level 1</option>
                            <option value="2">level 2</option>
                            <option value="3">level 3</option>
                        </select>  
                    </div>
                    <label>Brief description: </label>
                    <textarea cols="28" rows="2" name="description"></textarea>
                    <div id="anonbox">
                    <input type="checkbox" name="anon"> <label>Remain anonymous</label></div>
                    <input name="eventbutton" type="submit" class="eventbutton">
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
	
	function initialize() {
	  initMap();
	  initAutocomplete();
	}
	
	var geocoder;
	var map;
	
	function initMap() {
		geocoder = new google.maps.Geocoder();
		var center = codeAddress(); 
		map = new google.maps.Map(document.getElementById('map-canvas'), {
			center: {
				lat:35.6507,
				lng:78.7041
			},
			zoom: 15
		});
	}
	
	function codeAddress() {
		var address = 'Wake Tech'; //user address string  from db here
	
		geocoder.geocode({
			'address': address
		}, function (results, status) {
	
			if (status == google.maps.GeocoderStatus.OK) {
	
				// Center map on location
				map.setCenter(results[0].geometry.location);
	
				// Add marker on location
				var marker = new google.maps.Marker({
					map: map,
					position: results[0].geometry.location
				});
	
			} else {
	
				alert("Geocode was not successful for the following reason: " + status);
			}
		});
	}
	
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
	<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initialize&libraries=places" 
	async defer></script>

<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
