class HorariosController < ApplicationController
  before_action :authenticate_psicologo!
 # Verifica que el psicólogo esté autenticado

  # Acción para mostrar la lista de citas disponibles
  def index
    # Asegúrate de cargar todos los horarios disponibles
    @horarios = Horario.all  # O ajusta esta línea según cómo se manejen los horarios en tu modelo
  end

  
  # Mostrar formulario para crear un nuevo horario
  def new
    @horario = Horario.new
  end

  # Crear un nuevo horario
  def create
    @horario = Horario.new(horario_params)
    @horario.psicologo_id = current_psicologo.id  # Asignamos el psicólogo autenticado

    if @horario.save
      redirect_to root_path, notice: 'Horario creado exitosamente.'
    else
      render :new  # En caso de error, volvemos al formulario
    end
  end

  private

  # Método para verificar que el psicólogo esté autenticado
  def require_psicologo
    redirect_to root_path unless current_psicologo  # Si no está autenticado, redirige
  end

  # Obtener los parámetros permitidos para crear un horario
  def horario_params
    params.require(:horario).permit(:dia, :hora_inicio, :hora_fin)
  end

  # Método para obtener el psicólogo actual desde la sesión
  def current_psicologo
    @current_psicologo ||= Psicologo.find(session[:psicologo_id]) if session[:psicologo_id]
  end
end
