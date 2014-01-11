class AddCustomDomainToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :custom_domain, :string, default: ''
  end
end
