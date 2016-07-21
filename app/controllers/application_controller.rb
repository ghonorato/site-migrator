class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :migration_action_path
  def migration_action_path(migration)
    opts = { only_path: true }.merge(migration.route)
    url_for(opts) 
  end
end
