<%-- 
    Document   : error
    Created on : 18 вер. 2016, 15:41:18
    Author     : Marko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <script src="<c:url value="/resource/js/jquery.min.js" />"></script>  
 <script src="<c:url value="/resource/js/bootstrap.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ERROR!</title>
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
                            <br>
            <h1>ERROR!</h1>
        ${requestScope.message}

    </body>
</html>
