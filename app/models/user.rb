class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :school_directors, dependent: :destroy
  has_many :schools, through: :school_directors

  def admin?
    admin
  end
end
