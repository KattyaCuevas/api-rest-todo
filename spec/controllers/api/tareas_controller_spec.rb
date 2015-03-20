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
  describe 'GET show' do
    before do
      @tarea = Tarea.create(titulo: 'Pagar cuentas', descripcion: 'Ir a 3 bancos')
    end
    it 'retorna status ok' do
      get :show, id: @tarea.id
      expect(response).to have_http_status(:ok)
    end
    it 'retorna la tarea indicada' do
      get :show, id: @tarea.id
      json = JSON(response.body)
      expect(json['titulo']).to eq @tarea.titulo
    end
    it 'retorna status 404 si no existe la tarea' do
      get :show, id: 'XXX'
      expect(response).to have_http_status(:not_found)
    end
  end
  describe 'POST create' do
    it 'retorna status created' do
      post :create, titulo: 'Pagar cuentas', descripcion: 'Ir a 3 bancos'
      expect(response).to have_http_status(:created)
    end
    it 'retorna status unprocessable_entity si no se puede crear la tarea' do
      post :create
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'retorna la tarea creada' do
      post :create, titulo: 'Pagar cuentas', descripcion: 'Ir a 3 bancos'
      json = JSON.parse(response.body)
      expect(json['titulo']).to eq 'Pagar cuentas'
      expect(json['descripcion']).to eq 'Ir a 3 bancos'
    end
  end
end
