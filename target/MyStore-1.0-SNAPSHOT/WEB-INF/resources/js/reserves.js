/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 function doAjax(event) {
            console.log(arguments);
            var reserve = $(this).attr("data-id");
  var activeStatus=$(this).prop("checked");
            $.ajax({
                
                url: 'acceptReserve/'+reserve,
                type: 'PUT',
                dataType: 'json',
                contentType: 'application/json',
                        mimeType: 'application/json',
              data: JSON.stringify(activeStatus),
                success: function(response) {
                    console.log('in success');
                    var result = response.msg
                    $("#result_text").text(result);
                }

            });
        }

