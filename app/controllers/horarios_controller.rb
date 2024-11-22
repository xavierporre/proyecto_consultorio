class HorariosController < ApplicationController
  before_action :authenticate_psicologo!
  
  def index
    @horarios = Horario.all.order(fecha: :asc, hora_inicio: :asc)
    @horario = Horario.new
  end

  def create
    @horario = Horario.new(horario_params)

    if @horario.save
      @horario.generar_citas_disponibles
      redirect_to horarios_path, notice: 'Horario creado exitosamente y citas generadas.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def horario_params
    params.require(:horario).permit(:fecha, :hora_inicio, :hora_fin, :intervalo)
  end

end
