<!doctype html>
<html><!-- InstanceBegin template="/Templates/postlogin.dwt" codeOutsideHTMLIsLocked="false" -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!-- InstanceBeginEditable name="doctitle" -->
<title>Welcome to Community Watch</title>
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
String username = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
	for(Cookie cookie : cookies){
		if(cookie.getName().equals("user")) username = cookie.getValue();
	}
}
%>

<header>
    <img id="headlogo" src="images/logo.jpg" width="100" alt="community software logo"/> 
    <section id="title">
    Community Watch
    </section>
</header>

        <div class="container">
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
        
            <div class="row no-gutters" id="nav">
                <div class="col">
                    <nav class="navbar navbar-toggleable-sm navbar-inverse bg-inverse"> <!-- Brand and toggle get grouped for better mobile display -->
                        <button type="button" class="navbar-toggler navbar-toggler-left" data-toggle="collapse" data-target="#navbar-collapse-1" aria-controls="navbar-collapse-1" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                      
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="navbar-collapse-1">
                          <ul class="navbar-nav mr-auto">
                            <li class="nav-item active">
                            	<a class="nav-link" href="index.jsp">Event Log</a>
                            </li>
                            <li class="nav-item">
                            	<a class="nav-link" href="bulletinboard.jsp">Bulletin Board</a>
                            </li>
                            <li class="nav-item">
                            	<a class="nav-link" href="profile.jsp">Account</a>
                            </li>
                            <li class="nav-item">
                            	<a class="nav-link" href="LogoutServlet">Logout</a>
                            </li>
                          </ul>
                        </div><!-- /.navbar-collapse -->
                    </nav>
                </div><!-- /.col -->
            </div><!-- /.row -->
        	
            <div class="row no-gutters" id="content">
            <!-- InstanceBeginEditable name="main" -->
            	<div class="col-12 col-md-8" id="main-content">
                	<div class="row" id="map-canvas">
                    </div>
                    
                    <div class="card">
                        <div class="card-header" role="tab" id="filter-heading">
                            <p class="mb-0">
                                <a id="filter-toggle-link" data-toggle="collapse" data-parent="#accordion" href="#collapseA" aria-expanded="true" aria-controls="collapseA">
                                Filter Events
                                </a>
                            </p>
                        </div>
                        <div id="collapseA" class="collapse show" role="tabpanel" aria-labelledby="filter-heading">
                            <div class="card-block">
                            	
                                <div class="row" id="filter-containter">
                                    <div class="col-6 col-lg-2 filter-set" onchange="filterMarkers()">
                                        <h5>Priority Level</h5>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="p-level1" value="1" name="priority">
                                            One
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="p-level2" value="2" name="priority">
                                            Two
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="p-level3" value="3" name="priority">
                                            Three
                                          </label>
                                        </div>
                                    </div> <!-- /.col (priority filter) -->
                                    <div class="col-6 col-lg-3 filter-set" onchange="filterMarkers()">
                                        <h5>Category</h5>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="cat1" value="1" name="category">
                                            Assault/Violence
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="cat2" value="2" name="category">
                                            Break-in
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="cat3" value="3" name="category">
                                            Robbery
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="cat4" value="4" name="category">
                                            Arson
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="cat5" value="5" name="category">
                                            Vandalism
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="cat6" value="6" name="category">
                                            Active Shooter
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" id="cat7" value="7" name="category">
                                            Explosion
                                          </label>
                                        </div>
                                        <div class="checkbox">
                                          <label style="width:130px">
                                            <input type="checkbox" id="cat8" value="8" name="category">
                                            Suspicious Activity
                                          </label>
                                        </div>
                                    </div> <!-- /.col (cat-filter) -->
                                    <div class="col-6 col-lg-3 filter-set" id="time-filter" onchange="filterMarkers()">
                                        <h5>Time Frame</h5>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="time-radios5" value="0" name="time" checked="checked">
                                            Any Time
                                          </label>
                                        </div>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="time-radios1" value="1" name="time">
                                            Today
                                          </label>
                                        </div>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="time-radios2" value="7" name="time">
                                            Past 7 Days
                                          </label>
                                        </div>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="time-radios3" value="30" name="time">
                                            Past 30 Days
                                          </label>
                                        </div>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="time-radios4" value="365" name="time">
                                            Past Year
                                          </label>
                                        </div>
                                    </div> <!-- /.col #time-filter -->
                                    <div class="col-6 col-lg-3 filter-set" id="prox-filter" onchange="filterMarkers()">
                                        <h5>Proximity to Home</h5>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="prox-radios5" value="0" name="proximity" checked="checked">
                                            Any Proximity
                                          </label>
                                        </div>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="prox-radios1" value="1" name="proximity">
                                            1 Mile Radius
                                          </label>
                                        </div>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="prox-radios2" value="5" name="proximity">
                                            5 Mile Radius
                                          </label>
                                        </div>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="prox-radios3" value="10" name="proximity">
                                            10 Mile Radius
                                          </label>
                                        </div>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" id="prox-radios4" value="25" name="proximity">
                                            25 Mile Radius
                                          </label>
                                        </div>
                                    </div> <!-- /.col #prox-filter -->
                                </div><!-- /.row #filter-containter -->
                                <div class="col-12"id="clear-filters">
                                    <input type="reset" value="Reset Filters" onClick="resetFilters()">
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    
                </div> <!-- /.col #main-content -->
                    
    <%@ page import="community.objects.Event" %> 
    <% 
    java.sql.Connection connect = null;
    java.sql.Statement stmt;
    java.sql.ResultSet result;
    java.sql.PreparedStatement prep;
    java.util.ArrayList<Event> events = new java.util.ArrayList<>();
    Event tempEvent;
    int mostRecentEvent = 0;
    int anonlogged = 0;
    int userID;
    try{
    	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");
        //connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=CommunitySoftware;IntegratedSecurity=true;");
				
        stmt = connect.createStatement();
        
        result = stmt.executeQuery("select ID from events");
        while (result.next()) { mostRecentEvent = Integer.parseInt(result.getString("ID")); }
    //	System.out.println(mostRecentEvent);
        mostRecentEvent = mostRecentEvent - 4;
    //	System.out.println(mostRecentEvent);
        
        result = stmt.executeQuery("select * from events where ID >= " + mostRecentEvent);
        while (result.next()) {
        //	System.out.println(result.getString("Details"));
            tempEvent = new Event();
            tempEvent.setID(Integer.parseInt(result.getString("ID")));
            tempEvent.setDate(result.getString("EventDate"));
            tempEvent.setDate(tempEvent.createdOn().substring(0, 16));
            
            tempEvent.setMarker(Integer.parseInt(result.getString("MarkerID")));
            tempEvent.setDetails(result.getString("Details"));
            anonlogged = Integer.parseInt(result.getString("AnonymousLogged"));
            if (anonlogged == 0) {
                tempEvent.setUserID(Integer.parseInt(result.getString("UserID")));
                tempEvent.setUser("PlaceHolding");
            }
            else { tempEvent.setUser("Anonymous"); }
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
    
    while (events.size() < 5) {
    	tempEvent = new Event();
    	tempEvent.setID(0);
    	tempEvent.setDate("1-1-11");
    	tempEvent.setMarker(1);
    	tempEvent.setDetails("This is a test event");
    	tempEvent.setUserID(1);
    	tempEvent.setUser("Admin");
    	events.add(0, tempEvent);
    }
    %>
                 <div class="col-12 col-md-4" id="aside">
                	<ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                        	<a class="nav-link" data-toggle="tab" href="#recent" role="tab">Recent Events</a>
                        </li>
                        <li class="nav-item">
                        	<a class="nav-link active" data-toggle="tab" href="#new" role="tab">New Event</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div id="recent" class="tab-pane">
                            <div id="recent-events">
                                <div id="accordion" role="tablist" aria-multiselectable="true">
                                    <div class="card">
                                        <div class="card-header" role="tab" id="headingOne">
                                            <p class="mb-0">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                                <!-- MOST RECENT EVENT -->
                                                    <%= events.get(4).createdOn() %>
                                                </a>
                                            </p>
                                        </div>
                                        <div id="collapseOne" class="collapse" role="tabpanel" aria-labelledby="headingOne">
                                            <div class="card-block">
                                                <%= events.get(4).getDetails() %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-header" role="tab" id="headingTwo">
                                          <p class="mb-0">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                              <!-- 2ND MOST RECENT -->
                                              <%= events.get(3).createdOn() %>
                                            </a>
                                          </p>
                                        </div>
                                        <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
                                            <div class="card-block">
                                            <%= events.get(3).getDetails() %>
                                          </div>
                                        </div>
                                      </div>
                                      <div class="card">
                                        <div class="card-header" role="tab" id="headingThree">
                                          <p class="mb-0">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                              <!-- 3RD MOST RECENT -->
                                              <%= events.get(2).createdOn() %>
                                            </a>
                                          </p>
                                        </div>
                                        <div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree">
                                            <div class="card-block">
                                            <%= events.get(2).getDetails() %>
                                          </div>
                                        </div>
                                      </div>  
                                      <div class="card">
                                        <div class="card-header" role="tab" id="headingFour">
                                          <p class="mb-0">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                              <!-- 4TH MOST RECENT -->
                                              <%= events.get(1).createdOn() %>
                                            </a>
                                          </p>
                                        </div>
                                        <div id="collapseFour" class="collapse" role="tabpanel" aria-labelledby="headingFour">
                                            <div class="card-block">
                                            <%= events.get(1).getDetails() %>
                                          </div>
                                        </div>
                                      </div>
                                      <div class="card">
                                        <div class="card-header" role="tab" id="headingFive">
                                          <p class="mb-0">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                                              <!-- 5TH MOST RECENT -->
                                              <%= events.get(0).createdOn() %>
                                            </a>
                                          </p>
                                        </div>
                                        <div id="collapseFive" class="collapse" role="tabpanel" aria-labelledby="headingfive">
                                            <div class="card-block">
                                            <%= events.get(0).getDetails() %>
                                          </div>
                                        </div>
                                     </div> <!-- /.panel -->
                                </div> <!-- /.panel-group -->
                            </div> <!-- /#recent-events -->
                        </div> <!-- /#recent.tab-pane for most recent events -->
                        <div id="new" class="tab-pane active">
                            <form action="EventServlet" method="post" class="log-event">
                            	<br>
                                <h5>Log New Event</h5>
                                <input id="autocomplete" name="address" placeholder="Enter location or address" onFocus="geolocate()" type="text"></input>
                                <input type="text" id="address-lat" name="latitude" hidden="true"/>
                                <input type="text" id="address-lng" name="longitude" hidden="true"/>
                                <div id="cat-container">
                                    <select name="cat-select">
                                        <option value="">Category</option>       
                                        <option value="2">Assault</option>
                                        <option value="3">Break-in</option>
                                        <option value="4">Robbery</option>
                                        <option value="5">Arson</option>
                                        <option value="6">Vandalism</option>
                                        <option value="7">Active Shooter</option>
                                        <option value="8">Explosion</option>
                                        <option value="9">Suspicious Activity</option>
                                    </select>
                                    
                                    <select name="priority-select">
                                        <option value="">Priority level</option>       
                                        <option value="1">level 1</option>
                                        <option value="2">level 2</option>
                                        <option value="3">level 3</option>
                                    </select>  
                                </div>
                                <div>
                                <label>Brief description:</label>
                                </div>
                                <textarea cols="28" rows="2" name="description"></textarea>
                                <div id="anonbox">
                                    <input type="checkbox" name="anon"> <label>Remain anonymous</label>
                                </div>
                                <input name="eventbutton" type="submit" class="eventbutton">
                            </form>
                        </div> <!-- /#new .tab-pane for event logging -->
                    </div> <!-- /.tab-content -->
                </div>	<!-- /.col #aside -->
    <!-- InstanceEndEditable -->
        	</div>
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
        <!-- InstanceBeginEditable name="js" -->

<%@ page import="community.objects.Event" %>
<%@taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<%
java.util.ArrayList<Event> jsevents = new java.util.ArrayList<>();
Event e;
String userAddress = "";
String eventsString = "";
String usernamestring = "";
int maxMarkerID = 0, anonlog = 0, userlog = 0;

try {
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    connect = java.sql.DriverManager.getConnection("jdbc:sqlserver://waketechcommunitywatchsqlvm000001.database.windows.net;databaseName=WAKETECHCOMMUNITYWATCHDB000001;user=communitywatchadmin;password=WakeTech2018;");

	stmt = connect.createStatement();

	result = stmt.executeQuery("select address from users where username = \'" + username + "\'");
	while (result.next()) { userAddress = result.getString("address"); }
	
	result = stmt.executeQuery("select id from markers");
	while (result.next()) { maxMarkerID = Integer.parseInt(result.getString("ID")); }


	for (int i = 4; i >= 0; i--) {
		e = new Event();
	
		result = stmt.executeQuery("select latitude, longitude, id, EventCategoryNameID from Markers where id = " + (maxMarkerID  - i));
		while (result.next()) {
			e.setLat(Float.parseFloat(result.getString("latitude")));
			e.setLong(Float.parseFloat(result.getString("longitude")));
			e.setID(Integer.parseInt(result.getString("ID")));
			e.setMarker(Integer.parseInt(result.getString("EventCategoryNameID")));
		}

		result = stmt.executeQuery("select priorityLevelID, Details, AnonymousLogged, UserID, EventDate from Events where markerID = " + e.getID());
		while (result.next()) {
			e.setPriorityLevel(Integer.parseInt(result.getString("priorityLevelID")));
			e.setDetails(result.getString("details"));
			e.setDate(result.getString("EventDate"));
			anonlog = Integer.parseInt(result.getString("AnonymousLogged"));
			userlog = Integer.parseInt(result.getString("UserID"));
		}
		
		if (anonlog == 1) { e.setUser("Anonymous"); }
		else {
			result = stmt.executeQuery("select username from users where id = " + userlog);
			while (result.next()) { usernamestring = result.getString("username"); }
			e.setUser(usernamestring); 
		}

		jsevents.add(e);
	}
	
	eventsString += "[";
	for (Event event : jsevents) {
		eventsString += "{";
		eventsString += "\"title\":\"EventID " + event.getID() + "\",";
		eventsString += "\"MarkerID\":" + event.getMarker() + ","; // Category ID
		eventsString += "\"lat\":" + event.getLat() + ",";
		eventsString += "\"lng\":" + event.getLong() + ",";
		eventsString += "\"EventDescription\":\"" + event.getDetails() + "\",";
		eventsString += "\"username\":\"" + event.getUser() + "\",";
		eventsString += "\"priorityLevelID\":" + event.getPriorityLevel() + ",";
		eventsString += "\"date\":\"" + event.createdOn() + "\"";
		eventsString += "},";
	}
	eventsString = eventsString.substring(0, eventsString.length() - 1);
	eventsString += "]";
	/* JSON Parser format
	[
	   { "title":"EventID 1",
		 "MarkerID":5,
		 "lat":35.651079,
		 "lng":-78.706949,
		 "EventDescription":"Something happened here be safe", 
		 "username":"Sophie", 
		 "priorityLevelID":1, 
		 "date":"04/12/2017" } 
	 ]
	*/
}
catch (java.sql.SQLException s) { s.printStackTrace(); }
%>

<c:set var="userAddress" value="<%= userAddress %>" />
<c:set var="eventString" value="<%= eventsString %>" />

<script>

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
		var usrAddress = "<c:out value='${userAddress}' />";
		
		//This big ugly string is for testing, swap it for the line commented out below
		var eventData = JSON.parse('${eventString}');
		
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


</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD4FYJZ396Xk6RYTy5963wl9pVsB0N5g5w&callback=initialize&libraries=geometry,places" 
	async defer></script>
<!-- <c:out value='${userAddress}' /> <c:out value='${eventString}' /> -->
<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd --></html>
