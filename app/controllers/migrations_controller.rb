class MigrationsController < ApplicationController

  def index
    @migrations = Migration.all
  end

  def create
    @new_migration = Migration.new(migration_params)

    respond_to do |format|
      if @new_migration.save
        format.js { redirect_to new_migration_resource_path(@migration)}
      else
        format.js { render partial: 'form' }
      end
    end
  end

  private def migration_params
    params.require(:migration).permit(:name, current_site_attributes: [:url], new_site_attributes: [:url])
  end
end
