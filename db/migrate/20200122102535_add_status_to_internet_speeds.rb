class AddStatusToInternetSpeeds < ActiveRecord::Migration[6.0]
  def change
    add_column :internet_speeds, :status, :string, default: :ok
  end
end
