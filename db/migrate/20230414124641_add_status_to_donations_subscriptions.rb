class AddStatusToDonationsSubscriptions < ActiveRecord::Migration[7.0]
  def change
    return if Rails.env.production?

    add_column :donations_subscriptions, :status, :tinyint, null: false, default: 0

    # Update active subscriptions
    execute <<-SQL
      UPDATE donations_subscriptions
      SET status = 1
      WHERE active = TRUE
    SQL

    # Update canceled subscriptions
    execute <<-SQL
      UPDATE donations_subscriptions
      SET status = 2
      WHERE active = FALSE
    SQL
  end
end