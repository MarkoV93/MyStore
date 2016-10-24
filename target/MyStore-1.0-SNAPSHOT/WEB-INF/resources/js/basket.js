/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


 function buyProducts(event) {
      console.log(arguments);

  $.ajax({
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
                    url: 'buy',
                    type: 'Post',
                    dataType: 'json',
                    contentType: 'application/json',
                            mimeType: 'application/json',
             
                      success: function (response) {
            console.log("in success");
            var result = response.msg;
           if (result == 'ok'){
               
                window.location.replace('/MyStore/operationComplite');
               
           } else{
                        $("#warning_login").text("login or register please");
                         $("#result_text").text("");
                    }
                    }
                });
            }
  
     function deleteFromBasket(event) {
                console.log(arguments);
                var id = $(this).attr("data-id");
                var totalPrice = $("#totalPrice").val();
                 var price = $(this).attr("data-price");
                 var newPrice=(totalPrice-price).toFixed(2);
                console.log(id,totalPrice,price);
                
                $.ajax({
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
                    url: 'deleteFromBasket',
                    type: 'Delete',
                    dataType: 'json',
                    contentType: 'application/json',
                            mimeType: 'application/json',
                 data : JSON.stringify(id),
                    success: function (response) {
                        console.log("in success");
                         var result = response.msg;
                          $("#totalPrice").val(newPrice);
                           $("#total").text("Total price: "+newPrice)
                        $("#result_text").text(result);
                         $("#warning_login").text("");
                    }
                });
            }
(function($) {
    $(document).ready(function() {
        $('.productClass').click(function(e) {
            e.preventDefault();
            $(this).closest('tr').remove(); // или $(this).parent().parent().remove();
        });
    });
}(jQuery));