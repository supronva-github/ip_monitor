# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :ips do
      primary_key :id
      column :ip_address, :inet, null: false
      Boolean :enabled, default: false
      DateTime :created_at
      DateTime :updated_at
    end

    add_index :ips, :ip_address, unique: true
  end
end
