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
  
      # Enviar invitación al calendario
      begin
        CalendarInvitationService.new(
          psicologo_email: "xporre@gmail.com", # Cambia por el email del psicólogo
          paciente_email: @reserva.email,           # Email del paciente desde la reserva
          fecha_hora: @citas_disponible.fecha_hora,
          descripcion: "Sesión reservada con el psicólogo"
        ).send_invitation
  
        notice_message = 'Reserva realizada con éxito e invitación enviada.'
      rescue => e
        Rails.logger.error("Error enviando la invitación: #{e.message}")
        notice_message = 'Reserva realizada con éxito, pero no se pudo enviar la invitación.'
      end
  
      redirect_to citas_disponibles_path, notice: notice_message
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
