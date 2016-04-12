# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
%w(
  jdonahue@pivotal.io
  ttaylor@pivotal.io
  kcutter@pivotal.io
  jwilbern@pivotal.io
  krista@galvanize.com
  alwelch@pivotal.io
).each do |email|
  Admin.create!(email: email)
end
