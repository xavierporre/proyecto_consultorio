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

    @events = @citas_disponibles.map do |cita|
      {
        title: cita.estado == 'disponible' ? 'Disponible' : 'Reservada',
        start: cita.fecha_hora.iso8601,
        end: cita.fecha_hora.iso8601,
        id: cita.id,
        color: cita.estado == 'disponible' ? '#28a745' : '#dc3545' # Verde para disponibles, rojo para reservadas
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
