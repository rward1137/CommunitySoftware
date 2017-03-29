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
        
        <a href="http://www.twitter.com"><img src="images/icons/twitter.png" class="icon-image" alt="Community Watch Twitter page" ></a>
      <a href="http://www.facebook.com"><img src="images/icons/fb.png" class="icon-image" alt="Community Watch Facebook page" ></a> 
      <a href="http://www.instagram.com"><img src="images/icons/instagram.png" class="icon-image" alt="Community Watch Instagram page"></a>
        
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
			<input type="text" name="first" class="nameinput" placeholder="First"/>
			<input type="text" name="last" class="nameinput" placeholder="Last"/>
			<label>Community ID: </label>
			<input type="text" name="communityID" placeholder="Wake Tech">
			<label>Choose Username: </label>
			<input type="text" name="username"/>
			<label>Choose Password: </label>
			<input type="password" name="password"/>
			<label>Confirm Password: </label>
			<input type="password" name="password"/>
			<label>Email Address: </label>
			<input type="email" name="email"/>
			<label>Home Address: </label> <br>
			<input type="text" name="street" placeholder="Street"/>
			<input type="text" name="apt" class="addressinput" placeholder="Apartment"/>
			<input type="text" name="city" class="addressinput" placeholder="City"/>
			<input type="text" name="state" class="addressinput" placeholder="State"/>
			<input type="text" name="zip" class="addressinput" placeholder="Zip code"/>
			<input type="text" name="county" class="addressinput" placeholder="County"/>

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
    	
        <a href="http://www.twitter.com"><img src="images/icons/twitter.png" class="icon-image" alt="Community Watch Twitter page" ></a>
      <a href="http://www.facebook.com"><img src="images/icons/fb.png" class="icon-image" alt="Community Watch Facebook page" ></a> 
      <a href="http://www.instagram.com"><img src="images/icons/instagram.png" class="icon-image" alt="Community Watch Instagram page"></a>
        
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

</html>
