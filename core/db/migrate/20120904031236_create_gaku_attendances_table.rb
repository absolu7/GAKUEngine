class CreateGakuAttendancesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_attendances do |t|
  		t.text :reason
      
  		t.references :attendancable, :polymorphic => true
      t.references :student
  		t.references :attendance_type
      
  		t.timestamps
  	end
  end
end
