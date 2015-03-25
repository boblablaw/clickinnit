class Post < ActiveRecord::Base
  validates :title, length: { minimum: 1, maximum: 255 }

end
