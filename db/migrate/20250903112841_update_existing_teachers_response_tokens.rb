class UpdateExistingTeachersResponseTokens < ActiveRecord::Migration[8.0]
  def up
    Teacher.where(response_token: nil).find_each do |teacher|
      teacher.update!(response_token: SecureRandom.urlsafe_base64(32))
    end
  end

  def down
    # Pas de rollback nécessaire
  end
end
