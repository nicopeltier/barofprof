class School < ApplicationRecord
  has_many :surveys, dependent: :destroy
  has_many :school_directors, dependent: :destroy
  has_many :teachers, dependent: :destroy
  enum :status, { created: 0, directors_invited: 1, directors_connected: 2, questionnaire: 3, closed: 4 }
  validates :name, presence: true

  # Gestion des thèmes sélectionnés
  def selected_theme_ids
    settings_json&.dig('selected_theme_ids') || Theme.pluck(:id)
  end

  def selected_theme_ids=(theme_ids)
    self.settings_json = (settings_json || {}).merge('selected_theme_ids' => theme_ids.map(&:to_i))
  end

  def theme_selected?(theme_id)
    selected_theme_ids.include?(theme_id.to_i)
  end

  def can_modify_themes?
    # Ne peut pas modifier si une enquête est lancée
    !surveys.launched.exists?
  end
end