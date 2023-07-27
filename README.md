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
| nickname            | string         | null: false                      |
| email               | string         | null: false, unique: true        |
| encrypted_password  | string         | null: false                      |
| zen_lastname        | string         | null: false                      |
| zen_firstname       | string         | null: false                      |
| kana_firstname      | string         | null: false                      |
| kana_lastname       | string         | null: false                      |
| birthday            | date           | null: false                      |

### Association
- has_many :items
- has_many :orders


## itemsテーブル
| Column              | Type            | Options                          |
| ------------------- | --------------- | -------------------------------- |
| name                | string          | null: false                      |
| description         | text            | null: false                      |
| category_id         | integer         | null: false                      |
| status_id           | integer         | null: false                      |
| shipmentfee_id      | integer         | null: false                      |
| senderarea_id       | integer         | null: false                      |
| waitingday_id       | integer         | null: false                      |
| item_price          | integer         | null: false                      |
| user                | references      | null: false, foreign_key: true   |



### Association
- belongs_to :user
- has_one :order

## ordersテーブル
| Column              | Type            | Options                          |
| ------------------- | --------------- | -------------------------------- |
| user                | references      | null: false, foreign_key: true   |
| item                | references      | null: false, foreign_key: true   |
| address             | references      | null: false, foreign_key: true   |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル
| Column              | Type            | Options                          |
| ------------------- | --------------- | -------------------------------- |
| post_code           | string          | null: false                      |
| prefecture_id       | integer         | null: false                      |
| town                | string          | null: false                      |
| block_number        | string          | null: false                      |
| building_name       | string          |                                  |
| phone_number        | string          | null: false                      |

### Association
- belongs_to :orders