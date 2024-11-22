class CitasDisponiblesController < ApplicationController
  
  before_action :authenticate_psicologo!, only: [:create, :update]  # Verifica autenticación
def index
    # Asegúrate de cargar todos los horarios disponibles
    @horarios = Horario.all  # O ajusta esta línea según cómo se manejen los horarios en tu modelo
  end
  # Acción para crear una cita
  def create
    @cita = CitaDisponible.find(params[:id])  # Buscamos la cita disponible por su ID

    if @cita.estado == 'disponible'  # Verificamos si la cita está disponible
      # Actualizamos la cita con el estado 'reservada' y los parámetros del paciente
      if @cita.update(paciente_params.merge(estado: 'reservada'))
        redirect_to root_path, notice: 'Cita reservada con éxito.'  # Redirigimos con éxito
      else
        redirect_to root_path, alert: 'Hubo un problema al reservar la cita.'  # Si hay algún error en la actualización
      end
    else
      redirect_to root_path, alert: 'La cita ya no está disponible.'  # Si la cita ya no está disponible
    end
  end

  # Acción para actualizar los detalles de una cita reservada
  def update
    @cita = CitaDisponible.find(params[:id])  # Buscamos la cita por su ID

    # Verificamos si la cita ya está reservada
    if @cita.estado == 'reservada'
      if @cita.update(paciente_params)  # Actualizamos solo los detalles del paciente
        redirect_to root_path, notice: 'Cita actualizada con éxito.'
      else
        redirect_to root_path, alert: 'Hubo un problema al actualizar la cita.'
      end
    else
      redirect_to root_path, alert: 'La cita no está reservada o ya no está disponible.'
    end
  end

  private

  # Método para obtener los parámetros del paciente
  def paciente_params
    params.require(:cita_disponible).permit(:nombre, :rut, :email)
  end
end

