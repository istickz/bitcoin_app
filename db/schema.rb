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

ActiveRecord::Schema.define(version: 20171224152248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "block_txes", force: :cascade do |t|
    t.integer "block_id"
    t.bigint "tx_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blocks", force: :cascade do |t|
    t.binary "block_hash"
    t.integer "ver"
    t.binary "prev_block"
    t.binary "mrkl_root"
    t.integer "time"
    t.integer "bits"
    t.bigint "nonce"
    t.integer "n_tx"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tx_ins", force: :cascade do |t|
    t.bigint "tx_id"
    t.binary "prevout_hash"
    t.integer "n"
    t.binary "script_sig"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tx_outs", force: :cascade do |t|
    t.bigint "tx_id"
    t.bigint "value"
    t.binary "script_pubkey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "txes", force: :cascade do |t|
    t.binary "tx_hash"
    t.integer "ver"
    t.integer "vin_sz"
    t.integer "vout_sz"
    t.integer "lock_time"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end