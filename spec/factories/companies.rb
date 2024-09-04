
FactoryBot.define do
    factory :company do
      sequence(:name) { |n| "Company#{n}" }
    end
  
    factory :default_company, class: 'Company' do
      name { "Default Company" }
  
      after(:build) do |company|
        Company.find_or_create_by(name: company.name)
      end
    end
  end
  