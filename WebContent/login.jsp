<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Community Watch</title>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" >
	<link href="CSS/style.css" rel="stylesheet" type="text/css">
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
        
        <a href="www.twitter.com" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('twitter','','images/icons/twitterhover.png',1)"><img src="images/icons/twitter.png" alt="Community Watch Twitter page" width="24" height="24" id="twitter"></a>
        <a href="www.facebook.com" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('facebook','','images/icons/fbhover.png',1)"><img src="images/icons/fb.png" alt="Community Watch Facebook page" width="24" height="24" id="facebook"></a> 
        <a href="www.instagram.com" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('instagram','','images/icons/instagramhover.png',1)"><img src="images/icons/instagram.png" alt="Community Watch Instagram page" width="24" height="24" id="instagram"></a>
        
    </section>
</header>

<div id="content">
	<div id="formbox">
		<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" >
			<a href="#login" id="login-tab" role="tab" data-toggle="tab">Login</a>
		</li>
		<li role="presentation" class="active">
			<a href="#register" role="tab" data-toggle="tab">Register</a>
		</li>
	    </ul>
	    <div class="tab-content">
		<div class="tab-pane" role="tabpanel" id="login">
		    <form action="LoginServlet" method="post" id="log">
			<label>Username: </label>
			<input type="text" name="username"/>
			<label>Password: </label>
			<input type="password" name="password"/>
			<input type="submit" value="Login" id="logbutton"/>
		    </form>
		</div>
		<div class="tab-pane active" role="tabpanel" id="register">
		    <form action="../LoginServlet" method="post" id="reg">
			<label>Full Name: </label>
			<input type="text" name="first" class="nameinput" placeholder="First"/>
			<input type="text" name="last" class="nameinput" placeholder="Last"/>
			<label>Community ID: </label>
			<input type="text" name="communityID">
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
    	<a href="www.twitter.com" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('twitter2','','images/icons/twitterhover2.png',1)"><img src="images/icons/twitter.png" alt="Community Watch Twitter page" width="24" height="24" id="twitter2"></a> 
        <a href="www.facebook.com" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Facebook2','','images/icons/fbhover2.png',1)"><img src="images/icons/fb.png" alt="Community Watch Facebook page" width="24" height="24" id="Facebook2"></a> 
        <a href="www.instagram.com" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Instagram','','images/icons/instagramhover2.png',1)"><img src="images/icons/instagram.png" alt="Community Watch Instagram page" width="24" height="24" id="Instagram"></a> 
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
