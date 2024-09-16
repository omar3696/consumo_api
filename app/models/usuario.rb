class Usuario
    include ActiveModel::Model
  
    attr_accessor :id, :nombre, :email, :created_at, :updated_at

    BASE_URL = "http://127.0.0.1:3000/usuarios"

    def self.all
        response = RestClient.get(BASE_URL)
        JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
        raise "Error al obtener usuarios: #{e.response}"
    end

    def self.find(id)
        response = RestClient.get("#{BASE_URL}/#{id}")in
        JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
        raise "Error al obtener usuario: #{e.response}"
    end

    def self.create(params)
        response = RestClient.post(BASE_URL, params.to_json, {content_type: :json, accept: :json})
        response.code == 201
        JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
        raise "Error al crear usuario: #{e.response}"
    end

    def update(params)
        response = RestClient.patch("#{BASE_URL}/#{id}", params.to_json, {content_type: :json, accept: :json})
        if response.code == 200
            attributes = JSON.parse(response.body)
            self.attributes = attributes
            true
          else
            false
        end
    rescue RestClient::ExceptionWithResponse => e
        raise "Error al actualizar usuario: #{e.response}"
    end
    
    def self.destroy(id)
        response = RestClient.delete("#{BASE_URL}/#{id}")
        response.code == 204
    rescue RestClient::ExceptionWithResponse => e
        raise "Error al eliminar usuario: #{e.response}"
    end

    # Método para establecer los atributos del modelo
    def attributes=(attrs)
        attrs.each do |key, value|
        send("#{key}=", value)
        end
    end

end
