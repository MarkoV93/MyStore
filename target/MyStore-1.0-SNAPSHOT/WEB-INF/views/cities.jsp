<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
     
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <script src="<c:url value="/resource/js/cities.js" />"></script>
        <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="<c:url value="/resource/js/jquery.min.js" />"></script>      
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap-switch.css" />' type="text/css" media="screen" />
        <script src="<c:url value="/resource/js/bootstrap-switch.js" />"></script>
   <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />
    <script src="<c:url value="/resource/js/bootstrap.js" />"></script>
        <title>Cities</title>
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
        <div class="col-sm-12 col-md-12 col-lg-12 ">
            <br>
            <br>
             <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/users'" class="button_newbutton col-sm-2 col-md-2 col-lg-2 col-md-offset-1">Users</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/reserves'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Reserves</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/categories'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Categories</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/cities'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Cities</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/products'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Products</button>
        </div>
        <div class="col-sm-10 col-md-10 col-lg-10 ">
          <table  class="table table-hover" style="font-weight: bold;">
          <thead>  <tr > 
                <td> name </td> 
                <td> active </td> 

          
              </tr></thead>
        <c:forEach var="city" items="${requestScope.cities}">
            <tr id="remove${city.id}"><td>  <p id="test${city.id}">   ${city.name}</p> </td> 
                <c:choose>
                    <c:when test="${city.activeStatus}">
                        <td> <input  id="changeName${city.id}" type="checkbox" data-off-text="Not active" data-on-text="Active" data-on-color="success" data-off-color="danger" data-id="${city.id}" data-cityName="${city.name}" checked class="activityCityClass"></td> 
                        </c:when>    
                        <c:otherwise>
                        <td><input id="changeName${city.id}"  type="checkbox" data-off-text="Not active" data-on-text="Active" data-on-color="success" data-off-color="danger" data-id="${city.id}" data-cityName="${city.name}" class="activityCityClass"></td>
                        </c:otherwise>
                    </c:choose>
                <td>
                      <div class="col-sm-4 col-md-4 col-lg-4 ">
                    <input id="${city.id}" type="text">
                      </div>
                    <input id="changeActivity${city.id}" type="button" class="changeName" data-id="${city.id}"  data-activity="${city.activeStatus}" value="change" >
                </td>
                 <td> <input type="button" class="deleteCity  btn btn-danger"  data-id="${city.id}"  value="delete" ></td>
            </tr>
        </c:forEach>
    </table>
       
        
        </div>
         <div  style="font-weight: bold;" class="col-sm-2 col-md-2 col-lg-2 col-md-offset-1">
              <input class="form-control" id="newCity" type="text">
         </div>
         <div  class="col-sm-3 col-md-3 col-lg-3 ">
             <input  type="button" value="add" class="button_newbutton" onclick="addCity()" >
         </div>
    <script type="text/javascript">

        $('.activityCityClass').bootstrapSwitch();

        var activityCities = document.getElementsByClassName('activityCityClass');
        for (var i = 0; i < activityCities.length; i++) {
            activityCities[i].onchange = changeActivity;
        }

        var changeCity = document.getElementsByClassName('changeName');
        for (var i = 0; i < changeCity.length; i++) {

            changeCity[i].onclick = changeName;
        }
        
var deleteCities = document.getElementsByClassName('deleteCity');
for (var i = 0; i < deleteCities.length; i++) {

deleteCities[i].onclick = deleteCity;
}

    </script>
</body>
</html>