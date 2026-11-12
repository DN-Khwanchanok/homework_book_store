module Admin
  class UsersController < BaseController
    def new
      @user = User.new
    end

    def create
      attributes = user_params
      role = attributes.delete(:role) || "user"
      @user = User.new(attributes)

      unless %w[user admin].include?(role)
        @user.errors.add(:base, "กรุณาเลือก Role เป็น User หรือ Admin")
        return render :new, status: :unprocessable_content
      end

      @user.admin = role == "admin"

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
      params.require(:user).permit(:email_address, :password, :password_confirmation, :role)
    end
  end
end
