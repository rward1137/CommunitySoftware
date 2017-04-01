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
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
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
        
      <a href="http://www.twitter.com"><img src="images/icons/twitter.png" width="24" height="24" class="icon-image" alt="Community Watch Twitter page" ></a>
      <a href="http://www.facebook.com"><img src="images/icons/fb.png" width="24" height="24" class="icon-image" alt="Community Watch Facebook page" ></a> 
      <a href="http://www.instagram.com"><img src="images/icons/instagram.png" width="24" height="24" class="icon-image" alt="Community Watch Instagram page"></a>
        
    </section>
</header>

<div id="content">
	
    <nav>
    	<ul>
        	<li><a href="index.html">Event Log</a></li>
            <li><a href="forum.html">Forum</a></li>
            <li class="dropdown">
            	<a href="" class="dropbtn">Account</a>
                <div class="dropdown-content">
                	<a href="profile.html">Profile</a>
                    <a href="settings.html">Settings</a>
                    <a href="forum.html">Forum Posts</a>
                    <a href="message.html">Messages</a>
                    <a href="login.html">Log Out</a>
                </div>
                
            </li>
        </ul>
    </nav>
    <!-- InstanceBeginEditable name="main" -->
    <div id="main-content">
    <h5>Welcome to your Community Watch homepage</h5>
    <iframe
      width="525"
      height="330"
      frameborder="0" style="border:0"
      src="https://www.google.com/maps/embed/v1/place?key=AIzaSyAbu0vFOsoNXKcPaiPWE52yn7X4ixGpi_o&q=Wake+Tech+Community+College" allowfullscreen>
	</iframe>
    
    </div>
    
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
                          <td>description @ placeID<br>(link to map marker?)</td>
                        </tr>
                        <tr>
                          <td>description @ placeID</td>
                        </tr>
                        <tr>
                          <td>description @ placeID</td>
                        </tr>
                        <tr>
                          <td>description @ placeID</td>
                        </tr>
                        <tr>
                          <td>description @ placeID</td>
                        </tr>
                      </tbody>
                    </table>
				</div>
            </div>
            <div id="new" class="tab-pane fade">
            <form id="log-event">
            <h5>Log New Event</h5>
                <label>Location:</label>
                <input type="text" placeholder="google places">
                <p id="event-radio">
                  <label>
                    <input type="radio" name="event-type" value="theft" id="theft">
                    Theft</label>
                  <br>
                  <label>
                    <input type="radio" name="event-type" value="vandal" id="vandal">
                    Vandalism</label>
                  <br>
                  <label>
                    <input type="radio" name="event-type" value="breakin" id="breakin">
                    Break-in</label>
                  <br>
                  <label>
                    <input type="radio" name="event-type" value="assault" id="assault">
                    Assault</label>
                  <br>
                  <label>
                    <input type="radio" name="event-type" value="suspicious" id="Suspicious">
                    Suspicious Activity</label>
                  <br>
                </p>
                <label>Event description: </label>
                <textarea cols="28" rows="2"></textarea>
                <div id="anonbox">
                <input type="checkbox"> <label>Remain Anonymous</label></div>
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
    
    <section id="footsocial">
    	<a href="http://www.twitter.com"><img src="images/icons/twitter.png" width="24" height="24" class="icon-image" alt="Community Watch Twitter page" ></a>
      <a href="http://www.facebook.com"><img src="images/icons/fb.png" width="24" height="24" class="icon-image" alt="Community Watch Facebook page" ></a> 
      <a href="http://www.instagram.com"><img src="images/icons/instagram.png" width="24" height="24" class="icon-image" alt="Community Watch Instagram page"></a>
        <br>
        <a href="mailto:CommunitySoftwareWakeTech@gmail.com">Contact Us</a>
    </section>
    
	<section id="footcontact">
    	123 Main St<br>
        Anytown, NC 99999<br>
        (987)654-3210<br> 
    </section>

</footer>

</body>
<!-- InstanceEnd --></html>
