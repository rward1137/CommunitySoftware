<html>
<head>
<meta charset="UTF-8">
<title>Untitled Document</title>
<link href="CSS/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
    function MM_swapImgRestore() { //v3.0
      var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
    }
    function MM_preloadImages() { //v3.0
      var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
        var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
        if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
    }
    
    function MM_findObj(n, d) { //v4.01
      var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
        d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
      if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
      for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
      if(!x && d.getElementById) x=d.getElementById(n); return x;
    }
    
    function MM_swapImage() { //v3.0
      var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
       if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
    }
    </script>
</head>

<body onLoad="MM_preloadImages('images/icons/fbhover.png','images/icons/twitterhover.png','images/icons/instagramhover.png','images/icons/twitterhover2.png','images/icons/fbhover2.png','images/icons/instagramhover2.png')">
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
	
    <form action="LoginServlet" method="post" id="login">
    	<label>Username: </label> <input type="text" name="username">
        
        <label>Password: </label> <input type="password" name="password">
        
        <input type="submit" value="Login">
    </form>
	
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
