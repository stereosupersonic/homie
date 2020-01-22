require "rails_helper"

RSpec.describe "InternetSpeeds", type: :request do
  describe "GET /internet_speeds" do
    it "works! (now write some real specs)" do
      get internet_speeds_path
      expect(response).to have_http_status(200)
    end
  end
end
