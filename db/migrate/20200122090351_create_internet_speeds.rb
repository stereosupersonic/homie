class CreateInternetSpeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :internet_speeds do |t|
      t.integer :ping
      t.integer :upload
      t.integer :download
      t.string :ip
      t.string :isp
      t.string :country

      t.timestamps
    end
  end
end
