FactoryBot.define do
  factory :order_address do
    post_code  { '123-4567' }
    prefecture_id { 2 }
    town { 'あああ' }
    block_number { '1-1' }
    phone_number { '0000000000' }
    association :user
    association :item
  end
  
end
