FactoryGirl.define do
  # names = [
  #   "Nnamdi Azikwe International Airport, Abuja",
  #   "Akanu Ibiam International Airport, Enugu",
  #   "Alakia Airport, Ibadan"
  # ]

  # sequence(:name) do |name|
  #   names[name - 1]
  # end

  # factory :airport do
  #   name
  # end
  factory :airport do
    name { Faker::Space.agency }
    state { Faker::Address.state }
    # flight
  end
end
