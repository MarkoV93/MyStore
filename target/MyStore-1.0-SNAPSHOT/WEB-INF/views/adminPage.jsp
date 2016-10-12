<%-- 
    Document   : adminPage
    Created on : 18 вер. 2016, 15:41:42
    Author     : Marko
--%>

<%@page contentType="text/html" pageEncoding="windows-1251"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
     
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/jquery-ui.css" />' type="text/css" media="screen" />      
        <script src="<c:url value="/resource/js/adminPage.js" />"></script>
        <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="<c:url value="/resource/js/jquery.min.js" />"></script>      
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap-switch.css" />' type="text/css" media="screen" />
        <script src="<c:url value="/resource/js/bootstrap-switch.js" />"></script>
   <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />

        <title>Admin Page</title>
    </head>
    <body>
         <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">

            <br>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <div style="font-style:italic;" class="navbar-header">

                    <a style="font-size: 150%;color: #43a1f1;padding:10px" class="navbar-brand" href="http://localhost:8083/MyStore/products/all">MyStore</a>
                </div>
                <ul class="nav navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.user==null }">
                            <li id="p1">

                                <input id="login"  type="text"> 
                                <input id="password"  type="text"> 
                                <button type="submit"  class="btn btn-primary" onclick="login()">Login</button>
                            </li>
                        </c:when>    
                        <c:otherwise>
                            <li id="p1" style="font-style:italic;" >
                                <button style="display:inline;color: #43a1f1" type="submit"  class="btn btn-primary " onclick="logout()">Logout</button>                      
                                <a  style="display:inline;color: #43a1f1" href="http://localhost:8083/MyStore/user/${sessionScope.user.login}">User Pro File</a>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${sessionScope.user.adminStatus==true }">
                                <a style="display:inline;color: #43a1f1" href="http://localhost:8083/MyStore/admin/users">Admin page</a>

                            </c:when>    
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose>
                    </li>    
                    <li style="left:150px">
                        <form action="/MyStore/products/serch" >                    
                            <input type="hidden" value="${sessionScope.defaultCity}"  name="cityCriteria" />
                            <input  type="text"  name="serch" >
                            <button type="submit"  class="btn btn-primary ">Serch</button>

                        </form>
                    </li>

                </ul>
                <ul class="nav navbar-nav navbar-right" style="font-style:italic;color: #43a1f1">
                    <c:choose>
                        <c:when test="${sessionScope.user==null }">
                     <li style="right:100px" id="registration"> <a style="color: #43a1f1" href="http://localhost:8083/MyStore/registrationForm">                            registration</a></li>
                       </c:when>    
                       <c:otherwise></c:otherwise></c:choose>
                    <li > <a style="color: #43a1f1" href="http://localhost:8083/MyStore/showBasket">                       <img alt="lenses" src="<c:url value="/resource/images/basket.png"/>" />     Basket</a></li>
                   
                    <li> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </li>

                </ul>


            </div>
<p style="color: green ;margin:0px" id="result_text">&#160</p>
            <p style="color: red ;margin:0px" id="warning_login">&#160</p>
        </nav>
        <br>
        <div class="col-sm-12 col-md-12 col-lg-12 ">
            <br>
            <br>
             <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/users'" class="button_newbutton col-sm-2 col-md-2 col-lg-2 col-md-offset-1">Users</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/reserves'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Reserves</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/categories'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Categories</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/cities'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Cities</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/products'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Products</button>
        </div>
       
       
        
        <table  class="table table-hover">
                       <thead> <tr style="font-weight: bold;"> 
                            <td> name </td> 
                <td> surname </td> 
                <td> login</td> 
                <td> password </td> 
                <td>   phone</td>
                <td>email</td>
                <td>active status</td>
                               
                      
                       </tr></thead>
                        
                       <c:forEach var="notAdmin" items="${requestScope.notAdminUsers}">
            <tr><td>     ${notAdmin.name} </td> 
                <td>     ${notAdmin.surname} </td> 
                <td>     ${notAdmin.login}</td> 
                <td>     ${notAdmin.password} </td> 
                <td>     ${notAdmin.phone} </td>
                <td>     ${notAdmin.email} </td>
                <c:choose>
                    <c:when test="${notAdmin.activeStatus }">
                        <td> <input id="TheCheckBox" type="checkbox" data-off-text="banned" data-on-color="success" data-off-color="danger" data-on-text="not banned" data-id="${notAdmin.id}" checked class="bannedUserClass"></td> 
                        </c:when>    
                        <c:otherwise>
                        <td><input id="TheCheckBox" type="checkbox" data-off-text="banned" data-on-text="not banned" data-on-color="success" data-off-color="danger" data-id="${notAdmin.id}" class="bannedUserClass"></td>
                        </c:otherwise>
                    </c:choose>

            </c:forEach>  
    </table>
         <div class="col-sm-12 center col-md-offset-10">
            <c:choose>
                <c:when test="${requestScope.pages==0 }">

                </c:when>    
                <c:otherwise>

                   <c:forEach var="i" begin="0" end="${requestScope.pages}">
            <form action="${requestScope.path}" method="get">
                <button type="submit" class="button" name="page" value="${i}" >${i}</button>

            </form>
        </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
            
        <script type="text/javascript">

            $('.bannedUserClass').bootstrapSwitch();

            var users = document.getElementsByClassName('bannedUserClass');
            console.log(users);
            for (var i = 0; i < users.length; i++) {
                console.log(users[i]);
                users[i].onchange = doAjax;
            }

        </script>
</body>
</html>
