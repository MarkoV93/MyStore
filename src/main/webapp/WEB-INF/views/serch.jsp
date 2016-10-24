<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
           <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />
        <link rel="stylesheet" href='<c:url value="/resource/css/jquery-ui.css" />' type="text/css" media="screen" />
        <script src="<c:url value="/resource/js/jquery.min.js" />"></script>
        <script src="<c:url value="/resource/js/store.js" />"></script>
       <script src="<c:url value="/resource/js/bootstrap.js" />"></script>
        <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
        <title>Serch</title>
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
                         <form action="serch" >                    
                            <input type="hidden" value="${sessionScope.defaultCity}"  name="cityCriteria" />
                            <input  type="text" value="${requestScope.serch}"  name="serch" >
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
                        <li > <a id="basket" style="color: #43a1f1" href="http://localhost:8083/MyStore/showBasket">                       <img alt="product" src="<c:url value="/resource/images/basket.png"/>" />     Basket</a></li>
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
                <div style="font-weight:bold;">
                    <br>
                    City:
                </div>
                <form action="${requestScope.path}" method="get">
                          <select name="cityCriteria" class="form-control"  size="1">
                <option selected value="${sessionScope.defaultCity}">${sessionScope.defaultCity}
                    <c:forEach var="city" items="${sessionScope.cityes}">
                    <option value="${city.name}">${city.name}
                    </c:forEach>
                        <option value="all">all
            </select><br>
                     <input type="hidden" id="serch"  name="priceCriteria" />
            <input type="hidden" value="${requestScope.serch}" name="serch" />
            <button type="submit" class="btn btn-primary" onclick="handler()">Filter</button>
        </form>
            <br>
               <input id="priceMinFilter" type="hidden" value="${sessionScope.minFilter}">
             <input id="priceMaxFilter" type="hidden" value="${sessionScope.maxFilter}">
                <div id="slider-range" class="col-sm-9 col-md-9 col-lg-9"></div>
                <br>
                <br>
                <p>
                    <label for="amount">Price range:</label>
                    <input type="text" id="amount" readonly="" style="border:0; color:#000000; font-weight:bold;">
                </p>
  <br>
  
  
  
  
  
                    <div style="font-weight:bold;">
                        
                        Categories:
                    </div>
                    <br>
                    <c:forEach var="category" items="${sessionScope.categories}">
                        <form action="${category.name}"  >
                            <input type="hidden" value="${sessionScope.minFilter}|${sessionScope.maxFilter}"  name="priceCriteria" />
                            <input type="hidden" value="${sessionScope.defaultCity}"  name="cityCriteria" />
                           <button type="submit"  class="button_newbutton col-sm-12 col-md-12 col-lg-12">${category.name}</button>
                        </form>
                    </c:forEach>
         
                </div>
           
    <div class="col-sm-8 col-md-8 col-lg-8 col-md-offset-1">
                <br>
               
                ${requestScope.message} 
                <br>
         <div class="row">
                        <c:forEach var="product" items="${requestScope.products}">
                            <div class="col-sm-4 col-lg-4 col-md-4">
                                <div class="thumbnail" style="height: 430px;">
                                 <a href="showProduct/${product.id}">   <img  style="height: 300px;width: 350px;" alt="" src="<c:url value="/resource/images/${product.image}"/>"   ></a>
                                    <div class="caption">
                                        <h4 style="color:green" class="pull-right">$${product.price}</h4>
                                        <h4><a href="showProduct/${product.id}">${product.name}</a>
                                        </h4>
                                        <div class="pull-right">${product.category.name}</div> 
                                        <p>${product.city.name} </p>
                                        <input type="button" class="productClass btn btn-primary" id="product" data-id="${product.id}" value="add to basket" >
                                    </div>

                                </div>
                            </div>

                        </c:forEach>
            </div>
                         
                  <div class="col-sm-12 center col-md-offset-10">
            <c:choose>
                <c:when test="${requestScope.pages==0 }">

                </c:when>    
                <c:otherwise>

                    <c:forEach var="i" begin="0" end="${requestScope.pages}">
                    <form action="${requestScope.path}" method="get" style="float:left; padding:0;">
                        <input type="hidden" value="${sessionScope.defaultCity}"  name="cityCriteria" />
                        <input type="hidden" value="${sessionScope.minFilter}|${sessionScope.maxFilter}"  name="priceCriteria" />
<!--                       // <input type="hidden" value="${i}"  name="page" />-->
                        <input type="hidden" value="${serch}"  name="serch" />
                        <button type="submit" class="button" name="page" value="${i}" >${i}</button>
                    </form>
                </c:forEach>
                </c:otherwise>
            </c:choose>
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
