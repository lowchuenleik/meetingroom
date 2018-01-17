var initialize_calendar;
initialize_calendar = function () {

      $('.calendar').each(function(){ 

        var venue_fix = '/venues/' + gon.venue_id
        var calendar = $(this);
        calendar.fullCalendar({
          defaultView: 'agendaWeek',
          height:500,
          header: {
              left: 'today',
              center: 'prev title next',
              right: 'month,agendaWeek,agendaDay'
          },
          selectable :true,
          selectHelper: true,
          editable: true,
          eventLimit: true,
          displayEventTime: true,
          events: venue_fix + '/reservations.json',
          select: function(start, end) {
            $.getScript( venue_fix + '/reservations/new', function() {
              $('#reservation_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
              date_range_picker();
              $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
              $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
              
            });

            calendar.fullCalendar('unselect');
          },
          eventDrop: function(event, delta, revertFunc) {
            alert(event.title + " was dropped on " + event.start.format());
            event_data = {  
              reservation: {
                id: event.id,
                start: event.start.format(),
                end: event.end.format()
              }
            };
            $.ajax({
                url: event.update_url,
                data: event_data,
                type: 'PATCH'
            });
          },
          
          eventClick: function(event, jsEvent, view) {
            alert('Event: ' + event.title);
            $.getScript(event.edit_url, function() {
              $('#reservation_date_range').val(moment(event.start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(event.end).format("MM/DD/YYYY HH:mm"))
              date_range_picker();
              $('.start_hidden').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
              $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
            });
          }
        });
      })
  };
$(document).on('turbolinks:load', initialize_calendar);
