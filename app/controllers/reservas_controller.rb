class ReservasController < ApplicationController

  # Asegurarse de que solo el psicólogo autenticado pueda acceder a la acción 'index'
  before_action :authenticate_psicologo!, only: [:index]  # Solo para 'index'

  def new
    @citas_disponible = CitaDisponible.find(params[:citas_disponible_id])
    @reserva = Reserva.new
  end

  def create
    @citas_disponible = CitaDisponible.find(params[:citas_disponible_id])
    @reserva = @citas_disponible.reservas.build(reserva_params)

    if @reserva.save
      # Cambiar el estado de la cita a 'reservada'
      @citas_disponible.update(estado: 'reservada')
      redirect_to citas_disponibles_path, notice: 'Reserva realizada con éxito.'
    else
      render :new
    end
  end
  
  def index
    @reservas = Reserva.all  # O puedes filtrar las reservas según el psicólogo si es necesario
  end
  private

  def reserva_params
    params.require(:reserva).permit(:nombre, :rut, :email)
  end
end
