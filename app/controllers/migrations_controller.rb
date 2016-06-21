class MigrationsController < ApplicationController
  before_action :set_migration, only: [:show, :edit, :update, :destroy]

  # GET /migrations
  # GET /migrations.json
  def index
    @migrations = Migration.all
  end

  # GET /migrations/new
  def new
    @migration = Migration.new
    @migration.build_current_site
    @migration.build_new_site
  end

  # POST /migrations
  # POST /migrations.json
  def create
    @migration = Migration.new(migration_params)
    byebug

    respond_to do |format|
      if @migration.save
        format.html { redirect_to migrations_url, notice: 'Migration was successfully created.' }
        format.json { render :show, status: :created, location: @migration }
      else
        format.html { render :new }
        format.json { render json: @migration.errors, status: :unprocessable_entity }
      end
    end
  end

  def start_crawl
    if @migration = Migration.find(params[:migration_id])
      @migration.current_site.crawl
      @migration.new_site.crawl
    end
  end

  # DELETE /migrations/1
  # DELETE /migrations/1.json
  def destroy
    @migration.destroy
    respond_to do |format|
      format.html { redirect_to migrations_url, notice: 'Migration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_migration
      @migration = Migration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def migration_params
      params.require(:migration).permit(:name, current_site_attributes: [:url], new_site_attributes: [:url])
    end
end
