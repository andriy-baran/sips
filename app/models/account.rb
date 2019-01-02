class Account < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :trackable
  belongs_to :point_of_sale, optional: true, foreign_key: :pos_id
  has_many :stocks

  def has_role?(role)
    self.role == role.to_s
  end
end
