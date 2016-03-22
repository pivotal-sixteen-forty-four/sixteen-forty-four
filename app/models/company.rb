class Company
  include ActiveModel::Model
  attr_accessor :name, :details, :title, :suite, :floor, :instructions, :phone, :website, :org_units

  def self.all
    I18n.t('companies').map do |name, details|
      new(**details.merge(name: name))
    end
  end
end