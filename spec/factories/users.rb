FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    zen_lastname          { '山田' }
    zen_firstname         { '陸太郎' }
    kana_firstname        { 'ヤマダ' }
    kana_lastname         { 'リクタロ' }
    birthday              { Faker::Date.birthday }
  end
end
