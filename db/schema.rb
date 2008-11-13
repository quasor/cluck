# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081028060014) do

  create_table "clusters", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.integer  "release_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clusters", ["state_id"], :name => "index_clusters_on_state_id"
  add_index "clusters", ["release_id", "state_id"], :name => "index_clusters_on_release_id_and_state_id"

  create_table "default_team_assignments", :force => true do |t|
    t.integer  "team_id"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "action"
    t.integer  "release_id"
    t.integer  "team_assignment_id"
    t.integer  "cluster_id"
    t.boolean  "signed_off"
    t.integer  "state_id"
    t.string   "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.text     "body"
    t.string   "created_by"
    t.string   "notable_type"
    t.integer  "notable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "releases", :force => true do |t|
    t.string   "name"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.integer  "sequence_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "team_assignment_versions", :force => true do |t|
    t.integer  "team_assignment_id"
    t.integer  "version"
    t.integer  "cluster_id"
    t.integer  "team_id"
    t.integer  "state_id"
    t.boolean  "signed_off",         :default => false
    t.datetime "updated_at"
    t.string   "updated_by"
    t.integer  "release_id"
  end

  create_table "team_assignments", :force => true do |t|
    t.integer  "cluster_id"
    t.integer  "team_id"
    t.integer  "state_id"
    t.boolean  "signed_off", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "updated_by"
    t.integer  "release_id"
    t.integer  "version"
  end

  add_index "team_assignments", ["cluster_id", "team_id", "state_id"], :name => "index_team_assignments_on_cluster_id_and_team_id_and_state_id"
  add_index "team_assignments", ["cluster_id", "state_id"], :name => "index_team_assignments_on_cluster_id_and_state_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
