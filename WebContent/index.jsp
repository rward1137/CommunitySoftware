<!doctype html>
<html><!-- InstanceBegin template="/Templates/postlogin.dwt" codeOutsideHTMLIsLocked="false" -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
                            	<a class="nav-link" href="index.jps">Event Log</a>
                            </li>
                            <li class="nav-item">
                            	<a class="nav-link" href="bulletinboard.html">Bulletin Board</a>
                            </li>
                            <li class="nav-item">
                            	<a class="nav-link" href="profile.html">Account</a>
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
                                                    <%= events.get(4).createdAt() %>
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
                                              <%= events.get(3).createdAt() %>
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
                                              <%= events.get(2).createdAt() %>
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
                                              <%= events.get(1).createdAt() %>
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
                                              <%= events.get(0).createdAt() %>
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
                                        <option value="0">Category</option>       
                                        <option value="1">Assault</option>
                                        <option value="2">Break-in</option>
                                        <option value="3">Robbery</option>
                                        <option value="4">Arson</option>
                                        <option value="5">Vandalism</option>
                                        <option value="6">Active Shooter</option>
                                        <option value="7">Explosion</option>
                                        <option value="8">Suspicious Activity</option>
                                    </select>
                                    
                                    <select name="priority-select">
                                        <option value="select">Priority level</option>       
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
<script src="script.html"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initialize&libraries=geometry,places" 
	async defer></script>

<!-- InstanceEndEditable -->
    </body>
<!-- InstanceEnd --></html>
