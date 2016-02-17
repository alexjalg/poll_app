
class Api::V1::UsersController < ApplicationController
    # POST /users
    def create
        #params = {auth:{provider: 'facebook', uid:'123dgrer5645'}}
        @user = User.from_omniauth(params[:auth])
        #@token = Token.create(user: @user)
        @token = @user.tokens.create()
        render "api/v1/users/show"
    end
    #rails server -b $IP -p $PORT
end
