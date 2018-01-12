require 'rails_helper'

RSpec.describe SystemController, type: :controller do

  describe "GET #system" do
    it "returns http success" do
      get :system
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #backup" do
    it "returns http success" do
      get :backup
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #restore" do
    it "returns http success" do
      get :restore
      expect(response).to have_http_status(:success)
    end
  end

end
