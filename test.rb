require 'minitest/autorun'
require 'rack/test'
require_relative 'app.rb'

include Rack::Test::Methods

def app
	Sinatra::Application
end

describe "Create new note" do
	it "everything set up" do
		post '/notes'
		last_response.headers['Content-Type'].must_equal 'application/json'
	end

end