require "rails_helper"

RSpec.describe "internet_speeds/new", type: :view do
  before(:each) do
    assign(:internet_speed, InternetSpeed.new(
                              ping:     1,
                              upload:   1,
                              download: 1,
                              ip:       "MyString",
                              isp:      "MyString",
                              country:  "MyString"
                            ))
  end

  it "renders new internet_speed form" do
    render

    assert_select "form[action=?][method=?]", internet_speeds_path, "post" do
      assert_select "input[name=?]", "internet_speed[ping]"

      assert_select "input[name=?]", "internet_speed[upload]"

      assert_select "input[name=?]", "internet_speed[download]"

      assert_select "input[name=?]", "internet_speed[ip]"

      assert_select "input[name=?]", "internet_speed[isp]"

      assert_select "input[name=?]", "internet_speed[country]"
    end
  end
end
