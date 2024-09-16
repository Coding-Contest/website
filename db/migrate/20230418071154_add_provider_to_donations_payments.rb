class AddProviderToDonationsPayments < ActiveRecord::Migration[7.0]
  def change
    return if Rails.env.production?

    add_column :donations_payments, :provider, :tinyint, null: false, default: 0

    # Replace the model update with raw SQL
    execute("UPDATE donations_payments SET provider = 0")

    remove_index :donations_payments, :stripe_id
    add_index :donations_payments, [:stripe_id, :provider], unique: true, if_not_exists: true
  end
end