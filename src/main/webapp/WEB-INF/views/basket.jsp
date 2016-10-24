<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <script src="<c:url value="/resource/js/jquery.min.js" />"></script>   
        <script src="<c:url value="/resource/js/basket.js" />"></script>
         <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
         <script src="<c:url value="/resource/js/bootstrap.js" />"></script>
        <title>Basket</title>
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
        <h1>Basket</h1>
         <p id="result_text"></p> 
 <c:set var="total" value="${0}"/>
            <table  class="table table-hover">
                       <thead> <tr style="font-weight: bold;"> 
               
                            <td> name </td> 
                            <td> price</td> 
                            <td> description </td> 
                            <td>   image</td>
                              <td>   show</td>
                               <td>   delete</td>
                               
                      
                       </tr></thead>
                        
                        <c:forEach var="product" items="${sessionScope.basket}">
                            <tr>
                                <td style="font-weight: bold;">     ${product.name} </td> 
                                <td style="color: green">     ${product.price}</td> 
                                <td>     ${product.description} </td> 
                                <td>    <img alt="" src="<c:url value="/resource/images/${product.image}"/>" width="80" height="40"   ></td>
                                <td><button class="btn btn-primary" onclick="window.location.href='http://localhost:8083/MyStore/products/showProduct/${product.id}'">show</button></td>
                                <td>   <input type="button" class="productClass btn btn-primary" id="product" data-id="${product.id}" data-price="${product.price}"  value="delete" ></td>
                                <c:set var="total" value="${total + product.price}" />
                            </tr>
                                   </c:forEach>   
    </table>
                      <input class="button_newbutton col-sm-2 col-md2 col-lg-2 " type="button" value="buy" onclick="buyProducts()">      
                      <input id="totalPrice" type="hidden" value="${total}">
                      <p style="font-weight: bold;color: green" class=" col-sm-offset-8 col-md-offset-8 col-lg-offset-8" id="total">Totalprice:  ${total}  </p>
                              <script type="text/javascript">
var products = document.getElementsByClassName('productClass');
for (var i = 0; i < products.length; i++) {
console.log(products[i]);
products[i].onclick = deleteFromBasket;
}

        </script>
    </body>
</html>
