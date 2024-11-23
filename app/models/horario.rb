class Horario < ApplicationRecord
    validates :fecha, presence: true
    has_many :cita_disponibles, dependent: :destroy
  
    validates :hora_inicio, :hora_fin, presence: true
    validates :intervalo, numericality: { greater_than: 0 }
  
    after_create :generar_citas_disponibles
  
   
  
    def generar_citas_disponibles
      # Convert string times to Time objects if they aren't already
      inicio = hora_inicio.is_a?(String) ? Time.parse(hora_inicio) : hora_inicio
      fin = hora_fin.is_a?(String) ? Time.parse(hora_fin) : hora_fin
      
      # Calculate number of blocks
      duracion_total_segundos = fin - inicio
      duracion_intervalo_segundos = intervalo.to_i * 60
      bloques = (duracion_total_segundos / duracion_intervalo_segundos).to_i
      
      # Validate time slots
      raise "La hora de fin debe ser posterior a la hora de inicio" if bloques <= 0
      raise "El intervalo debe generar al menos una cita" if intervalo.to_i <= 0
      
      # Generate appointments
      bloques.times do |i|
        inicio_bloque = inicio + (i * duracion_intervalo_segundos)
        
        # Create the appointment using fecha from horario
        cita_disponibles.create!(
          fecha_hora: DateTime.new(
            fecha.year,
            fecha.month,
            fecha.day,
            inicio_bloque.hour,
            inicio_bloque.min,
            0,
            Time.zone.utc_offset
          ),
          estado: 'disponible',
          horario: self
        )
      end
    end

    def hora_fin_despues_de_inicio
      return unless hora_inicio && hora_fin && intervalo
      
      if hora_fin <= hora_inicio
        errors.add(:hora_fin, "debe ser posterior a la hora de inicio")
      end
      
      if intervalo.to_i <= 0
        errors.add(:intervalo, "debe ser mayor que cero")
      end
    
      # Calculate if at least one appointment can be generated
      duracion_total = (hora_fin - hora_inicio).to_i
      if duracion_total < intervalo.to_i * 60
        errors.add(:base, "El intervalo es demasiado grande para el período de tiempo seleccionado")
      end
    end
    
    def disponible?
      cita_disponibles.exists?(estado: 'disponible')
    end
  end
  