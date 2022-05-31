class Questionnaire < ApplicationRecord
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
  belongs_to :user
  validates :token, uniqueness: true
end
