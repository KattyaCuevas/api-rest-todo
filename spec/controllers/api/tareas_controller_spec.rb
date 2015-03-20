require 'rails_helper'
describe Api::TareasController do
  describe 'GET index' do
    it 'retorna status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'retorna tareas' do
      Tarea.create(titulo: 'Pagar cuentas', descripcion: 'Ir a 3 bancos')
      get :index
      json = JSON(response.body)
      expect(json.size).to eq 1
    end
  end
end
