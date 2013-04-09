class App < Sinatra::Base
  helpers do
    def is_user?
      !@user.nil?
    end

    def logout_path
      "/logout/#{session[:csrf_token]}"
    end
  end
end