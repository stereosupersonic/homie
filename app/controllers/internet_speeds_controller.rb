class InternetSpeedsController < ApplicationController
  def index
    @internet_speeds = InternetSpeed.order("ID DESC").paginate(page: params[:page], per_page: 50)
    @best_down = InternetSpeed.where(status: :ok).order("download DESC").first
    @worst_down = InternetSpeed.where(status: :ok).order("download ASC").first
  end
end
