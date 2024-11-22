class Horario < ApplicationRecord
    validates :fecha, presence: true
    has_many :cita_disponibles, dependent: :destroy
  
    validates :hora_inicio, :hora_fin, presence: true
    validates :intervalo, numericality: { greater_than: 0 }
  
    after_create :generar_citas_disponibles
  
   
  
    def generar_citas_disponibles
      bloques = ((hora_fin - hora_inicio) / (intervalo * 60)).to_i
      bloques.times do |i|
        inicio_bloque = hora_inicio + i * intervalo.minutes
        cita_disponibles.create!(
          fecha_hora: DateTime.new(fecha.year, fecha.month, fecha.day, inicio_bloque.hour, inicio_bloque.min),
          estado: 'disponible',
          horario: self
        )
      end
    end

    def hora_fin_despues_de_inicio
      return if hora_inicio.blank? || hora_fin.blank?
  
      if hora_fin <= hora_inicio
        errors.add(:hora_fin, "debe ser después de la hora de inicio")
      end
    end
    
    def disponible?
      cita_disponibles.exists?(estado: 'disponible')
    end
  end
  