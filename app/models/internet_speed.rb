# == Schema Information
#
# Table name: internet_speeds
#
#  id         :bigint           not null, primary key
#  country    :string
#  download   :integer
#  ip         :string
#  isp        :string
#  ping       :integer
#  status     :string           default("ok")
#  upload     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InternetSpeed < ApplicationRecord
end
