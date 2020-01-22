require "json"

def import_speed(line)
  raw_date = line.scan(/\[(.*)\]/).join
  begin
    date = raw_date.gsub("Dez", "Dec").to_datetime
  rescue StandardError
    puts "error date: #{raw_date}"
    return
  end

  if line.match?(/error/i) # failed executions
    InternetSpeed.create!(status: :failed, created_at: date, updated_at: date)
  else
    ping     = line.scan(/Ping\=\"(.*) ms\"/).join.to_i
    download = line.scan(/Download\=\"(.*) Mbit\/s\"\W/).join.to_f * 1_000_000
    upload   = line.scan(/Upload\=\"(.*) Mbit\/s\"\W/).join.to_f * 1_000_000

    InternetSpeed.create!(
      status:     :ok,
      created_at: date,
      updated_at: date,
      ping:       ping.to_i,
      download:   download.to_i,
      upload:     upload.to_i
    )
  end
end

namespace :internet_speed do

  desc "run the speedtest"
  task run: :environment do
    raw_result = `speedtest-cli --json`
    begin
      result = JSON.parse raw_result
    rescue StandardError => e
      InternetSpeed.create!(status: :failed)
      Rails.logger.error e
      raise e
    end
    Rails.logger.info("Internet speed: #{result}")
    InternetSpeed.create!(
      status:   :ok,
      country:  result["client"]["country"],
      isp:      result["client"]["isp"],
      ip:       result["client"]["ip"],
      ping:     result["ping"].to_i,
      download: result["download"].to_i,
      upload:   result["upload"].to_i
    )
  end

  desc "import speedtest --simple log"
  task :import, [:filename] => :environment do |_task, args|
    filename = File.expand_path args[:filename]

    File.foreach(filename) do |line|
      import_speed line
    end
  end
end
