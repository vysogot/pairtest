// Make async calls to get the movie details
function fillMovieDetails(parentElement, title) {

    // This could be changed to consume the API directly
    // Here, it goes through the server to control the response
    $.get('/remote_movies/' + title, function (response) {

        // Load the poster image
        $('<img />', {
            src: response.poster,
        }).appendTo(parentElement.find('.poster'))

        // Load rating and plot
        parentElement.find('.rating, .plot').each(function () {

            // All the texts come from the server for easy i18n
            $(this).empty().append(
                '<strong>' + $(this).data('prefix') + '</strong>'
                + response[$(this).data('key')]
            );
        });

    });

}

$(document).ready(function () {

    // Custom loading message for a placeholder
    $('.placeholder').each(function() {
        $(this).text($(this).data('loading'));
    });

    // Fill details on index
    $('table.remote-movies tr').each(function () {
        let row = $(this);
        let title = row.data('title');

        fillMovieDetails(row, title);
    });

    // Fill details on show
    $('.remote-movie').each(function() {
        let container = $(this);
        let title = container.data('title');

        fillMovieDetails(container, title);
    });
});
