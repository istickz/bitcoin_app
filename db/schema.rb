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

ActiveRecord::Schema.define(version: 20171227211644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["block_hash"], name: "index_blocks_on_block_hash", unique: true
  end

  create_table "blocks_txes", force: :cascade do |t|
    t.integer "block_id"
    t.bigint "tx_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_blocks_txes_on_block_id"
    t.index ["tx_id"], name: "index_blocks_txes_on_tx_id"
  end

  create_table "tx_ins", force: :cascade do |t|
    t.bigint "tx_id"
    t.binary "prevout_hash"
    t.integer "n"
    t.binary "script_sig"
    t.binary "coinbase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tx_outs", force: :cascade do |t|
    t.bigint "tx_id"
    t.bigint "value"
    t.binary "script_pubkey"
    t.string "address"
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
    t.index ["tx_hash"], name: "index_txes_on_tx_hash", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.string "address"
    t.text "privkey"
    t.text "pubkey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
