<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="<c:url value="/resource/js/store.js" />"></script>
        <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
         <script src="<c:url value="/resource/js/bootstrap.js" />"></script>
        <title>Product</title>
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

        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12 ">
                 <div class="col-sm-2 col-md-2 col-lg-2 ">
                     <br>
                     <br>
            
                
              
               <div style="font-weight:bold;">
                        Categories:
                    </div>
                    <br>
                    <c:forEach var="category" items="${sessionScope.categories}">
                        <form action="/MyStore/products/${category.name}"  >
                            <input type="hidden" value="${sessionScope.minFilter}|${sessionScope.maxFilter}"  name="priceCriteria" />
                            <input type="hidden" value="${sessionScope.defaultCity}"  name="cityCriteria" />
                           <button type="submit"  class="button_newbutton col-sm-12 col-md-12 col-lg-12">${category.name}</button>
                        </form>
                    </c:forEach>
                </div>
           <div class="col-md-5 col-md-offset-1">
               <br>
                <div class="thumbnail">
                    <img style="height: 500px;" alt="" class="img-responsive" src="<c:url value="/resource/images/${product.image}"/>"    >
                  
                    <div class="caption-full">
                        <h4 style="color:green" class="pull-right">$${product.price}</h4>
                        <h4>${product.name}
                        </h4>
                        City:  ${product.city.name}
                        <div class="pull-right">Category: ${product.category.name}</div>
                        <p> ${product.description}</p>
   
                        <input type="button" class="productClass btn btn-primary" id="product" data-id="${product.id}" value="add to basket" >
                           
                    </div>

                </div>
           </div>
       
      
  
        
  
       

  </div>
        </div>
                         <script type="text/javascript">
            var products = document.getElementsByClassName('productClass');
            console.log(products)
            for (var i = 0; i < products.length; i++) {
                console.log(products[i]);
                products[i].onclick = addToBasket;
            }

        </script>
    </body>
</html>
