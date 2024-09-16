class RemoveOldUserData < ActiveRecord::Migration[7.0]
  def change
    return if Rails.env.production?

    columns_to_remove = [
      :bio, :roles, :insiders_status, :stripe_customer_id, :discord_uid,
      :accepted_privacy_policy_at, :accepted_terms_at, :became_mentor_at,
      :joined_research_at, :first_donated_at, :last_visited_on,
      :num_solutions_mentored, :mentor_satisfaction_percentage,
      :total_donated_in_cents, :active_donation_subscription,
      :show_on_supporters_page, :github_username, :paypal_payer_id, :usages
    ]

    columns_to_remove.each do |column|
      remove_column :users, column if column_exists?(:users, column)
    end
  end
end