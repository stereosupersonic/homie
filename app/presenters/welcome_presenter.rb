class WelcomePresenter < ApplicationPresenter
  def last_updated
    "#{h.time_ago_in_words o.created_at} (#{h.format_datetime o.created_at})"
  end

  def last_speed
    "down: #{h.number_to_human_size o.download} up: #{h.number_to_human_size o.upload} ping: #{o.ping} ms"
  end

  def download_better_as_average?
    o.download.to_i > average_download
  end

  def average_download
    InternetSpeed.average(:download).to_i
  end

  def average_download_formatted
    h.number_to_human_size average_download
  end

  def average_upload_formatted
    h.number_to_human_size InternetSpeed.average(:upload).to_i
  end

  def last_error_entry
    @last_error_entry ||= InternetSpeed.where("status != 'ok'").last
  end

  def last_error
    "#{h.time_ago_in_words last_error_entry.created_at} (#{h.format_datetime last_error_entry.created_at})"
  end

  def internet_connection?
    require "socket"
    begin
      TCPSocket.new "google.com", 80
      true
    rescue SocketError
      false
    end
  end
end
