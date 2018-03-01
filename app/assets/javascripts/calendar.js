var initialize_calendar;
initialize_calendar = function () {

      $('.calendar').each(function(){
        var event_source
        if (gon.venue_id != null) {
          //we're on /new page
          console.log('VENUE NOT NULL')
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
        var businessHours = gon.venue_business;
        var calendar = $(this);
        var event_ids = []
        calendar.fullCalendar({
          eventSources: [
              {
                url: user_events,
                color: '#2ecc71',
                id: 'testing',
                rendering: 'background',
                //backgroundColor: '#abeac6',
              },
              {
                url: event_source,
                color: '#E74C3C',
              }
          ],
          /*
          events: [
          {
            title: 'tESTING HELLO',
            start: '2018-02-27T10:30:00',
            end: '2018-02-27T12:30:00',
            rendering: 'background'
          },
          {
            start: '2018-02-27T10:00:00',
            end: '2018-02-27T12:30:00',
            rendering: 'background'
          },
          {
            start: '2018-02-27T10:30:00',
            end: '2018-02-27T12:30:00',
            rendering: 'background'
          },
          {
             title: 'Meeting1',
            start: '2018-02-27T11:30:00',
          },
          {
             title: 'Meeting2',
            start: '2018-02-27T12:15:00'
          },
          {
             title: 'Meeting3',
            start: '2018-02-27T12:30:00'
          }
        ],*/
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
          unselectAuto: false,
          displayEventTime: true,
          eventLimit: true,
          allDaySlot: false,
          eventColor: '#2ecc71',
          minTime: "07:00:00",
          maxTime: "21:00:00",
          selectOverlap: false,
          //eventOrder: "-color", //neccessary to make user events load first.
          selectConstraint: {
            start: moment().format('YYYY-MM-DD'),
            end: '2100-01-01' // hard coded goodness unfortunately
          },
          eventRender: function(event, element) {

              element.popover({
                title: event.title,
                content: event.description,
                trigger: 'hover',
                placement: 'top',
                container: 'body'
              });
              console.log(event.id)
              

              /*

              if(event.color == null) {
                  element.css('background-color', 'green');
              };

              //HACKY JAVASCRIPT TO PREVENT DUPLICATE RENDERING
              //console.log(event.user, event.source.color)

              if ((event.user == gon.user_id && event.source.color == '#2ecc71') || (event.user != gon.user_id)) {
                console.log('Rendered!')
                event.rendering = 'background'
                return true
              } else {
                console.log('Event ignored',event.id, event.user, event.source.color)
                return false
              }
              
              */
              if(event_ids.includes(event.id) && event.title != null)  {
                return false;
              } else if (event_ids.includes(event.id) && event.color == '#E74C3C') {
                return false
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

          // testing ^

          selectOverlap: function(event) {
              return event.rendering === 'background';
          },
              */

          eventClick: function(event, jsEvent, view) {
            //calendar.fullCalendar('updateEvent', event);
            if (event.id != null) {
              document.location.href =  redirect_hack + event.id
            }
            
          },
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
          
          select: function(start, end) {
            $.ajax({
              url: '/time_preview',
              type: 'post',
              dataType: 'script',
              data: {"start": moment(start).format("YYYY-MM-DD HH:mm"),"end": moment(end).format('YYYY-MM-DD HH:mm')},
            })

            if ((!start.startOf('day').isSame(end.startOf('day'))) || (start.isBefore(moment()))) {
                alert('Please select it on the same day and after the current time')
                $('.start_hidden').val(null)
            } else {
              $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'))
              $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'))
              
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
