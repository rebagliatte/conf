class AdminController < ApplicationController
  layout 'admin'

  def conferences
    Conference.accessible_by(current_ability)
  end

  helper_method :conferences

end
