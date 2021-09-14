require "rails_helper"

RSpec.describe "Health enpoint", type: :request do
  before { get '/health' }

  it "should return OK" do
    payload = JSON.parse(response.body)
    expect(payload).not_to be_empty
    expect(payload['api']).to eq('OK')  
  end

  it "should return status code 200" do
    expect(response).to have_http_status(200)
  end
end