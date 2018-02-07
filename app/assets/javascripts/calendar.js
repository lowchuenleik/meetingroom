var initialize_calendar;
initialize_calendar = function () {

      $('.calendar').each(function(){
        var event_source
        if (gon.venue_id != null) {
          //we're on /new page
          event_source = '/venues/' + gon.venue_id + '/reservations.json';
        } else {
          event_source = null
        }

        var user_events = '/users/' + gon.user_id + '/reservations.json'


        var redirect_hack
        if (document.location.href.includes('/new')){
          redirect_hack = ''
          console.log('realizes its on the new page!')
        } else {
          redirect_hack = 'reservations/'
        }

        var event_ids = []
        var businessHours = gon.venue_business;
        var calendar = $(this);
        calendar.fullCalendar({
          eventColor: '#2ecc71',
          eventSources: [
              {
                url: user_events,
                color: '#2ecc71',
              },
              {
                url: event_source,
                color: '#E74C3C',
                error: function() {
                    alert('Viewing user reservations!');
                },
              }
          ],
          defaultView: 'agendaWeek',
          height:500,
          header: {
              left: 'today',
              center: 'prev title next',
              right: 'month,agendaWeek,agendaDay'
          },
          selectable :true,
          selectHelper: true,
          editable: false,
          eventOverlap: false,
          slotEventOverlap: false,

          eventOrder: "-source", //neccessary to make user events load first.
          eventRender: function(event, element) {
              element.tooltip({
                  content: event.title
              });
              /*
              if(event.color == null) {
                  element.css('background-color', 'green');
              };*/

              //HACKY JAVASCRIPT TO PREVENT DUPLICATE RENDERING

              if(event_ids.includes(event.id) && event.title != null) {
                return false;
              }
              event_ids.push(event.id)
          },
          eventAfterAllRender: function(view) {
            event_ids = []
          },
          /*

          eventMouseover: function (event, element) {
            var tooltip = event.title;

            $(this).attr("data-original-title", tooltip)
            $(this).popover({title: 'Hi', container: "body"})
           },

          //testing
        
          eventMouseover: function(calEvent, jsEvent) {

              $(this).tooltip({title:calEvent.title, html: true, container: "body"});
              $(this).tooltip('show');

              
              var tooltip = '<div class="tooltipevent" style="width:100px;height:100px;background:#ccc;position:absolute;z-index:10001;">' + calEvent.title + '</div>';
              var $tooltip = $(tooltip).appendTo('body');

              $(this).mouseover(function(e) {
                  $(this).css('z-index', 10000);
                  $tooltip.fadeIn('500');
                  $tooltip.fadeTo('10', 1.9);
              }).mousemove(function(e) {
                  $tooltip.css('top', e.pageY + 10);
                  $tooltip.css('left', e.pageX + 20);
              });
          },

          eventMouseout: function(calEvent, jsEvent) {
              $(this).css('z-index', 8);
              $('.tooltipevent').remove();
          },
              */

          // testing ^

          selectOverlap: function(event) {
              return event.rendering === 'background';
          },
          eventLimit: true,
          allDaySlot: false,
          eventClick: function(calEvent, jsEvent, view) {
            document.location.href =  redirect_hack + calEvent.id
          },
          minTime: "07:00:00",
          maxTime: "21:00:00",
          /*
          businessHours: [ // specify an array instead
              {
                  dow: [ 1, 2, 3 ], // Monday, Tuesday, Wednesday
                  start: '08:00', // 8am
                  end: '18:00' // 6pm
              },
              {
                  dow: [ 4, 5 ], // Thursday, Friday
                  start: '10:00', // 10am
                  end: '16:00' // 4pm
              }
          ],
          */
          unselectAuto: false,
          displayEventTime: true,
          select: function(start, end) {
            $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'))
            $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));

            $('#testing').val(moment(end).format('YYYY-MM-DD HH:mm'));

            if (!start.startOf('day').isSame(end.startOf('day'))) {
                 calendar.fullCalendar( 'unselect' );
            }
          },
          /*
          select: function(start, end) {
            $.getScript( venue_fix + '/reservations/new', function() {
              $('#reservation_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
              date_range_picker();
              $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
              $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
              
            });

            calendar.fullCalendar('unselect');
          },
          */
          /*
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
          */
        });
      })
  };
$(document).on('turbolinks:load', initialize_calendar);
