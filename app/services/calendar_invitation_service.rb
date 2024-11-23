require 'icalendar'

class CalendarInvitationService
  def self.generate_ics(cita)
    cal = Icalendar::Calendar.new

    cal.event do |e|
      e.dtstart     = cita.fecha_hora.strftime('%Y%m%dT%H%M%S') # Fecha de inicio
      e.dtend       = (cita.fecha_hora + 1.hour).strftime('%Y%m%dT%H%M%S') # Fecha de fin
      e.summary     = 'Consulta Psicológica'
      e.description = "Consulta programada con el psicólogo a las #{cita.fecha_hora.strftime('%H:%M')}."
      e.location    = 'Consultorio Psicológico'
    end

    cal.publish
    cal.to_ical
  end
end
