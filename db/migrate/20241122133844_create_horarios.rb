class CreateHorarios < ActiveRecord::Migration[7.2]
  def change
    create_table :horarios do |t|
      t.date :fecha
      t.time :hora_inicio
      t.time :hora_fin
      t.integer :intervalo

      t.timestamps
    end
  end
end
