$(document).ready(function() {
    $('.messages-collapsed').each(function(index) {
        var that = this;
        var next = $(this).next();
        var count = next.data('count')

        if (count > 1) {
            var tr = $('<tr></tr>');
            var div = $('<div></div>')
            var a = $('<a></a>').attr('href', '#').text(count + ' statuses collapsed').click(function(event) {
                event.preventDefault();

                $(that).children('tr').each(function(index) {
                    if (index != 0) {
                        $(this).show();
                    }
                });
                $(this).closest('tbody').removeClass('messages-collapsed');
                $(this).closest('tr').remove();
            });

            tr.addClass('message');
            tr.append($('<td></td>').append(div.append(a)));
            tr.append($('<td></td>').text('|'));

            $(this).prepend(tr);

            $(this).children('tr').each(function(index) {
                if (index != 0) {
                    $(this).hide();
                }
            });
        } else {
            $(this).removeClass('messages-collapsed');
        }
    });
});