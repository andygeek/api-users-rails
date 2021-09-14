class UsersController < ApplicationController
  # En la clase ApplicationController definimos que antes de cualquier action, se ejecute el authentica
  # Aqui le nombraos una excepcion, ya que el endpoint create no necesita autenticación
  skip_before_action :authenticate!, only: :create

  # Definiendo el controlador de la ruta /, que mostrará a todos los usaurios
  def index
    users = User.all
    render json: user.as_json(json_options)
  end

  def create
    # Almacenamos el user_params usando el modelo User en una variable
    user = User.new(user_params)
    # Guardamos el user, sabiendo que en ruby todo es truly o falsy
    if user.save
      render json: user.as_json(json_options)
    else
      render json: { status: :bad, error: user.errors.message }
    end
  end

  private
  # Aqui definimos como será el parametro que recibirá nuestros actions
  def user_params
    # Aqui le decimos que el parametro requiere un user con email y password
    params.require(:user).permit(:email, :password)
  end

  # Aqui definimos nuestro json options, y le indicamos que no muestre tres campos
  def json_options
    { except: %i[created_at updated_at password_digest] }
  end
end
