/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function addToBasket(event) {
    console.log(arguments);
    var inputText = $(this).attr("data-id");
    console.log(inputText);
    $.ajax({
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8;',
        url: '/MyStore/products/addToBasket/' + inputText,
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
                mimeType: 'application/json',
        success: function (data) {
            console.log('in success');
            var result = data.name + ' was added';
            $("#result_text").text(result);
             $("#warning_text").text("");
        }

    });
}

function handler() {
    $("#serch").val(value[0] + "|" + value[1]);
}


$(function () {
    var min = $("#priceMinFilter").val();
    var max = $("#priceMaxFilter").val();
    $("#slider-range").slider({
        range: true,
        min: 0,
        max: 3000,
        values: [min, max],
        slide: function (event, ui) {
            $("#amount").val("$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ]);
        }
    });
    $("#amount").val("$" + $("#slider-range").slider("values", 0) +
            " - $" + $("#slider-range").slider("values", 1));
    value = $("#slider-range").slider("option", "values");
    console.log(value);
});


