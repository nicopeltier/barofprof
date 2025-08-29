class Theme < ApplicationRecord
    has_many :questions, dependent: :destroy
    validates :number, presence: true, uniqueness: true
    validates :name, presence: true
    attribute :active, :boolean, default: true
    default_scope { order(number: :asc) }
    end