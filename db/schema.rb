# frozen_string_literal: true

ActiveRecord::Schema[7.1].define(version: 20_240_629_104_453) do
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.decimal 'price'
    t.bigint 'category_id', null: false
    t.text 'features'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_products_on_category_id'
  end

  add_foreign_key 'products', 'categories'
end
