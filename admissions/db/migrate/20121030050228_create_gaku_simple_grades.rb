class CreateGakuSimpleGrades < ActiveRecord::Migration
  def change
  	create_table :gaku_simple_grades do |t|
      t.string :name
      t.string :grade

      t.timestamps
  	end
  end
end