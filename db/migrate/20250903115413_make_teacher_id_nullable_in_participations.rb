class MakeTeacherIdNullableInParticipations < ActiveRecord::Migration[8.0]
  def change
    change_column_null :participations, :teacher_id, true
  end
end
