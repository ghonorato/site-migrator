class MigrationStateController < ApplicationController
  
  before_action :set_migration, :redirect_to_state_controller

  private 

  def set_migration
    @migration = Migration.find(params[:migration_id])
  end

  def redirect_to_state_controller
    redirect_to migration_action_path(@migration) unless correct_action?
  end

  def correct_action?
    migration_action_path(@migration) == request.fullpath
  end
end
