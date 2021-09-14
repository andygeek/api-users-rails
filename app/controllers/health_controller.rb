class HealthController < ApplicationController
  skip_before_action :authenticate!, only: :health

  def health
    render json: {api: 'OK'}, status: :ok
  end
end