<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
     
        <link rel="stylesheet" href='<c:url value="/resource/css/shop-homepage.css" />' type="text/css" media="screen" />    
        <script src="<c:url value="/resource/js/products.js" />"></script>
        <script src="<c:url value="/resource/js/loginActivity.js" />"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="<c:url value="/resource/js/jquery.min.js" />"></script>      
        <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap-switch.css" />' type="text/css" media="screen" />
        <script src="<c:url value="/resource/js/bootstrap-switch.js" />"></script>
         <script src="<c:url value="/resource/js/bootstrap.js" />"></script>
   <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />

        <title>Products</title>
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
        <div class="col-sm-12 col-md-12 col-lg-12 ">
            <br>
            <br>
             <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/users'" class="button_newbutton col-sm-2 col-md-2 col-lg-2 col-md-offset-1">Users</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/reserves'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Reserves</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/categories'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Categories</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/cities'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Cities</button>
        <button onclick="window.location.href = 'http://localhost:8083/MyStore/admin/products'" class="button_newbutton col-sm-2 col-md-2 col-lg-2">Products</button>
        </div>
        <div class="col-sm-12 col-md-12 col-lg-12 ">
            <table  class="table table-hover" >
          <thead>  <tr style="font-weight: bold;"> 
               
                <td > name </td> 
                <td > price </td>    
                   <td>   category</td>
                <td>city</td>
                <td> description </td> 
             
                 <td> image</td> 
                <td>active status</td>
                <td>edit</td>
              </tr> </thead>
        <c:forEach var="product" items="${requestScope.products}">
         
            <tr id="remove${product.id}">
                <td style="font-weight: bold;">     ${product.name} </td> 
                <td style="color: green;">  $  ${product.price}</td> 
                        <td>     ${product.category.name} </td>
                <td>     ${product.city.name} </td>
                <td>     ${product.description} </td> 
        
                <td>    <img alt="" src="<c:url value="/resource/images/${product.image}"/>" width="80" height="40"   ></td>
                 <c:choose>
            <c:when test="${product.activeStatus }">
              <td> <input id="TheCheckBox" type="checkbox" data-off-text="Not active" data-on-text="Active" data-on-color="success" data-off-color="danger" data-id="${product.id}" data-proName="${product.name}" data-proPrice="${product.price}" data-proImage="${product.image}" data-proDescription="${product.description}" data-proCityId="${product.city.id}" data-proCityName="${product.city.name}" data-proCityActivity="${product.city.activeStatus}" data-proCategoryId="${product.category.id}" data-proCategoryName="${product.category.name}" data-proCategoryActivity="${product.category.activeStatus}" checked class="bannedProductClass"></td> 
            </c:when>    
            <c:otherwise>
               <td><input id="TheCheckBox" type="checkbox" data-off-text="Not active" data-on-text="Active" data-on-color="success" data-off-color="danger" data-id="${product.id}" data-proName="${product.name}" data-proPrice="${product.price}" data-proImage="${product.image}" data-proDescription="${product.description}" data-proCityId="${product.city.id}" data-proCityName="${product.city.name}" data-proCityActivity="${product.city.activeStatus}" data-proCategoryId="${product.category.id}" data-proCategoryName="${product.category.name}" data-proCategoryActivity="${product.category.activeStatus}" class="bannedProductClass"></td>
            </c:otherwise>
        </c:choose>
                <td> <form action="goToEditingProduct${product.id}" method="get">          <button type="submit" class="btn btn-primary" >Edit</button>       </form></td>
 <td> <input type="button" class="deleteProduct btn btn-danger"  data-id="${product.id}"  value="delete" ></td>
    </c:forEach>  
            </tr>
             </table>
            <div class="col-sm-2 col-md-2  col-lg-2 center col-md-offset-1">
            <form action="goToCreatingProduct" method="get">
                <button type="submit" class="button_newbutton" >New product</button>
        </form> 
            </div>
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

          $('.bannedProductClass').bootstrapSwitch();
          
             var products = document.getElementsByClassName('bannedProductClass');

        for (var i = 0; i < products.length; i++) {
            products[i].onchange = changeActivity;
        }
        var deleteProducts = document.getElementsByClassName('deleteProduct');
for (var i = 0; i < deleteProducts.length; i++) {

deleteProducts[i].onclick = deleteProduct;
}
        </script>
    </body>
</html>

    </body>
</html>
