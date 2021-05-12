
$(function () {
	window.addEventListener('message', function (event) {
	    if (event.data.enablegui == true) {
            $('#body').css( "display", "block" );
            $("#acceptbutton").attr("disabled", true);
            setTimeout(function() { enableSubmit($("#acceptbutton")) }, 15000);
	    }else if (event.data.enablegui == false) {
            $('#body').css( "display", "none" );
        }
    });
});
function acceptRules(){
    console.log('accept');
    $.post("http://lucaas_acceptrules/acceptrules", function(data, status){
    });
}


var enableSubmit = function(ele) {
    $(ele).removeAttr("disabled");
}

