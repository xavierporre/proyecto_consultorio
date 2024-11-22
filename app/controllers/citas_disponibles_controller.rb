class CitasDisponiblesController < ApplicationController

  def index
    @horarios = Horario.all
    @citas_disponibles = CitaDisponible.where(estado: 'disponible')
  end


  private

  def set_cita_disponible
    @cita_disponible = CitaDisponible.find(params[:id]) # Buscar la cita disponible
  end

  def reserva_params
    params.require(:reserva).permit(:nombre, :rut, :email, :horario_id)
  end
end
