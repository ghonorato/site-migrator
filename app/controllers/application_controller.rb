class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :migration_action_path
  def migration_action_path(migration)
    case
    when migration.fetching_url_data?, migration.matching_redirects?
      migration_url_match_index_path(migration)
    else
      migration_resources_path(migration)
    end 
  end
end
