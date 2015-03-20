module Api
  # Clase TareasController
  class TareasController < ApplicationController
    http_basic_authenticate_with :name => "kattya", :password => "12345"
    skip_before_filter :authenticate_user!
    skip_before_filter :verify_authenticity_token, only: :create
    def index
      render json: Tarea.all, status: :ok
    end

    def show
      tarea = Tarea.find(params[:id])
      render json: tarea, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: 'No existe', status: :not_found
    end

    def create
      tarea = Tarea.new(tarea_params)
      if tarea.save
        render json: tarea, status: :created
      else
        render json: tarea.errors, status: :unprocessable_entity
      end
    end

    private

    def tarea_params
      params.permit(:titulo, :descripcion)
    end
  end
end
