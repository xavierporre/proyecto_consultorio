class CitasDisponiblesController < ApplicationController
    def index
      @citas_disponibles = CitaDisponible.where(horario_id: params[:horario_id], estado: 'disponible')
    end
  
    def update
      @cita = CitaDisponible.find(params[:id])
      if @cita.estado == 'disponible'
        @cita.update(estado: 'reservada', paciente_params)
        redirect_to root_path, notice: 'Cita reservada con éxito.'
      else
        redirect_to root_path, alert: 'La cita ya no está disponible.'
      end
    end
  
    private
  
    def paciente_params
      params.require(:cita_disponible).permit(:nombre_paciente, :rut_paciente, :email_paciente)
    end
  end
  