<%-- 
    Document   : registration
    Created on : 18 вер. 2016, 12:08:49
    Author     : Marko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.min.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />   
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
         <script src="<c:url value="/resource/js/bootstrap.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Registration</title>
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
          <form:form action="registration" style="font-weight: bold;color:red" method="post" commandName="user" class="col-sm-offset-3 col-md-offset-3 col-lg-offset-3 col-sm-3 col-md-3 col-lg-3">
                 <br>
                  <br>
                   <br>
                   <div style="color:black"> Login: </div>
                    
                   <form:input class="form-control" path="login" size="30"/>
                    <form:errors path="login" cssClass="error"/>
            <br>
             
                <div style="color:black">     Password: </div>
                  
                    <td><form:password class="form-control" path="password" size="30"/>
                    <td><form:errors path="password" cssClass="error"/>
            <br>
            <div style="color:black">   @mail:</div>
          
                    <form:input class="form-control" path="email" size="30"/>
                    <form:errors path="email" cssClass="error"/>
                         <br>
                     <div style="color:black">   name: </div>
                  
                   <form:input class="form-control" path="name" size="30"/>
                <form:errors path="name" cssClass="error"/>
                         <br>
                      <div style="color:black">     phone: </div>
                        
                    <form:input class="form-control" path="phone"  size="30"/>
                     <form:errors path="phone" cssClass="error"/>
                    <br>
                    <div style="color:black">   surname: </div>
                  
                  <form:input class="form-control" path="surname" size="30"/>
                <form:errors path="surname" cssClass="error"/>
                    <br>
                    <form:input class="form-control" type="hidden" path="activeStatus" value="true"/>
                      <form:input class="form-control" type="hidden" path="adminStatus" value="false"/>
                  <input type="submit" class="btn btn-primary" value="register"/>
               
        </form:form>
    </body>
</html>
