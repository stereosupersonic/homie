require "rails_helper"

RSpec.describe "internet_speeds/edit", type: :view do
  before(:each) do
    @internet_speed = assign(:internet_speed, InternetSpeed.create!(
                                                ping:     1,
                                                upload:   1,
                                                download: 1,
                                                ip:       "MyString",
                                                isp:      "MyString",
                                                country:  "MyString"
                                              ))
  end

  it "renders the edit internet_speed form" do
    render

    assert_select "form[action=?][method=?]", internet_speed_path(@internet_speed), "post" do
      assert_select "input[name=?]", "internet_speed[ping]"

      assert_select "input[name=?]", "internet_speed[upload]"

      assert_select "input[name=?]", "internet_speed[download]"

      assert_select "input[name=?]", "internet_speed[ip]"

      assert_select "input[name=?]", "internet_speed[isp]"

      assert_select "input[name=?]", "internet_speed[country]"
    end
  end
end
