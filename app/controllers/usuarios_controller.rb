class UsuariosController < ApplicationController
    def index
        @usuarios = Usuario.all
    end
  
    def show
        @usuario = Usuario.find(params[:id])
    end
  
    def new
        @usuario = Usuario.new
    end
  
    def create
        @usuario = Usuario.create(usuario_params)
        if @usuario.persisted?
        redirect_to usuarios_path, notice: 'Usuario creado exitosamente.'
        else
        render :new
        end
    end
  
    def edit
        @usuario = Usuario.find(params[:id])
    end
  
    def update
        @usuario = Usuario.find(params[:id])
        if @usuario.update(usuario_params)
        redirect_to usuario_path(@usuario.id), notice: 'Usuario actualizado exitosamente.'
        else
        render :edit
        end
    end
  
    def destroy
        if Usuario.destroy(params[:id])
            flash[:success] = "Usuario eliminado con éxito"
        else
            flash[:error] = "Error al eliminar usuario"
        end
        redirect_to usuarios_path
    end
  
    private
  
    def usuario_params
        params.require(:usuario).permit(:nombre, :email, :edad)
    end
end
  