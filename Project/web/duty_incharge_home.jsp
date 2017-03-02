<%-- 
    Document   : duty_incharge_login
    Created on : 26 Aug, 2015, 11:59:05 PM
    Author     : p
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <script>
            function load_panel()
            {
                $('#main_panel').load('ticking_details.jsp');
            }
            $(document).ready(function(){
                $("#usersettings").click(function(){
                    $("#slide").slideToggle("slow");
                    
                });
                $("#slide").click(function (){
                    $("#slide").stop.slideToggel();
                });
                $("#tog").mouseleave(function (){
                    $("#slide").slideUp("slow");
                });
            });
            
            $(document).ready(function(){
                $("#createexam").click(function(){
                    $("#slide1").slideToggle("slow");
                    
                });
                $("#slide1").mouseover(function (){
                    $("#slide1").stop.slideToggel();
                });
                $("#tog1").mouseleave(function (){
                    $("#slide1").slideUp("slow");
                });
            });
            
            
            </script>

          
                
            <style>
                //body{
                  //  height: 100vh;
                    
                //}
          #main_panel
            {
                background-color: floralwhite;
                font-family: sans-serif;
                width: 360px;
                height: 360px;
                float: left;
               
            }
            #main_frame
            {
                width: 300%;
                height: 143%;
                float: left;
                
            }
        </style>
<style class="cp-pen-styles">
* {
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}

html,
body {
    background-color: floralwhite;
  margin: 0;
  padding: 0;
  height: 100%;
  min-height: 100%;
}

.menu {
  width: 280px;
  height: 100%;
  position: fixed;
  background-color: seagreen;
  -webkit-transition: all 1s;
  transition: all 1s;
  left: 0;
  z-index: 50;
  overflow-y: auto;
  padding-bottom: 100px;
}

.menu.closed { left: -280px; }

#toggle {
  background-color: seagreen;
  height: 100%;
  min-height: 100%;
  width: 50px;
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0px;
  z-index: 25;
  -webkit-transition: all .7s ease;
  transition: all .7s ease;
}

#toggle:hover { cursor: pointer; }

#toggle.closed {
  left: 0px;
  top: 0;
  bottom: 0;
  right: 0;
  width: 100%;
  height: 100%;
  opacity: .3;
}

.content {
  margin-left: 0px;
  -webkit-transition: all .4s;
  transition: all .4s;
}

.content.closed .text {
  -webkit-transform: translateX(80px);
  -ms-transform: translateX(80px);
  transform: translateX(80px);
}

.text {
    left: 210px;
  position: absolute;
  -webkit-transition: all .4s ease;
  transition: all .4s ease;
  margin-bottom: 80px;
  width: 1000px;
}

h1,
h2 { color: #444; }

.menu ul {
  list-style-type: none;
  padding: 0;
  margin-left: 10px;
  margin-top: 100px;
  padding-right: 10px;
}
#slide ul,#slide1 ul
{ padding: 0;
  margin-left: 10px;
  margin-top: 5px;
  padding-right: 10px;
}
#slide ul a,#slide1 ul a
{
    color: lightcyan;
    font-weight: bold;
    text-decoration: none;
}
 input[type="text"]
 {
 	border: 1px solid #D7DFE5;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
	font-size: 0.9em;
	background: #F1F5F8;
 	height: 24px;
 	width: 380px;
 }

.menu ul li {
  color: white;
  font-size: 20px;
  margin: 0px;
  display: block;
  height: 40px;
  line-height: 40px;
  padding-left: 10px;
  -webkit-transition: all .3s;
  transition: all .3s;
}

.menu ul li:hover {
  background-color: seagreen;
  cursor: pointer;
}
a{
    color: white;
    text-decoration: none;
}
#wrapper {
  height: 100%;
  min-height: 100%;
  position: fixed;
  overflow-y: auto;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}

#wrapper.closed { position: fixed; }

hr {
  border: none;
  height: 1px;
  background-color: #444;
  position: relative;
  margin-left: 0;
}

hr:before {
  content: "/";
  display: block;
  top: -8px;
  left: -5px;
  position: absolute;
  color: #444;
}
</style>
</head>

