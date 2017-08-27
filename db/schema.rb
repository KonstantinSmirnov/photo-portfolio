# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_170_827_120_747) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'abouts', force: :cascade do |t|
    t.string   'title'
    t.text     'text'
    t.string   'portrait_file_name'
    t.string   'portrait_content_type'
    t.integer  'portrait_file_size'
    t.datetime 'portrait_updated_at'
    t.string   'signature_file_name'
    t.string   'signature_content_type'
    t.integer  'signature_file_size'
    t.datetime 'signature_updated_at'
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
  end

  create_table 'articles', force: :cascade do |t|
    t.string   'title'
    t.text     'content'
    t.integer  'blog_id'
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
    t.integer  'status', default: 0
    t.index ['blog_id'], name: 'index_articles_on_blog_id', using: :btree
  end

  create_table 'blogs', force: :cascade do |t|
    t.string   'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'categories', force: :cascade do |t|
    t.string   'title'
    t.integer  'portfolio_id'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
    t.integer  'position'
  end

  create_table 'contacts', force: :cascade do |t|
    t.text     'text'
    t.string   'image_file_name'
    t.string   'image_content_type'
    t.integer  'image_file_size'
    t.datetime 'image_updated_at'
    t.datetime 'created_at',         null: false
    t.datetime 'updated_at',         null: false
  end

  create_table 'hero_carousel_slides', force: :cascade do |t|
    t.string   'title'
    t.string   'subtitle'
    t.datetime 'created_at',         null: false
    t.datetime 'updated_at',         null: false
    t.string   'image_file_name'
    t.string   'image_content_type'
    t.integer  'image_file_size'
    t.datetime 'image_updated_at'
    t.integer  'position'
  end

  create_table 'instagrams', force: :cascade do |t|
    t.text     'text'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
    t.string   'access_token'
    t.string   'username'
    t.string   'profile_picture'
  end

  create_table 'opinions', force: :cascade do |t|
    t.text     'text'
    t.string   'author'
    t.string   'image_file_name'
    t.string   'image_content_type'
    t.integer  'image_file_size'
    t.datetime 'image_updated_at'
    t.datetime 'created_at',         null: false
    t.datetime 'updated_at',         null: false
    t.integer  'position'
  end

  create_table 'photos', force: :cascade do |t|
    t.string   'alt'
    t.string   'image_file_name'
    t.string   'image_content_type'
    t.integer  'image_file_size'
    t.datetime 'image_updated_at'
    t.integer  'project_id'
    t.datetime 'created_at',         null: false
    t.datetime 'updated_at',         null: false
    t.integer  'position'
  end

  create_table 'portfolios', force: :cascade do |t|
    t.string   'title'
    t.string   'home_title'
    t.text     'description'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  create_table 'projects', force: :cascade do |t|
    t.string   'title'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
    t.integer  'portfolio_id'
    t.integer  'category_id'
    t.date     'date'
  end

  create_table 'settings', force: :cascade do |t|
    t.string   'webpage_title'
    t.text     'seo_description'
    t.text     'seo_keywords'
    t.text     'seo_text'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
    t.string   'contact_phone'
    t.string   'contact_email'
    t.string   'facebook'
    t.text     'analytics'
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email', null: false
    t.string   'crypted_password'
    t.string   'salt'
    t.datetime 'created_at',       null: false
    t.datetime 'updated_at',       null: false
    t.index ['email'], name: 'index_users_on_email', unique: true, using: :btree
  end

  add_foreign_key 'articles', 'blogs'
end
