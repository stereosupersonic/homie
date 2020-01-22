# frozen_string_literal: true

module ApplicationHelper
  def format_time(time)
    time&.strftime "%H:%M"
  end

  def format_date(date)
    date&.strftime "%d.%m.%Y"
  end

  def format_datetime(date)
    date&.strftime "%d.%m.%Y %H:%M"
  end
end
