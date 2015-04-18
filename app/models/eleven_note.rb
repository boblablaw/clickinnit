class ElevenNote
  include HTTParty
  include Singleton

  API_BASE = Rails.application.secrets.elevennote_api_base
  API_KEY = Rails.application.secrets['elevennote_api_key']

  base_uri API_BASE

  # ElevenNote.find(note_id)
  def self.find(id)
    get "/notes/#{id}?api_key=#{API_KEY}"
  end

  # post = Post.first
  # ElevenNote.create_from(post)
  def self.create_from(post)
    content = post.link.presence || post.body
    post "/notes",
      body: {
        api_key: API_KEY,
        note: {
          title: post.title,
          body_html: content
        }
      }
  end
end
