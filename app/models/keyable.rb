module Keyable
  def self.included(into)
    into.before_save ->(model) {
      model.key = model.send(model.key_attr).to_s.parameterize.underscore
    }
  end

  def key_attr
      :name
  end
end