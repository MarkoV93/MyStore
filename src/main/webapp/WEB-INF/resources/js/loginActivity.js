/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function login(event) {
     var login = $("#login").val();
      var password = $("#password").val();
        var loginPassword = {
        login: login,
        password: password
    }

    $.ajax({
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
        url: '/MyStore/login',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
                mimeType: 'application/json',
        data: JSON.stringify(loginPassword),
        success: function (response) {
            console.log("in success");
            var result = response.msg;
           if (result == 'ok'){
                document.getElementById("p1").innerHTML =  '  <button style="display:inline" type="submit" class="btn btn-primary " onclick="logout()">Logout</button>  <a style="display:inline;color: #43a1f1" href="http://localhost:8083/MyStore/user/${user.login}">User Pro File</a>';
//                  document.getElementById("p2").innerHTML =  '  <button type="submit"  class="btn btn-primary " onclick="logout()">Logout</button>  <a href="http://localhost:8083/MyStore/user/${sessionScope.user.login}">User Pro File</a>';
//            
  document.getElementById('registration').style.display = 'none';


            }else if(result == 'okAdmin'){
                document.getElementById("p1").innerHTML =  '  <button style="display:inline" type="submit" class="btn btn-primary " onclick="logout()">Logout</button>  <a style="display:inline;color: #43a1f1" href="http://localhost:8083/MyStore/user/${sessionScope}user.login}">User Pro File</a><a style="display:inline;color: #43a1f1" href="http://localhost:8083/MyStore/admin/users">Admin page</a>';
//            document.getElementById("p2").innerHTML =  '  <button type="submit"  class="btn btn-primary " onclick="logout()">Logout</button>  <a href="http://localhost:8083/MyStore/user/${sessionScope.user.login}">User Pro File</a>  <a href="http://localhost:8083/MyStore/admin/users">Admin page</a>';
//          
  document.getElementById('registration').style.display = 'none';
            }else{
            $("#warning_login").text(result);
        }
        }
    });
}
function logout(event) {
       $.ajax({
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
        url: '/MyStore/logOut',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
                mimeType: 'application/json',
       
        success: function (response) {
//            var result = response.msg;
//          document.getElementById("p1").innerHTML =  ' <input id="login"  type="text"> <input id="password"  type="text"> <button type="submit"  class="btn btn-primary" onclick="login()">Login</button>';
//            $("#warning_login").text(result);
 window.location.replace('/MyStore/products/all');
  },
        error: function(response) {
            console.log('error');
        console.log(response);
            }

    });
}
