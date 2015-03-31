class UsersController < ApplicationController

  def show
    @post = User.includes(:posts).find params(:id)
  end

end
