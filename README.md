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
| birth_date         | date    | null: false              |

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
| prefecture_id    | integer    | null: false |
| shipment_day_id  | integer    | null: false |
| price            | integer    | null: false |
| user             | references | null: false, foreign_key: true|

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
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one  :address

## addresses テーブル

| Column         | Type       | Options                        |
| -----------    | ---------  | -----------                    |
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| address_line1  | string     | null: false                    |
| address_line2  | string     | null: false                    |
| bldg_name      | string     |
| phone_number   | string     | null: false |
| purchase       | references | null: false, foreign_key: true |

### Association

- belongs_to  :purchase