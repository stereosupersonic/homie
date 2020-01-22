require "rails_helper"

RSpec.describe "internet_speeds/index", type: :view do
  before(:each) do
    assign(:internet_speeds, [
      InternetSpeed.create!(
        ping:     2,
        upload:   3,
        download: 4,
        ip:       "Ip",
        isp:      "Isp",
        country:  "Country"
      ),
      InternetSpeed.create!(
        ping:     2,
        upload:   3,
        download: 4,
        ip:       "Ip",
        isp:      "Isp",
        country:  "Country"
      )
    ])
  end

  it "renders a list of internet_speeds" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: "Ip".to_s, count: 2
    assert_select "tr>td", text: "Isp".to_s, count: 2
    assert_select "tr>td", text: "Country".to_s, count: 2
  end
end
