# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## usersテーブル
| Column              | Type           | Options                          |
| ------------------- | -------------- | -------------------------------- |
| nickname            | string         | null: false, unique: true        |
| email               | string         | null: false , unique: true       |
| encrypted_password  | string         | null: false                      |
| name                | string         | null: false                      |
| birthday            | integer        | null: false                      |

### Association
- has_many :items
- has_many :orders


## itemsテーブル
| Column              | Type            | Options                          |
| ------------------- | --------------- | -------------------------------- |
| item_image          | text            | null: false                      |
| item_name           | string          | null: false                      |
| item_description    | text            | null: false                      |
| item_category       | string          | null: false                      |
| item_category       | string          | null: false                      |
| item_status         | string          | null: false                      |
| item_shipmentfee    | string          | null: false                      |
| sender_area         | string          | null: false                      |
| waiting_day         | string          | null: false                      |
| item_price          | integer         | null: false                      |
| user                | references      | null: false, foreign_key: true   |
| seller              | string          | null: false                      |

### Association
- belongs_to :user
- has_one :order

## ordersテーブル
| Column              | Type            | Options                          |
| ------------------- | --------------- | -------------------------------- |
| buyer               | string          | null: false                      |
| user                | references      | null: false, foreign_key: true   |
| item                | references      | null: false, foreign_key: true   |
### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル
| Column              | Type            | Options                          |
| ------------------- | --------------- | -------------------------------- |
| post_code           | integer         | null: false                      |
| prefecture          | string          | null: false                      |
| town                | string          | null: false                      |
| block_number        | string          | null: false                      |
| building_name       | string          | null: false                      |
| phone_number        | integer         | null: false                      |
| user                | references      | null: false, foreign_key: true   |

### Association
- belongs_to :address