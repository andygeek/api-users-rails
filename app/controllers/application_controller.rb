class ApplicationController < ActionController::API
  
  # ApplicationController, es la clase de la que eredan los demas controladores, por lo que
  # si definimos aqui el authenticate, este será usado en cuenquier otro controlador.
  before_action :authenticate!

  private

  def authenticate!
    # Obtengo el header Authorization
    header = request.headers['Authorization']
    # El texto que obtengo lo divido en dos y solo me importa lo segundo, despues de Bearer
    header = header.split(' ').last if header

    # Uso un manejador de exepciones
    begin
      # Creo una variable, y decodifico mediante JWT el token
      @decoded = JsonWebToken.decode(header)
      # Dentro del token está el user id, asi que lo uso para buscar al usuario
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      # En caso de que no se encuentre tomo la excepcion y muestro el error en pantalla
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      # JWT tambien define excepciones en caso de que el token al decodificar lance error
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
