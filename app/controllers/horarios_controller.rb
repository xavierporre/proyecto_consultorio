class HorariosController < ApplicationController
  before_action :authenticate_psicologo!
  
  def index
    @horarios = Horario.all

    # Filtrar por fechas si se envían parámetros
    if params[:fecha_inicio].present? && params[:fecha_fin].present?
      @horarios = @horarios.where(fecha: params[:fecha_inicio]..params[:fecha_fin])
    end

    # Paginación (10 resultados por página)
    @horarios = @horarios.page(params[:page]).per(10)

    @horario = Horario.new
  end

  def create
    success = true
    saved_horarios = []
    
    # Convert the date string from Flatpickr to an array of dates
    fechas = params[:horario][:fechas].split(',').map(&:strip)
    
    fechas.each do |fecha|
      @horario = Horario.new(horario_params)
      @horario.fecha = Date.parse(fecha)
      
      if @horario.save
        begin
          @horario.generar_citas_disponibles
          saved_horarios << @horario
        rescue => e
          success = false
          # Delete the horario if appointment generation fails
          @horario.destroy
          logger.error "Error generating appointments for date #{fecha}: #{e.message}"
        end
      else
        success = false
        break
      end
    end
    
    if success
      redirect_to horarios_path, notice: "#{saved_horarios.count} horarios creados exitosamente y citas generadas."
    else
      # If any creation failed, rollback all created horarios
      saved_horarios.each(&:destroy)
      @horario = Horario.new(horario_params) # Reset form with last attempted values
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    @horario = Horario.find(params[:id])
    if @horario.destroy
      redirect_to horarios_path, notice: 'Horario eliminado exitosamente.'
    else
      redirect_to horarios_path, alert: 'No se pudo eliminar el horario.'
    end
  end
  
  private

  def horario_params
    params.require(:horario).permit(:fecha, :hora_inicio, :hora_fin, :intervalo)
  end

end
