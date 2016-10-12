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
                    }
                    }
                });
            }
  
     function doAjax(event) {
                console.log(arguments);
                var inputText = $(this).attr("data-id");
               
                console.log(inputText);
                $.ajax({
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
                    url: 'deleteFromBasket',
                    type: 'Delete',
                    dataType: 'json',
                    contentType: 'application/json',
                            mimeType: 'application/json',
                 data : JSON.stringify(inputText),
                    success: function (response) {
                        console.log("in success");
                         var result = response.msg;
                        $("#result_text").text(result);
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