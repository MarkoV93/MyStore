function changeActivity(event) {

    var id = $(this).attr("data-id");
    $("#changeActivity" + id).attr("data-activity", $(this).prop("checked"));
    var city = {}
    city["id"] = id;
    city["name"] = $(this).attr("data-cityName");
    city["activeStatus"] = $(this).prop("checked");
    $.ajax({
        url: 'changeCity',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(city),
        success: function (response) {
            console.log('in success');
            var result = response.msg
            $("#result_text").text(result);
             $("#warning_login").text("");
        }

    });
}
function changeName(event) {
    console.log(arguments);

    var id = $(this).attr("data-id");
    var newName = $("#" + id).val();
    console.log(id, newName)
    $("#test" + id).text(newName);
    $("#changeName" + id).attr("data-productName", newName);
    var city = {}
    city["id"] = id;
    city["name"] = newName;
    city["activeStatus"] = $(this).attr("data-activity");
    ;
    $.ajax({
        url: 'changeCity',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(city),
        success: function (response) {
            console.log('in success');
            var result = response.msg
            $("#result_text").text(result);
                  $("#warning_login").text("");
        }

    });
}

function addCity(event) {
    console.log(arguments);


    var name = $("#newCity").val();

    var city = {}

    city["name"] = name;
    city["activeStatus"] = true;
    $.ajax({
        url: 'createCity',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(city),
        success: function (response) {
            console.log(response)
            if (response.msg == 'ok')
                window.location.replace('/MyStore/admin/cities');
            else
                $("#warning_login").text(response.msg);
               $("#result_text").text("");

        }

    });
}

function deleteCity(event) {
    console.log(arguments);
    var id = $(this).attr("data-id");


    $.ajax({
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
        url: 'deleteCity',
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
                      $("#warning_login").text("");
            } else  {
                var result = response.msg;
                $("#warning_login").text(result);
                 $("#result_text").text("");
            }

        }
    });
}
