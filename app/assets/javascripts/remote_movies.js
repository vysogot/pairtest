function getRemoteDetails(parentElement, title) {

    var posterSrc;
    // This could work if the API provided right CORS headers
    // let apiUrl = 'https://pairguru-api.herokuapp.com/api/v1/movies/';

    // Using proxy
    let apiUrl = '/remote_movies/';

    $.get(apiUrl + title, function (response) {

        posterSrc = response.poster

        parentElement.find('.rating, .plot').each(function () {
            $(this).empty().append(
                '<strong>' + $(this).data('prefix') + '</strong>'
                + response[$(this).data('key')]
            );
        });

    }).fail(function () {

        posterSrc = '/no-image.jpg',

        parentElement.find('.rating, .plot').each(function () {
            $(this).empty().append(
                '<strong>' + $(this).data('prefix') + '</strong>'
                + 'Not available'
            );
        });

    }).always(function () {

        $('<img />', {
            src: posterSrc,
        }).appendTo(parentElement.find('.poster'))

    });

}

$(document).ready(function () {

    $('.placeholder').each(function() {
        $(this).text($(this).data('loading'));
    });

    $('table.remote-movies tr').each(function () {
        let row = $(this);
        let title = row.data('title');

        getRemoteDetails(row, title);
    });

    $('.remote-movie').each(function() {
        let container = $(this);
        let title = container.data('title');

        getRemoteDetails(container, title);
    });
});
