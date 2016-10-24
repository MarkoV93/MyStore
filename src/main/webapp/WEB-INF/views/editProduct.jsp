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
   <link rel="stylesheet" href='<c:url value="/resource/css/bootstrap.css" />' type="text/css" media="screen" />
    <script src="<c:url value="/resource/js/bootstrap.js" />"></script>

        <title>Edit product</title>
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
        
        

                           <div class="col-sm-3 col-md-3 col-lg-3 ">
                                <img width="450" height="350" alt="" src="<c:url value="/resource/images/${product.image}"/>" >
                              <table  class="table table-hover">
                                  <thead> <tr > 
                            <td style="font-weight: bold;"> name </td> 
                            <td>  <p id="changeName">  ${product.name} </p></td>            
                                      </tr></thead>
                       <tr style="font-weight: bold;color:green">
                            <td> Price </td> 
                            <td> <p id="changePrice"> ${product.price}  </p></td>    
                       </tr>
                         <tr>
                            <td style="font-weight: bold;"> Description </td> 
                            <td>  <p id="changeDescription">  ${product.description}</p></td>    
                       </tr>
                         <tr>
                            <td style="font-weight: bold;"> City </td> 
                            <td> <p id="changeCity"> ${product.city.name}</p></td>    
                       </tr>
                        <tr>
                            <td style="font-weight: bold;"> Category </td> 
                            <td> <p id="changeCategory">  ${product.category.name}</p> </td>
                       </tr>
                              </table>
                      
                           </div>
                       <br>
                              <div class="col-sm-3 col-md-3 col-lg-3 col-sm-offset-1 col-lg-offset-1 col-md-offset-1">
                                  <br>
                                  <br>
        <h3>change Name:</h3>
       <input id="name" type="text">
        <input  type="button" class="btn-primary"  value="change" onclick="changeName()">
        <br>
         <h3>change Price:</h3>
         <input id="price" type="text">
         <input  type="button" class="btn btn-primary"  value="change" onclick="changePrice()">
        <br>
         <h3>change Description:</h3>
         <textarea class="form-control" id="description" rows="5" id="comment"></textarea>
        <input  type="button" class="btn btn-primary" value="change" onclick="changeDescription()">
        <br>
        <h3>change city:</h3>
          <select name="selectCity" id="city"  size="1">
            <option  selected >select
                <c:forEach var="city" items="${requestScope.cities}">                      
                <option value='{"id":"${city.id}","name":"${city.name}","activeStatus":"${city.activeStatus}"}' >${city.name} 
                </c:forEach>
        </select>
        <input  type="button"  value="change"  class="btn btn-primary" onclick="changeCity()">
        <br>
         <h3>change category:</h3>
         <select name="selectCategory" id="category"  size="1">
            <option  selected >select
                <c:forEach var="category" items="${requestScope.categories}">                      
                <option value='{"id":"${category.id}","name":"${category.name}","activeStatus":"${category.activeStatus}"}' >${category.name}
                </c:forEach>
        </select>
        <input  type="button" class="btn btn-primary"  value="change" onclick="changeCategory()">
        <br>
        <br>
         <form method="POST" name="uploadImage" action="uploadImage" enctype="multipart/form-data">
             <input type="hidden" name="productId" value="${product.id}">
             <h3>Please select a file to upload :</h3> <input type="file" name="file" />

    <br>
    
</form>
         <input id="product" type="button" value="save" data-off-text="False" data-on-text="True" data-id="${product.id}" data-proName="${product.name}" data-proPrice="${product.price}" data-proImage="${product.image}" data-proDescription="${product.description}" data-proCityId="${product.city.id}" data-proCityName="${product.city.name}" data-proCityActivity="${product.city.activeStatus}" data-proCategoryId="${product.category.id}" data-proActivity="${product.activeStatus}" data-proCategoryName="${product.category.name}" data-proCategoryActivity="${product.category.activeStatus}" class="changeProduct button_newbutton"/>          <br>
                       <br>
                              </div>
        <script type="text/javascript">
            var product = document.getElementsByClassName('changeProduct');
            console.log(product)
            product[0].onclick = changeProduct;


        </script>
    </body>
</html>
