class CreateReservas < ActiveRecord::Migration[7.2]
  def change
    create_table :reservas do |t|
      t.string :nombre
      t.string :rut
      t.string :email
      t.references :horario, null: false, foreign_key: true
      t.string :estado

      t.timestamps
    end
  end
end
