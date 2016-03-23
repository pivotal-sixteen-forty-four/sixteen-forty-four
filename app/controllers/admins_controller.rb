class AdminsController < AuthenticatedController
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admins_path, notice: "Successfully saved admin: #{@admin.email}"
    else
      flash.now[:error] = "Unable to save admin"
      render :new
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    if @admin.destroy
      redirect_to admins_path, notice: "Removed #{@admin.email}."
    else
      flash.now[:error] = "Unable to remove #{@admin.email}."
      redirect_to admins_path
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email)
  end
end