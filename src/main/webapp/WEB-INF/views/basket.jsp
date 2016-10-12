<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="<c:url value="/resource/js/basket.js" />"></script>
         <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <title>mystore</title>
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
                        <input  type="text" value="${requestScope.serch}" name="serch" >
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
                      <br>
        <h1>Basket</h1>
         <p id="result_text"></p> 
 
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
                                <td>     ${product.price}</td> 
                                <td>     ${product.description} </td> 
                                <td>    <img alt="lenses" src="<c:url value="/resource/images/${product.image}"/>" width="80" height="40"   onerror="this.src='/MyStore/resource/images/image.png'"></td>
                                <td><button class="btn btn-primary" onclick="window.location.href='http://localhost:8083/MyStore/products/showProduct/${product.id}'">show</button></td>
                                <td>   <input type="button" class="productClass btn btn-primary" id="product" data-id="${product.id}"  value="delete" ></td>
                                
                            </tr>
                                   </c:forEach>   
    </table>
                      <input class="button_newbutton col-sm-2 col-md2 col-lg-2 " type="button" value="buy" onclick="buyProducts()">      
                              <script type="text/javascript">
var products = document.getElementsByClassName('productClass');
for (var i = 0; i < products.length; i++) {
console.log(products[i]);
products[i].onclick = doAjax;
}

//var buy = document.getElementsByClassName('buyClass');
//console.log(buy[0]);
//buy[0].onclick = buyProducts;


        </script>
    </body>
</html>
