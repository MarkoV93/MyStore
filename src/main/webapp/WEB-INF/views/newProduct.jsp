<%@page contentType="text/html" pageEncoding="windows-1251"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
     
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/jquery-ui.css" />' type="text/css" media="screen" />      
        <script src="<c:url value="/resource/js/products.js" />"></script>
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
        <div class="col-sm-3 col-md-3 col-lg-3 col-md-offset-1">
        <h3>Name:</h3>
        <input id="name" type="text">
        <br>
        <h3>Deskription:</h3>
        <textarea id="description" type="text" style="margin: 0px; height: 175px; width: 460px;"></textarea>
        <br>
        <h3>Price:</h3>
        <input id="price" type="text">
        <br>
         <h3>City:</h3>
        <select name="selectCity" class="form-control" id="city"  size="1">
            <option  selected >select
                <c:forEach var="city" items="${requestScope.cities}">                      
                <option value='{"id":"${city.id}","name":"${city.name}","activeStatus":"${city.activeStatus}"}' >${city.name} 
                </c:forEach>
        </select>
       
        <br>
         <h3>City:</h3>
        <select name="selectCategory" class="form-control" id="category"  size="1">
            <option  selected >select
                <c:forEach var="category" items="${requestScope.categories}">                      
                <option value='{"id":"${category.id}","name":"${category.name}","activeStatus":"${category.activeStatus}"}' >${category.name}
                </c:forEach>
        </select><br> 
       <form method="POST" name="uploadImage" action="uploadImage${id}" enctype="multipart/form-data">
   
             <h3>Please select a file to upload :</h3> <input type="file" name="file" />
    
    <br>
    
</form>
        <br>
        
        <input  type="button" value="add" class="button_newbutton" onclick="addProduct()" >
        </div>
    </body>
</html>
