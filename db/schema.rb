# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_616_063_545) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'vespa_id', null: false
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_comments_on_user_id'
    t.index ['vespa_id'], name: 'index_comments_on_vespa_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'comment_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['comment_id'], name: 'index_likes_on_comment_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'reservations', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'vespa_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.date 'start_date'
    t.date 'end_date'
    t.string 'description'
    t.index ['user_id'], name: 'index_reservations_on_user_id'
    t.index ['vespa_id'], name: 'index_reservations_on_vespa_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'jti', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['jti'], name: 'index_users_on_jti', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'vespas', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'icon'
    t.string 'description'
    t.float 'cost_per_day'
  end

  add_foreign_key 'comments', 'users'
  add_foreign_key 'comments', 'vespas', on_delete: :cascade
  add_foreign_key 'likes', 'comments'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'reservations', 'users', on_delete: :cascade
  add_foreign_key 'reservations', 'vespas', on_delete: :cascade
end
