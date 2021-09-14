class JsonWebToken
  # Este es el secreto de entrada para generar un token, es decir un valor randon para generar otro valor
  # el to_s sirve para convertir a string
  SECRET_KEY = Rails.application.secret.key_base.to_s

  # El self funciona como un constructor
  def self.encode(payload, exp = 24.hours.from_now)
    # Al payload le damos un exp convertida a entero por to_i
    payload[:exp] = exp.to_i
    # Usamos JWT para codificar el payload usando el SECRET_KEY
    JWT.encode(payload, SECRET_KEY)
  end

  # Método para decodificar un token
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY).first
    
    # Usando esto nos permite acceder al arreglo usando objeto[:dato] o objeto['dato']
    HashWithIndifferentAccess.new decoded
  end
end