<body>
<div id="toggle"> </div>
<div class="menu closed">
    <ul id="mainTabs">
        <div id="tog">
            <li id="usersettings">FACULTY INFORMATION</li>
        <div id="slide" style="display: none">
            <ul>
                <li><a href="add_faculty.jsp" target="main_panel">Add Faculty</a></li>
                <li><a href="delete_faculty.jsp" target="main_panel">Delete Faculty</a></li>  
                <li><a href="show_faculty.jsp" target="main_panel">Show/Edit Faculty</a></li>  
            </ul>
        </div>
        </div>
        
        <div id="tog1">
            <li id="createexam">TICKING GENERATION</li>
        <div id="slide1" style="display: none">
            <ul>
                <li><a href="ticking_details.jsp?message=st1" target="main_panel">Sessional Tests-1</a></li>
                <li><a href="ticking_details.jsp?message=st2" target="main_panel">Sessional Tests-2</a></li>
               <!-- <li><a href="ticking_details.jsp?message=put" target="main_panel">Pre-University Test</a></li>
                <li><a href="blank.jsp?message=COMMING SOON...." target="main_panel">University Test</a></li>
            --><ul>
            </div>
        </div>
        
       
        <li><a href="leave_assign_form_1.jsp" target="main_panel">LEAVE APROVAL</a></li>
        <li><a href="assign_duty.jsp" target="main_panel">ROOM ALLOCATION</a></li>
        
        <li><a href="email.jsp" target="main_panel">E-MAIL</a></li>
        <li><a href="reports.jsp" target="main_panel">VIEW REPORTS</a></li>
        
       </ul>
</div>
<div id="wrapper">
  <div class="content">
    <div class="text">
      <img name="akgec" src="images\akgec3.png" width="120" height="121" alt="" align="left"><h1>Ajay Kumar Garg Engineering College</h1>
	<h2>Examination Duty Allocation</h2>
    <hr>
      <div id="main_panel"><iframe scrolling="auto" frameborder="0" name="main_panel" src="blank.jsp?message=Welcome" id="main_frame"></iframe>
    </div>
    </div>
    
  </div>
</div>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script> 
<script>
$( "#toggle" ).click(function() {
  $(".menu").toggleClass("closed");
  $(this).toggleClass("closed");
  $(".content").toggleClass("closed");
  $("#wrapper").toggleClass("closed")
});
</script>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

       
   
        <%
        String uname=null;
        HttpSession splogin=request.getSession(false);
        try
        {
            uname=splogin.getAttribute("username").toString();
            
        }
        catch(Exception e)
        {
            response.sendRedirect("index.jsp");
        }
       
    %>
        
   <!-- <div id="side_panel">
    <h1>DUTY INCHARGE HOME</h1>
    <h1>Welcome<%=" "+uname %></h1>
    <ul id="mainTabs">
        <div id="tog">
            <li id="usersettings">USER SETTINGS</li>
        <div id="slide" style="display: none">
            <ul>
                <li><a href="add_faculty.jsp" target="main_panel">ADD FACULTY</a></li>
                <li><a href="delete_faculty.jsp" target="main_panel">DELETE FACULTY</a></li>  
                <li><a href="show_faculty.jsp" target="main_panel">SHOW/EDIT FACULTY</a></li>  
            </ul>
        </div>
        </div>
        
        <div id="tog1">
            <li id="createexam">CREATE EXAM</li>
        <div id="slide1" style="display: none">
            <ul>
                <li><a href="ticking_details.jsp?message=st1" target="main_panel">SESSIONAL TESTS-1</a></li>
                <li><a href="ticking_details.jsp?message=st2" target="main_panel">SESSIONAL TESTS-2</a></li>
                <li><a href="ticking_details.jsp?message=put" target="main_panel">PRE-UNIVERSITY TEST</a></li>
                <li><a href="blank.jsp?message=COMMING SOON...." target="main_panel">UNIVERSITY TEST</a></li>
            <ul>
            </div>
        </div>
        
       
        <li><a href="leave_assign_form_1.jsp" target="main_panel">LEAVE APROVAL</a></li>
        <li><a href="assign_duty.jsp" target="main_panel">ASSIGN DUTY</a></li>
        
        <li><a href="blank.jsp?message=COMMING SOON....">UPDATION(LAST MIN)</a></li>
        <li><a href="reports.jsp" target="main_panel">REPORTS</a></li>
        
       </ul>
    </div>-->
    </body>
</html>
    