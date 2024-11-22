class CitaDisponible < ApplicationRecord
  self.table_name = 'citas_disponibles'
  belongs_to :horario
  has_many :reservas

  validates :fecha_hora, presence: true
  validates :estado, inclusion: { in: %w[disponible reservada cancelada] }
  def reservar!
    update(estado: 'reservada')
  end
end
