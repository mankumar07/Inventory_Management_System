module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin 

    def authenticate_admin
      redirect_to root_path, alert: 'Not authorized.' unless current_user.has_role?(:admin)
    end

end
