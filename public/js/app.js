$(document).ready(function() {
    if (window.location.hash) {
        var hash = window.location.hash;
        var message = $(hash);

        if (message.length) {
            var bgColor = message.css('background-color');
            console.log(bgColor);

            message.animate({
                backgroundColor: "#ff4787"
            }, 0);
            message.animate({
                backgroundColor: bgColor
            }, 3000);
        }
    }
});