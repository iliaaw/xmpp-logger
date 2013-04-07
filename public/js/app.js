$(document).ready(function() {
    $('.messages-collapsed').each(function(index) {
        var that = this;
        var next = $(this).next();
        var count = next.data('count')

        if (count > 1) {
            var spoiler = $('<a></a>').addClass('spoiler').attr('href', '#').text(count + ' statuses collapsed').click(function(event) {
                event.preventDefault();

                $(that).children('tr').each(function(index) {
                    if (index != 0) {
                        $(this).show();
                    }
                });
                $(this).closest('tbody').removeClass('messages-collapsed');
                $(this).closest('tr').remove();
            });
            var wrapper = $('<div></div>').addClass('spoiler-wrapper').append(spoiler);
            var tr = $('<tr></tr>');

            tr.addClass('message');
            tr.append($('<td></td>').addClass('message-meta').append(wrapper));
            tr.append($('<td></td>').addClass('message-body').text('|'));

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