<%-- 
    Document   : userPage
    Created on : 18 вер. 2016, 15:39:05
    Author     : Marko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.min.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <script src="<c:url value="/resource/js/userProFile.js" />"></script>
        <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <script src="<c:url value="/resource/js/jquery.min.js" />"></script>
         <script src="<c:url value="/resource/js/bootstrap.js" />"></script>
        <title>User</title>
    </head>
   <body style="overflow-x:hidden">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">

            <br>
            <div class="conteiner">
  <div style="font-style:italic;" class="navbar-header">
                 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                    <a style="font-size: 150%;color: #43a1f1;padding:10px" class="navbar-brand" href="http://localhost:8083/MyStore/products/all">MyStore</a>
                </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
              
                <ul class="nav navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.user==null }">
                            <li id="p1">

                                <input id="login"  type="text"> 
                                <input id="password"  type="password"> 
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
                    <li style="left:50%;position:fixed">
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
                     <c:choose>
                        <c:when test="${sessionScope.user.adminStatus==true }"> 
                    </c:when><c:otherwise>
                        <li > <a id="basket" style="color: #43a1f1" href="http://localhost:8083/MyStore/showBasket">                       <img alt="lenses" src="<c:url value="/resource/images/basket.png"/>" />     Basket</a></li>
                     </c:otherwise></c:choose>
                    <li> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </li>

                </ul>

            </div>
            </div>
<p style="color: green ;margin:0px" id="result_text">&#160</p>
            <p style="color: red ;margin:0px" id="warning_login">&#160</p>
        </nav>
                       <br>
                       <br>
                 
                           <div class="col-sm-3 col-md-3 col-lg-3 ">
                                 <img alt="lenses" src="<c:url value="/resource/images/user.png"/>"   />
                              <table  class="table table-hover">
                        <tr > 
                            <td> name </td> 
                            <td> ${sessionScope.user.name}</td>            
                       </tr>
                       <tr>
                            <td> surname </td> 
                            <td> ${sessionScope.user.surname}</td>    
                       </tr>
                         <tr>
                            <td> login </td> 
                            <td> ${sessionScope.user.login}</td>    
                       </tr>
                         <tr>
                            <td> @mail </td> 
                            <td> <p id="changeEmail"> ${sessionScope.user.email}</p></td>    
                       </tr>
                        <tr>
                            <td> phone </td> 
                            <td>  <p id="changePhone">   ${sessionScope.user.phone}</p> </td>
                       </tr>
                              </table>
                           </div>
                       <br>
                              <div class="col-sm-3 col-md-3 col-lg-3 col-sm-offset-1 col-lg-offset-1 col-md-offset-1">
                      
        <h3>change Password:</h3>
        Old password:
        <input class="form-control" id="oldPassword" type="text">
        New password:
        <input class="form-control" id="newPassword" type="text">
        <input type="button" class="btn btn-primary" value="OK" onclick="changePassword()">
        <br>
         <h3>change Phone:</h3>
         <input class="form-control" id="phone" type="text" value="80">
        <input type="button" class="btn btn-primary" value="OK" onclick="changePhone()">
        <br>
         <h3>change @mail:</h3>
         <input class="form-control" id="email" type="text">
        <input type="button" class="btn btn-primary" value="OK" onclick="changeEmail()">
     
                              </div>
    </body>
</html>
