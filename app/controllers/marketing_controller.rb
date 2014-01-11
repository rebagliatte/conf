class MarketingController < ApplicationController
  layout 'marketing'

  def home
    @conferences = Conference.all
  end
end
