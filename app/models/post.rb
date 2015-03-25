class Post < ActiveRecord::Base
  validates :title, length: { maximum: 255 }, presence: true
  enum post_type: [:link, :text]
end
