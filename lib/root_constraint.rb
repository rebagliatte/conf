class RootConstraint
  def matches?(request)
    Rails.application.secrets.confnu_server_names].split(' ').include?(request.domain) && request.subdomain.empty?
  end
end
