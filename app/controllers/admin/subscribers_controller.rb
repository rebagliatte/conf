class Admin::SubscribersController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :subscriber, through: :conference_edition

  def index
    respond_to do |format|
      format.html
      format.csv { send_data @subscribers.to_csv }
    end
  end

end
