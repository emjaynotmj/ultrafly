FactoryGirl.define do

  names = [
    'Nnamdi Azikwe International Airport, Abuja',
    'Akanu Ibiam International Airport, Enugu',
    'Alakia Airport, Ibadan'
  ]

  sequence(:name) do |name|
    names[name - 1]
  end

  factory :airport do
    name
  end
end