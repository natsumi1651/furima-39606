FactoryBot.define do
  factory :item do
    name               { 'test' }
    description        { 'test' }
    item_price         { 1000 }
    category           { Category.find_by(id: 2) }
    status             { Status.find_by(id: 2) }
    shipmentfee        { Shipmentfee.find_by(id: 2) }
    prefecture         { Prefecture.find_by(id: 2) }
    waitingday         { Waitingday.find_by(id: 2) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    association :user 
  end
end
