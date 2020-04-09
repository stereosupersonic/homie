# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @last = WelcomePresenter.new InternetSpeed.last
    @down = InternetSpeed.group("date_trunc('day',created_at)")
      .average(:download).map { |date, speed| [date.to_date, speed.to_i] }.sort_by(&:first)
    @up = InternetSpeed.group("date_trunc('day',created_at)")
      .average(:upload).map { |date, speed| [date.to_date, speed.to_i] }.sort_by(&:first)
    @ping = InternetSpeed.group("date_trunc('day',created_at)")
      .average(:ping).map { |date, speed| [date.to_date, speed.to_i] }.sort_by(&:first)
  end
end
