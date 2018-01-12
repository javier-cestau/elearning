require 'rails_helper'

RSpec.describe Admin::ReportsController, type: :controller do

  describe "GET #enroll_by_week" do
    it "returns http success" do
      get :enroll_by_week
      expect(response).to have_http_status(:success)
    end
  end

end
