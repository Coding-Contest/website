class AddCohortToCohortMemberships < ActiveRecord::Migration[7.0]
  def change
    add_reference :cohort_memberships, :cohort, null: true, foreign_key: true, if_not_exists: true

    Track.create!(
      slug: 'go',
      title: 'Go',
      blurb: 'Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.',
      repo_url: 'https://github.com/exercism/go',
      synced_to_git_sha: '26635e19868f0b4fbed09a986b824cd67efdbc2e',
      num_exercises: 0,
      num_concepts: 0,
      active: true
    ) unless Track.exists?(slug: 'go')

    track = Track.find_by(slug: 'go') || Track.first # Guard against dev db not having Golang

    Cohort.find_create_or_find_by!(slug: 'gohort') do |c|
      c.name = 'Go-Hort'
      c.capacity = 100
      c.track = track
      c.begins_at = Time.utc(2022, 07, 01)
      c.ends_at = Time.utc(2022, 07, 30)
    end

    CohortMembership.update_all(cohort_id: Cohort.find_by(slug: :gohort).id)

    change_column_null :cohort_memberships, :cohort_id, false
  end
end
