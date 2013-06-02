class Admin::ConferencesController < ApplicationController
  layout 'admin'

  def index
    @conferences = Conference.all
  end

  def show
    @conference = Conference.find(params[:id])
  end
end
