class CreateGakuAdmissionPhaseRecords < ActiveRecord::Migration
  def change
  	create_table :gaku_admission_phase_records do |t|
  		t.references :admission
  		t.references :admission_phase
      t.references :admission_phase_state
  	end
  end
end
