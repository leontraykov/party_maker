class User < ApplicationRecord
  before_validation :set_name, on: :create
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, dependent: :delete_all
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: {maximum: 35}

  private

  def set_name
    self.name = "Товарисч №#{rand(999)}" if self.name.blank?
  end
end
