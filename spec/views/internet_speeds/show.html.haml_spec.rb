require "rails_helper"

RSpec.describe "internet_speeds/show", type: :view do
  before(:each) do
    @internet_speed = assign(:internet_speed, InternetSpeed.create!(
                                                ping:     2,
                                                upload:   3,
                                                download: 4,
                                                ip:       "Ip",
                                                isp:      "Isp",
                                                country:  "Country"
                                              ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Ip/)
    expect(rendered).to match(/Isp/)
    expect(rendered).to match(/Country/)
  end
end
