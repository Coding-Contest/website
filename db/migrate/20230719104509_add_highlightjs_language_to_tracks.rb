class AddHighlightjsLanguageToTracks < ActiveRecord::Migration[7.0]
  def change
    add_column :tracks, :highlightjs_language, :string, null: true

    # Skip the Git operations in non-production environments
    return unless Rails.env.production?

    Track.find_each do |track|
      track.update(highlightjs_language: track.git.highlightjs_language)
    end
  end
end