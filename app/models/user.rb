class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :zen_lastname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/ }
  validates :zen_firstname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/ }
  validates :kana_firstname, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :kana_lastname, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birthday, presence: true
  validates :password,  format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-z\d]+\z/i }

  has_many :items
end
