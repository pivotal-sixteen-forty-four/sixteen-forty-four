class CompaniesLoader
  def initialize
  end

  def load!
    company_specs.each do |key, company_spec|
      company = create_company_for(key, company_spec)
      Array(company_spec['org_units']).each do |org_key, org_spec|
        org_unit = create_org_unit_for(company, org_key, org_spec)
        Array(org_spec['contacts']).each do |contact_key, contact_spec|
          create_employee_for(contact_key, contact_spec, org_unit)
        end
      end
    end
  end

  private
  def company_specs
    YAML.load(File.read(File.expand_path('../config/locales/en.yml', __dir__)))['en']['companies']
  end

  def create_company_for(key, params)
    company = Company.find_or_initialize_by(key: key)
    company.update_attributes(
      params.slice(*%w(title floor suite instructions phone website))
    )
    company.save!
    company
  end

  def create_org_unit_for(company, org_key, org_spec)
    org_unit = company.org_units.find_or_initialize_by(key: org_key)
    org_unit.update_attributes(
      org_spec.slice(*%w(name))
    )
    org_unit.save!
    org_unit
  end

  def create_employee_for(contact_key, contact_spec, org_unit)
    employee = org_unit.employees.find_or_initialize_by(key: contact_key)
    employee.update_attributes(
      contact_spec.slice(*%w(name title))
    )
    employee.save!
  end
end