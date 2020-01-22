require "rails_helper"

RSpec.describe InternetSpeedsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/internet_speeds").to route_to("internet_speeds#index")
    end

    it "routes to #new" do
      expect(get: "/internet_speeds/new").to route_to("internet_speeds#new")
    end

    it "routes to #show" do
      expect(get: "/internet_speeds/1").to route_to("internet_speeds#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/internet_speeds/1/edit").to route_to("internet_speeds#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/internet_speeds").to route_to("internet_speeds#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/internet_speeds/1").to route_to("internet_speeds#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/internet_speeds/1").to route_to("internet_speeds#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/internet_speeds/1").to route_to("internet_speeds#destroy", id: "1")
    end
  end
end
