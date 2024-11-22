class Reserva < ApplicationRecord
  belongs_to :cita_disponible

  validates :nombre, :rut, :email, presence: true
end
