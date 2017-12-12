  var window.loadCarousel = function loadCarousel(){
  var $item = $('.carousel .item'); 
  var $wHeight = $(window).height();
  $item.eq(0).addClass('active');
  $item.height($wHeight); 
  $item.addClass('full-screen');

  document.addEventListener("turbolinks:load", function() {
    console.log('It works on each visit!');

    $('.carousel img').each(function() {
      var $src = $(this).attr('src');
      var $color = $(this).attr('data-color');
      $(this).parent().css({
        'background-image' : 'url(' + $src + ')',
        'background-color' : $color
      });
      $(this).remove();
    });

    $(window).on('resize', function (){
      $wHeight = $(window).height();
      $item.height($wHeight);
    });

    $('.carousel').carousel({
      interval: 6000,
      pause: "false"
    });
  });

  $(document).ready(function() {

      // page is now ready, initialize the calendar...

      $('#calendar').fullCalendar({
          events: '/hackyjson/cal/',
          defaultView: 'basicWeek',
          header: {
              left: 'today',
              center: 'prev title next',
              right: 'month,basicWeek,agendaDay'
          },
          selectable :true,
          selectHelper: true,
          editable: true,
          eventLimit: true,
          events:[{
            title: 'All Day Event',
            start: '2017-12-11'
          }],
          select: function(start, end) {
          $.getScript('/bookings/new', function() {
            $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
            date_range_picker();
            $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
            $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
            
          });

          calendar.fullCalendar('unselect');
          },
          eventClick:  function(event, jsEvent, view) {
              $('#modalTitle').html(event.title);
              $('#modalBody').html(event.description);
              $('#eventUrl').attr('href',event.url);
              $('#fullCalModal').modal();
          }
      })

  });

}


loadCarousel();