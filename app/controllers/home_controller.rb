class HomeController < ApplicationController
  def index
    deliver_mail 'user', 'signup', current_user
    render json: []
  end
end
