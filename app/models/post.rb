class Post < ActiveRecord::Base
  validates :title, length: { maximum: 255 }, presence: true
  validates :body, presence: true, if: :text?
  validates :link, presence: true, if: :link?
  enum post_type: [:link, :text]
end
