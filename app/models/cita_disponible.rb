class CitaDisponible < ApplicationRecord
  self.table_name = 'citas_disponibles'
  belongs_to :horario
  has_many :reservas, dependent: :destroy
  paginates_per 10  # Default number of items per page
  max_paginates_per 100  # Maximum allowed items per page

  validates :fecha_hora, presence: true
  validates :estado, inclusion: { in: %w[disponible reservada cancelada] }
  def reservar!
    update(estado: 'reservada')
  end
end
