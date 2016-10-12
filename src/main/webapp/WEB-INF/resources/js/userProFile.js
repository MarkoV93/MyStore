/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function changePassword() {
    console.log("start");
    var passwords = {
        oldPassword: $("#oldPassword").val(),
        newPassword: $("#newPassword").val()
    }

    $.ajax({
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
        url: 'changePassword',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
                mimeType: 'application/json',
        data: JSON.stringify(passwords),
        success: function (response) {
            console.log("in success");
            var result = response.msg; if (result == 'ok'){
               
                 $("#result_text").text("resultpassword changed");
                $("#warning_text").text("");
           } else{
                        $("#warning_text").text("not current old password");
                         $("#result_text").text("");
                    }
                    }
                });
            }
   

function changePhone() {
    console.log("start");
    var phone = {
        phone: $("#phone").val(),
    }

    $.ajax({
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
        url: 'changePhone',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
                mimeType: 'application/json',
        data: JSON.stringify(phone),
        success: function (response) {
           
             $("#changePhone").text($("#phone").val());

            var result = response.msg;
            $("#result_text").text(result);
             $("#warning_text").text("");
        },
        error: function (textStatus, errorThrown) {
           var result="write current phone";
            $("#warning_text").text(result);
             $("#result_text").text("");
        }
    });
}

function changeEmail() {
    console.log("start");
    var email = {
        email: $("#email").val(),
    }

    $.ajax({
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
        url: 'changeEmail',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
                mimeType: 'application/json',
        data: JSON.stringify(email),
        success: function (response) {
            console.log(response);
             $("#changeEmail").text($("#email").val());
  
            var result = response.msg;
            $("#result_text").text(result);
             $("#warning_text").text("");
        },
        error: function (textStatus, errorThrown) {
           var result="write current @mail";
            $("#warning_text").text(result);
             $("#result_text").text("");
        }

    });
}

