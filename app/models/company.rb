class Company < ActiveRecord::Base
  include Keyable

  has_many :org_units
  accepts_nested_attributes_for :org_units, allow_destroy: true
  validates :title, :title, :suite, :floor, :instructions, :phone, :website, presence: true

  def key_attr
    :title
  end
end