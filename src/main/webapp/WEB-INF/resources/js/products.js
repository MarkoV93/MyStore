/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function changeActivity(event) {

 
  
  var city = {}
    city["id"] = $(this).attr("data-proCityId");
    city["name"] = $(this).attr("data-proCityName");
    city["activeStatus"] = $(this).attr("data-proCityActivity");
    
     var category = {}
    category["id"] = $(this).attr("data-proCategoryId");
    category["name"] = $(this).attr("data-proCategoryName");
   category["activeStatus"] = $(this).attr("data-proCategoryActivity");
   
   var product={}
   product["id"]=$(this).attr("data-id");
   product["name"]=$(this).attr("data-proName");
   product["activeStatus"]=$(this).prop("checked");
   product["description"]=$(this).attr("data-proDescription");
   product["image"]=$(this).attr("data-proImage");
   product["price"]=$(this).attr("data-proPrice");
    product["city"]=city;
     product["category"]=category;
    $.ajax({
        url: 'changeProduct',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(product),
        success: function (response) {
            console.log('in success');
            var result = response.msg
            $("#result_text").text(result);
        }

    });
}

function addProduct(event) {

 var name = $("#name").val();
  var description = $("#description").val();
  var price = $("#price").val();

 var category = jQuery.parseJSON($("#category").val());

var city = jQuery.parseJSON( $("#city").val());
var product ={}
 product["name"]=name;
   product["activeStatus"]=true;
   product["description"]=description;
   product["image"]="image.png";
   product["price"]=price;
    product["city"]=city;
     product["category"]=category;
 console.log(name,description,price,city,category)
    $.ajax({
        url: 'createProduct',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(product),
        success: function (response) {
            
            console.log('in success');
            var result = response.msg
            console.log(result);
             $("#productId").val(result);
            document.uploadImage.submit();
            $("#result_text").text("product added");
        },
        error: function() {
            console.log('error');
                var result = "write carrent price";
            $("#result_text").text(result);
            }

    });
}
function changeProduct(event) {

   var city = {}
    city["id"] = $(this).attr("data-proCityId");
    city["name"] = $(this).attr("data-proCityName");
    city["activeStatus"] = $(this).attr("data-proCityActivity");
    
     var category = {}
    category["id"] = $(this).attr("data-proCategoryId");
    category["name"] = $(this).attr("data-proCategoryName");
   category["activeStatus"] = $(this).attr("data-proActivity");
   
   var product={}
   product["id"]=$(this).attr("data-id");
   product["name"]=$(this).attr("data-proName");
   product["activeStatus"]=$(this).attr("data-proActivity");
   product["description"]=$(this).attr("data-proDescription");
   product["image"]=$(this).attr("data-proImage");
   product["price"]=$(this).attr("data-proPrice");
    product["city"]=city;
     product["category"]=category;
    $.ajax({
        url: 'changeProduct',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(product),
        success: function (response) {
            console.log('in success');
            var result = response.msg
             document.uploadImage.submit();
            $("#result_text").text(result);
       },
        error: function() {
            console.log('error');
                var result = "write carrent price";
            $("#result_text").text(result);
            }

    });
}
function changeName(event) {
    var newName = $("#name").val();
    console.log( newName)
    $("#changeName").text(newName);
    $("#product").attr("data-proName", newName);
}
function changeDescription(event) {
    var newDescription = $("#description").val();
    $("#changeDescription").text(newDescription);
    $("#product").attr("data-proDescription", newDescription);
}
function changePrice(event) {
    var newPrice = $("#price").val();

    $("#changePrice").text(newPrice);
    $("#product").attr("data-proPrice", newPrice);
}
function changeCity(event){
console.log($("#city").val())
    var newCity = jQuery.parseJSON( $("#city").val());

    $("#changeCity").text(newCity.name);
    $("#product").attr("data-proCityId", newCity.id);
    $("#product").attr("data-proCityName", newCity.name);
    $("#product").attr("data-proCityActivity", newCity.activeStatus);
}

function changeCategory(event){
console.log($("#category").val())
    var newCategory = jQuery.parseJSON( $("#category").val());

    $("#changeCity").text(newCategory.name);
    $("#product").attr("data-proCategoryId", newCategory.id);
    $("#product").attr("data-proCategoryName", newCategory.name);
    $("#product").attr("data-proCategoryActivity", newCategory.activeStatus);
}
function deleteProduct(event) {
    console.log(arguments);
    var id = $(this).attr("data-id");


    $.ajax({
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
        url: 'deleteProduct',
        type: 'Delete',
        dataType: 'json',
        contentType: 'application/json',
                mimeType: 'application/json',
        data: JSON.stringify(id),
        success: function (response) {
            if (response.id) {
                console.log(response.id)
                var elem = document.getElementById(response.id);
                elem.parentNode.removeChild(elem);
                var result = "city deleted";
                $("#result_text").text(result);
            } else  {
                var result = response.msg;
                $("#result_text").text(result);
            }

        }
    });
}
