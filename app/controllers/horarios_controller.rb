class HorariosController < ApplicationController
    before_action :authenticate_psicologo! # Solo psicólogos autenticados pueden acceder.
  
    def index
      @horarios = Horario.all
    end
  
    def new
      @horario = Horario.new
    end
  
    def create
      @horario = Horario.new(horario_params)
      if @horario.save
        redirect_to horarios_path, notice: 'Horario creado con éxito.'
      else
        render :new, alert: 'Error al crear el horario.'
      end
    end
  
    private
  
    def horario_params
      params.require(:horario).permit(:fecha, :hora_inicio, :hora_fin, :intervalo)
    end
  end
  