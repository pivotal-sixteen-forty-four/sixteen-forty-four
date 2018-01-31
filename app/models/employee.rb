class Employee < ApplicationRecord
  include Keyable

  belongs_to :org_unit
  validates :name, :title, presence: true
end
