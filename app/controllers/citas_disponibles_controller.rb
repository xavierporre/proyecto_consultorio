class CitasDisponiblesController < ApplicationController

  def index
    @citas_disponibles = CitaDisponible.where(estado: 'disponible')
    
    if params[:fecha_inicio].present?
      inicio = Date.parse(params[:fecha_inicio]).beginning_of_day
      @citas_disponibles = @citas_disponibles.where("fecha_hora >= ?", inicio)
    end
  
    if params[:fecha_fin].present?
      fin = Date.parse(params[:fecha_fin]).end_of_day
      @citas_disponibles = @citas_disponibles.where("fecha_hora <= ?", fin)
    end
  
    # Store the paginated results
    @citas_disponibles = @citas_disponibles.order(fecha_hora: :asc).page(params[:page]).per(10)
    
    # Map events for calendar (using the non-paginated query to show all events in calendar)
    @events = CitaDisponible.where(id: @citas_disponibles.pluck(:id)).map do |cita|
      {
        title: cita.estado == 'disponible' ? 'Disponible' : 'Reservada',
        start: cita.fecha_hora.iso8601,
        end: cita.fecha_hora.iso8601,
        id: cita.id,
        color: cita.estado == 'disponible' ? '#28a745' : '#dc3545'
      }
    end
  end


  private

  def set_cita_disponible
    @cita_disponible = CitaDisponible.find(params[:id]) # Buscar la cita disponible
  end

  def reserva_params
    params.require(:reserva).permit(:nombre, :rut, :email, :horario_id)
  end
end
