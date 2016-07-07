class ResourcesController < MigrationStateController

  def index
  end

  def create
    @resources_creation_form = ResourcesCreationForm.new(params[:resources_creation_form], @migration.current_site, @migration.new_site)
    respond_to do |format|
      if @resources_creation_form.save
        @migration.fetching_url_data!

        format.html { redirect_to migration_action_path(@migration) }
      else
        format.html { render :index }
      end
    end
  end
end
