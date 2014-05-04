module NotificationsHelper

  def interpolable_variables_hint(notification)
    string = "Interpolable variables are:"
    if notification.recipients.blank?
      string += "<ul class=\"help-block\">"
      Notification::RECIPIENTS.each do |recipients|
        string += "<li>For #{recipients.to_s.humanize.downcase}:<ul>"
        string += interpolable_variables_list_for_recipients(recipients)
        string += "</li></ul>"
      end
    else
      string += interpolable_variables_list_for_recipients(notification.recipients.to_sym)
    end
    string.html_safe
  end

  private

  def interpolable_variables_list_for_recipients(recipients)
    string = "<ul class=\"help-block\">"
    Notification::INTERPOLABLE_VARIABLES[recipients].each do |var|
      string += "<li>{{ #{var} }}</li>"
    end
    string += "</ul>"
  end

end
