/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
      
        function changeActivity(event) {
            console.log(arguments);
            var id = $(this).attr("data-id");
            var activeStatus=$(this).prop("checked");
           var email = $(this).attr("data-email");
           var login = $(this).attr("data-login");
           var name=$(this).attr("data-name");
           var password=$(this).attr("data-password");
           var phone=$(this).attr("data-phone");
           var surname=$(this).attr("data-surname");
           var adminStatus=$(this).attr("data-adminStatus");
            var user = {}
    user["id"] = id;
    user["name"] = name;
    user["activeStatus"] = activeStatus;
    user["email"]=email;
    user["login"]=login;
    user["password"]=password;
    user["phone"]=phone;
    user["surname"]=surname;
    user["adminStatus"]=adminStatus;
    console.log(user)
            $.ajax({
                
                url: 'bannedUser',
                type: 'PUT',
                dataType: 'json',
                contentType: 'application/json',
                        mimeType: 'application/json',
             data: JSON.stringify(user),
                success: function(response) {
                    console.log('in success');
                    var result = response.msg
                    $("#result_text").text(result);
                }

            });
        }

