class FixCitaDisponibleReferenceInReservas < ActiveRecord::Migration[7.2]
  def change
    # Cambiar el tipo de columna 'cita_disponible_id' a 'bigint'
    change_column :reservas, :cita_disponible_id, :bigint, null: false

    # Agregar la clave foránea
    add_foreign_key :reservas, :citas_disponibles, column: :cita_disponible_id
  end
end
