$(document).ready(function() {
      $('a.page-scroll').bind('click', function(e) { // Ease page scrolling
        var anchor = $(this);

        e.preventDefault();
        $('html, body').stop().animate({
          scrollTop: $(anchor.attr('href')).offset().top
        }, 800, 'swing');
	});
});