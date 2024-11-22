class CitaDisponible < ApplicationRecord
  belongs_to :horario

  validates :fecha_hora, presence: true
  validates :estado, inclusion: { in: %w[disponible reservada cancelada] }
end
