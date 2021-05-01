# テーブル設計

## users テーブル

| Column             | Type    | Options                  |
| --------           | ------  | -----------              |
| name               | string  | null: false              |
| email              | string  | null: false unique: true |
| encrypted_password | string  | null: false              |
| kanji_first        | string  | null: false              |
| kanji_last         | string  | null: false              |
| kana_first         | string  | null: false              |
| kana_last          | string  | null: false              |
| yyyymmdd           | date    | null: false              |

### Association

- has_many :items
- has_many :comments
- has_many :purchases

## items テーブル

| Column           | Type       | Options     |
| -----------      | ---------  | ----------- |
| item_name        | string     | null: false |
| explanation      | text       | null: false |
| category_id      | integer    | null: false |
| status_id        | integer    | null: false |
| delivery_fee_id  | integer    | null: false |
| area_id          | integer    | null: false |
| shipment_days_id | integer    | null: false |
| price            | integer    | null: false |
| user             | references | null: false, foreign_key: true|
| comment          | references | null: false, foreign_key: true|
| purchase         | references | null: false, foreign_key: true|


### Association

- belongs_to :user
- has_many :comments
- has_one  :purchase


## comments テーブル

| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| comment      | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## purchases テーブル

| Column         | Type       | Options     |
| -----------    | ---------  | ----------- |
| card_number    | integer    | null: false |
| valid          | integer    | null: false |
| security_code  | integer    | null: false |
| phone_number   | integer    | null: false |
| user           | references | null: false, foreign_key: true|
| item           | references | null: false, foreign_key: true|

### Association

- belongs_to :user
- has_one  :item

## addresses テーブル

| Column         | Type       | Options     |
| -----------    | ---------  | ----------- |
| postal_code    | integer    | null: false |
| prefecture     | string     | null: false |
| address_line1  | string     | null: false |
| address_line2  | string     | null: false |
| bldg_name      | string     | null: false |