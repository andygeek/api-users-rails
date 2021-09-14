class AuthController < ApplicationController
  skip_before_action :authenticate!
  
  # Este es el controlador del login, cuando hacemos login hacemos post enviando el password
  def create
    # Busco al usuario
    @user = User.find_by(email: login_params[:email])
    # El authenticate que sale del modelo user, es gracias a bcrypt
    # @user&.authenticate nos devolverá true si el passoword que le mandamos es el mismo que el password_digest, que lo almacena encriptado
    if @user&.authenticate(login_params[:password])

      # Aqui vamos a generar el token para enviarlo
      time = Time.now + 24.hours.to_i
      token = JsonWebToken.encode({user_id: @user.id}, time)
      render json: { toke: token, exp: time.strftime('%d-%m-%Y %H:%M'), email: @user.email }
    else
      render json: { error: 'unauthorized' }, status: :forbidden
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
