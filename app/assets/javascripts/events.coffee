$ ->
  $('#calendar').fullCalendar
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'agendaWeek'
    defaultDate: window.currentDate
    editable: true
    nextDayThreshold: '00:00:00'
    events: (start, end, timezone, callback) ->
      $.ajax
        url: '/events.json'
        dataType: 'json'
        data:
          start: start.unix()
          end: end.unix()
        success: (json) ->
          events = []
          for event in json.events
            do ->
              events.push
                title: event.title
                start: event.start
                end: event.end
              return
          callback events
          return

  $('#form').on 'ajax:error', 'form', ->
    alert 'Error!'

  $('#form').on 'ajax:success', 'form', ->
    $('#calendar').fullCalendar( 'refetchEvents' )