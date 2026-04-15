# frozen_string_literal: true

class ActsAsFavoritorMigration < ActiveRecord::Migration[7.2]
  def self.up
    create_table :favorites, force: true do |t|
      t.references :favoritable, polymorphic: true, null: false
      t.references :favoritor, polymorphic: true, null: false
      t.string :scope, default: ActsAsFavoritor.configuration.default_scope,
                       null: false
      t.boolean :blocked, default: false, null: false
      t.timestamps
    end

    add_index :favorites, [:favoritor_id, :favoritor_type], name: 'fk_favorites'
    add_index :favorites, [:favoritable_id, :favoritable_type], name: 'fk_favoritables'
    
    # ✅ Limit string-based columns in composite indexes to prevent exceeding MySQL key length
    add_index :favorites, 
              [:favoritable_type, :favoritable_id, :favoritor_type, :favoritor_id, :scope], 
              name: 'uniq_favorites_and_favoritables', unique: true, 
              length: { favoritable_type: 191, favoritor_type: 191, scope: 100 }
  end

  def self.down
    drop_table :favorites
  end
end
