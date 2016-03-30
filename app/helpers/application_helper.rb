module ApplicationHelper
    def user_signed_in?
        #Devolverá verdadero si hay un usuario logueado y falso si no hay usuario logueado
        !current_user.nil? #Devuelve verdadero si el objeto es nulo caso contrario devuelve falso
    end
    def current_user
        #Devolver nil si ningun usuario esta logueado o devolver el usuario que esta logueado
        User.find(session[:user_id])
    end
end
