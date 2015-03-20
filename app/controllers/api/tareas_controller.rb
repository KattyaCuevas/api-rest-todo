module Api
  class TareasController < ApplicationController
    def index
      render json: Tarea.all, status: :ok
    end
  end
end
