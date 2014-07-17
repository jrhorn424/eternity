# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140717170301) do

  create_table "claim_submissions", :force => true do |t|
    t.integer  "claim_id"
    t.integer  "claimant_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "claim_submissions", ["claim_id"], :name => "index_claim_submissions_on_claim_id"
  add_index "claim_submissions", ["claimant_id"], :name => "index_claim_submissions_on_claimant_id"

  create_table "claimants", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "claims", :force => true do |t|
    t.string   "number"
    t.date     "filed_on"
    t.integer  "amount_cents"
    t.integer  "policy_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "claims", ["policy_id"], :name => "index_claims_on_policy_id"

  create_table "policies", :force => true do |t|
    t.string   "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "static_pages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
