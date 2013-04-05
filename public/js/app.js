$(document).ready(function() {
    $('.collapsed').each(function(index) {
        var that = this;
        var next = $(this).next();
        var count = next.data('count')

        if (count > 1) {
            var tr = $('<tr></tr>');
            var a = $('<a></a>').attr('href', '#').text('statuses collapsed, click to unfold').click(function(event) {
                event.preventDefault();

                $(that).children('tr').each(function(index) {
                    if (index != 0) {
                        $(this).show();
                    }
                });
                $(this).closest('tr').remove();
            });

            tr.addClass('message');
            tr.append($('<td></td>').text(count));
            tr.append($('<td></td>').append(a));

            $(this).prepend(tr);

            $(this).children('tr').each(function(index) {
                if (index != 0) {
                    $(this).hide();
                }
            });
        } else {
            $(this).removeClass('collapsed');
        }
    });
});