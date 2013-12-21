class Admin::SubscribersController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :subscriber, through: :conference_edition

  def index
  end

end
