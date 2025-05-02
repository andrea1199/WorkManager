FactoryBot.define do
  factory :user do
    sequence(:nome) { |n| "John#{n}" }
    sequence(:cognome) { |n| "Doe#{n}" }
    data_di_nascita { "1990-01-01" }
    email { Faker::Internet.unique.email }
    password { "password" }
    skip_inizializza_campi { true }

    trait :admin do
      ruolo { "admin" }
    end

    trait :dirigente do
      ruolo { "dirigente" }
    end

    trait :dipendente do
      ruolo { "dipendente" }
    end
  end
end