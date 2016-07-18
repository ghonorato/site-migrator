class UrlMatchController < MigrationStateController
  def index
    @resources = OldResource.where(migration: @migration)
  end
end
