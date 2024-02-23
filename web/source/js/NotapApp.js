/**
 * Created by Business Consul 001 on 3/23/2016.
 */


$(function() {
    $('#slides').superslides({
        hashchange: false,
        play:10000,
        animation: 'fade',
        animation_speed: 600,
        animation_easing: 'linear',
        scrollable: true,
        pagination: false
    });
    $(document).on('init.slides', function() {
        $('.loading-container').fadeOut(function() {
            $(this).remove();
        });
    });
});