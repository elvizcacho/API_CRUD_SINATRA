require 'sinatra' 
require 'sinatra/activerecord'

db = URI.parse('postgres://warlock:copito@localhost/pidefarma')


ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Note < ActiveRecord::Base
end

get "/notes" do
	content_type :json
  	@notes = Note.order("created_at DESC")
  	@notes.to_json
end

post "/notes" do
	content_type :json
	if params[:title] && params[:body]
		@note = Note.new(params)
		@note.save
		{response: "register #{@note.id} has been created."}.to_json
	else
 		{response: "Some parameters are missing."}.to_json
 	end
end

get "/notes/:id" do
	content_type :json
	@note = Note.find(params[:id])
	@note.to_json
end

put "/notes" do
	content_type :json
	@note = Note.find(params[:id])
	@note.title = params[:title] ? params[:title] : @note.title
	@note.body = params[:body] ? params[:body] : @note.body
	@note.save
	{response: "register #{params[:id]} has been updated."}.to_json
end

delete "/notes" do
	content_type :json
	Note.find(params[:id]).destroy
	{response: "register #{params[:id]} has been deleted."}.to_json
end

