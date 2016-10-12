function changeActivity(event) {

    var id = $(this).attr("data-id");
    $("#changeActivity" + id).attr("data-activity", $(this).prop("checked"));
    var category = {}
    category["id"] = id;
    category["name"] = $(this).attr("data-productName");
    category["activeStatus"] = $(this).prop("checked");
    $.ajax({
        url: 'changeCategory',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(category),
        success: function (response) {
            console.log('in success');
            var result = response.msg
            $("#result_text").text(result);
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
    var category = {}
    category["id"] = id;
    category["name"] = newName;
    category["activeStatus"] = $(this).attr("data-activity");
    ;
    $.ajax({
        url: 'changeCategory',
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(category),
        success: function (response) {
            console.log('in success');
            var result = response.msg
            $("#result_text").text(result);
        }

    });
}

function addCategory(event) {
    console.log(arguments);


    var name = $("#newCategory").val();
    console.log(name)

    var category = {}

    category["name"] = name;
    category["activeStatus"] = true;
    $.ajax({
        url: 'createCategory',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        mimeType: 'application/json',
        data: JSON.stringify(category),
        success: function (response) {
            console.log(response)
            if (response.msg == 'ok')
                window.location.replace('/MyStore/admin/categories');
            else
                $("#warning_login").text(response.msg);

        }

    });
}

function deleteCategory(event) {
  console.log(arguments);
                var id = $(this).attr("data-id");
               
      
                $.ajax({
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
                    url: 'deleteCategory',
                    type: 'Delete',
                    dataType: 'json',
                    contentType: 'application/json',
                            mimeType: 'application/json',
                 data : JSON.stringify(id),
                    success: function (response) {
                        if (response.id) {
                console.log(response.id)
                var elem = document.getElementById(response.id);
                elem.parentNode.removeChild(elem);
                var result = "category deleted";
                $("#result_text").text(result);
            } else  {
                var result = response.msg;
                $("#warning_login").text(result);
            }

        }
    });
}
//(function($) {
//    $(document).ready(function() {
//        $('.deleteCategory').click(function(e) {
//            e.preventDefault();
//            $(this).closest('tr').remove(); // или $(this).parent().parent().remove();
//        });
//    });
//}(jQuery));