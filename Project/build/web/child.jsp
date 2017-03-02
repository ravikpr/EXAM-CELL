<%-- 
    Document   : child
    Created on : 19 Feb, 2016, 12:29:20 PM
    Author     : project
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
               <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
 	<link rel="stylesheet" type="text/css" href="all.css">
        
        <script type="text/javascript">
    var txtName,room;
    
    function SetName(total,tv,duty) {
               

        if (window.opener != null && !window.opener.closed) 
        {
            var j=1;
            for(i=1;i<=total;i++)
            {
                
            //txtName = window.opener.document.getElementById("txtName"+j);
            
            room=document.getElementById("room"+i);
            if(room.checked)
            {//        txtName.value = room.value;
            j++;
            }}
            if(j-1>tv)
            {
                var q="Maximum rooms to be selected="+tv+"\nCurrently selected rooms="+(j-1)+"\n\nKindly remove "+(j-1-tv)+" rooms.";
                window.alert(q);
            }
            else
            {
                var confirm_value=window.confirm("Do you want to proceed?")
                if(confirm_value == true)
                {
                    SetValues(total,duty);
                }
            }
        
        
        }
        //window.opener.document.getElementById("count").value=j-1;
        //window.close();
    }
    function SetValues(total,duty) {
        
        
        if (window.opener != null && !window.opener.closed) 
        {
            j=1;
            k=1;
            var fl="";
            for(i=1;i<=total;i++)
            {
                
            txtName = window.opener.document.getElementById((duty+"_"+j));
            floor=window.opener.document.getElementById((duty+"_floor_"+k));
            
            var building="";
            var f="";
            var r=0;
            room=document.getElementById("room"+i);
            if(room.checked)
            {   
                txtName.value = room.value;
                     j++;
                     building=(i<=27)?"LT":((i<=53)?"CL":"ME");
                     if(i<=27)
                         r=((i-1)/9);
                     else if(i<=53)
                     {
                         if((i-27)<=6)
                             r=0;
                         else r=((i-33-1)/10)+1;
                     }
                     else
                     {
                         if((i-53)<=6)
                             r=0;
                         else
                             r=1;
                     }
                     f=(r<1)?"GF":((r<2)?"FF":"SF");
                     
                     if(fl!==(building+"-"+f))
                     {
                         //window.alert("old="+fl+"   \ni="+i+"   r="+r+"    \nnew value="+(building+"-"+f));
                         floor.value=(building+"-"+f);
                     
                         k++;
                         fl=building+"-"+f;
                     }
                     
            }
            //counting number of floors
            
            
            }
            
            
        }
       // window.alert("asdasd");
        window.opener.document.getElementById(duty+"_gen").disabled=false;
        window.opener.document.getElementById(duty).value=j-1;
        window.opener.document.getElementById(duty+"_floors").value=k-1;
        window.close();
    }
    function select_checkbox(min,max,val)
    {
        //window.alert("check");
            for(i=min;i<=max;i++)
            {
                document.getElementById("room"+i).checked=val;
            }
        
    }
</script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
             table,h2,html
        {
            background-color: floralwhite;
            
        }
        body{
            background-color: floralwhite;
            overflow-x: hidden;
        }
        input[type="checkbox"]
        {
            background-color: floralwhite;
            margin-left: 0px;
            margin-top: 2px;
        }
        th{
            background-color: floralwhite;
           margin-top: 10px;
            text-align: center;
        }
        td{
            background-color: floralwhite;
        }
            </style>
    </head>
    <body>
        <%
           try{
        int tv=Integer.parseInt(request.getParameter("tv"));
        String duty=request.getParameter("duty");
        %>
        <h2 style="text-align: center">Number of rooms to be selected : <%=tv%></h2>
        <div style="text-align: center">
            <table class="table table-striped">
            <thead>
            <th>
                Lecture Theatre <input type="checkbox" onclick="select_checkbox(1,27,this.checked)">
            </th>
        </thead>
            <tr>
                <td>
                    <table><tr>
                    <%
                           int i=0,j,indent=9;
                           for(j=1;j<=27;j++)
                           {
                               ++i; 
                    %>
                    <td>LT-<%=String.format("%02d",j)%><input type="checkbox" id="room<%=i%>" value="LT-<%=String.format("%02d",j)%>" ></td>
                    <%
                           if(j%indent==0)
                           {
                               %>
                        </tr>
                        <tr>
                               <%
                           }
                           }
                    %>
                        </tr>
                    </table>
                </td>
            <tr></tr>
            <tr></tr>
            <thead>
            <th>
                Classical Lecture Theatre <input type="checkbox" onclick="select_checkbox(28,53,this.checked)">
            </th>
            </thead>
            <td>
                     <table><tr>
                    <%
                           int r=0;
                           for(j=1;j<=26;j++)
                           {
                               ++i; 
                               indent=((j<=6)?6:10);
                               r=((j<=6)?0:6);
                    %>
                    <td>CL-<%=String.format("%02d",j)%><input type="checkbox" id="room<%=i%>" value="CL-<%=String.format("%02d",j)%>"  ></td>
                    <%
                           if((j-r)%indent==0)
                           {
                               %>
                        </tr>
                        <tr>
                               <%
                           }
                           }
                    %>
                        </tr>
                    </table>
                </td>
                            <thead>
                                <th>
                Mechanical Lecture Theatre <input type="checkbox" onclick="select_checkbox(54,64,this.checked)">
            </th>
            
                            </thead>                                
                                <td>
                     <table><tr>
                    <%
                           
                           for(j=30;j<=44;j++)
                           {
                               ++i;
                               String s="";
                               if(j<36)
                                   s="MT";
                               else
                                   s="ML";
                               indent=((j<=36)?6:5);
                               r=((j<36)?29:39);
                    
                               
                    %>
                    <td><%=s%>-<%=String.format("%02d",j)%><input type="checkbox" id="room<%=i%>" value="<%=s%>-<%=String.format("%02d",j)%>"  ></td>
                    <%
                           if((j-r)%indent==0)
                           {
                               %>
                        </tr>
                        <tr>
                               <%
                           }
                           j=((j==35)?39:j);
                           }
                              
                           %>
                        </tr>
                    </table>
                </td>
          
    </table>
     <input type="button" value="Select" onclick="SetName(<%=i%>,<%=tv%>,'<%=duty%>');" />
     
        </div>
     <%
      }
                               catch(Exception e)
                               {
                                   System.out.println(e.getMessage());
                               }%>
    </body>
</html>
