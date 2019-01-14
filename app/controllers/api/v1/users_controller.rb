module Api::V1
    class UsersController < ApplicationController
          before_action :authenticate_user, only: [:index, :show]

        def create
            user = User.new(user_params)
            if user.save
            render json: {status: 200, user: user}
            else
            render json: {status: 400, errors: user.errors.messages}
            end
        end

        def show
        end


        private

        def user_params
            params.require(:user).permit(:name, :email, :password)
        end
    end
end
