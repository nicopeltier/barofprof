class AddInvitationFieldsToSchoolDirectors < ActiveRecord::Migration[8.0]
  def change
    add_column :school_directors, :invited_at, :datetime
    add_column :school_directors, :invitation_token, :string
    add_column :school_directors, :invitation_accepted_at, :datetime
  end
end
