json.extract! company, :id, :name, :floor, :suite, :instructions, :phone, :website, :created_at, :updated_at
json.url company_url(company, format: :json)
