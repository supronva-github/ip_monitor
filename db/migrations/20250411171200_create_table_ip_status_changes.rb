# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:ip_status_changes) do
      primary_key :id
      foreign_key :ip_id, :ips, null: false
      column :status, :boolean, null: false
      column :created_at, :timestamp, null: false
    end
  end
end
