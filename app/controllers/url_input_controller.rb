class UrlInputController < MigrationStateController

  def index
    @resources_creation_form = ResourcesCreationForm.new
  end

  def create
    @resources_creation_form = ResourcesCreationForm.new(@migration, params[:resources_creation_form])
    respond_to do |format|
      if @resources_creation_form.save
        @migration.fetching_url_data!
        PageFetcherJob.perform_async(@migration.id)

        format.html { redirect_to migration_action_path(@migration) }
      else
        format.html { render :index }
      end
    end
  end
end
