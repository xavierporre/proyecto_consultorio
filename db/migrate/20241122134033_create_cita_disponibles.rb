class CreateCitaDisponibles < ActiveRecord::Migration[7.2]
  def change
    create_table :citas_disponibles do |t|
      t.datetime :fecha_hora, null: false
      t.string :estado, null: false, default: 'disponible'
      t.references :horario, null: false, foreign_key: true
      t.timestamps
    end
  end
end
