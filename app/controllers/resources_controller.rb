class ResourcesController < ApplicationController

  before_action :set_migration

  def index

  end

  def create
    @resources_creation_form = ResourcesCreationForm.new(params[:resources_creation_form], @migration.current_site, @migration.new_site)
    respond_to do |format|
      if @resources_creation_form.save
        format.html { redirect_to root_path }
      else
        format.html { render :index }
      end
    end
  end

  private 

  def set_migration
    @migration = Migration.find(params[:migration_id])
  end
end
