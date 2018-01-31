require 'rspec'
require_relative '../db/companies_loader'

RSpec.configure do |config|
  config.order = :random
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before do
    [Employee, OrgUnit, Company].each do |model|
      model.connection.execute("SET FOREIGN_KEY_CHECKS = 0;")
      model.connection.execute("TRUNCATE #{model.table_name};")
      model.connection.execute("SET FOREIGN_KEY_CHECKS = 1;")
    end
    CompaniesLoader.new.load!
  end
end
