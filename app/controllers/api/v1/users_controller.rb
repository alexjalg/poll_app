
class Api::V1::UsersController < Api::V1::MasterApiController
  
    # POST /users
    def create
        #params = {auth:{provider: 'facebook', uid:'123dgrer5645'}}
        if !params[:auth]
          render json: { error: "Auth param is missing" }
        else
          @user = User.from_omniauth(params[:auth])
          #@token = Token.create(user: @user)
          @token = @user.tokens.create()
          render "api/v1/users/show"
        end
    end
    #arancar el proyecto
    #rails server -b $IP -p $PORT
    
    #corregir error al arancar el proyecto, error-> nos piden que hagamos migracion, la jacemos , pero no existe ninguna migracion peidente..es un bug, se debe volver a crear al bd, lo malomque pedemos la info
    #rm -f db/*.sqlite3
    #rake db:create
    #RAILS_ENV=development rake db:migrate
    #rails s -e development
    
    #Poblar la base de datos de desarrolllo  seed
    #rake db:seed
      
end
