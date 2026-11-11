module Admin
  class UsersController < BaseController
    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.admin = false

      if @user.save
        redirect_to admin_path, notice: "สร้างบัญชีผู้ใช้แล้ว", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    rescue ActiveRecord::RecordNotUnique
      @user.errors.add(:email_address, :taken)
      render :new, status: :unprocessable_content
    end

    private

    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end
  end
end
