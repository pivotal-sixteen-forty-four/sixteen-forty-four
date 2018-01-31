class OrgUnit < ApplicationRecord
  include Keyable

  belongs_to :company
  has_many :employees
  accepts_nested_attributes_for :employees, allow_destroy: true
  validates :name, presence: true
end
