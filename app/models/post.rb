class Post < ActiveRecord::Base
  validates :title, length: { maximum: 255 }, presence: true
  validates :body, presence: true, if: :text?
  validates :link, presence: true, if: :link?
  validates :category_id, presence: true
  enum post_type: [:link, :text]
  belongs_to :category
  belongs_to :user
  default_scope { order('updated_at DESC').includes(:category).includes(:user) }

  # gem configurations
  self.per_page = 6
  acts_as_commentable
  acts_as_votable
end
