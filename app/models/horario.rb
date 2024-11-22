class Horario < ApplicationRecord
    has_many :citas_disponibles, dependent: :destroy
  
    validates :fecha, presence: true
    validates :hora_inicio, :hora_fin, presence: true
    validates :intervalo, numericality: { greater_than: 0 }
  
    after_create :generar_citas_disponibles
  
    private
  
    def generar_citas_disponibles
      bloques = ((hora_fin - hora_inicio) / (intervalo * 60)).to_i
      bloques.times do |i|
        inicio_bloque = hora_inicio + i * intervalo.minutes
        CitaDisponible.create!(
          fecha_hora: DateTime.new(fecha.year, fecha.month, fecha.day, inicio_bloque.hour, inicio_bloque.min),
          estado: 'disponible',
          horario: self
        )
      end
    end
  end
  