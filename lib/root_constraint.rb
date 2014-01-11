class RootConstraint
  def matches?(request)
    CONFIG[:confnu_server_names].split(' ').include?(request.domain) && request.subdomain.empty?
  end
end
