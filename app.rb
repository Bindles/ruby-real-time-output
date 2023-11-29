require 'sinatra'
require 'json'
require 'tempfile'

get '/' do
  erb :index
end

post '/run' do
  code = params[:code]

  # Create a temporary file with a .rb extension
  temp_file = Tempfile.new(['temp_code', '.rb'])
  temp_file.write(code)
  temp_file.close

  # Run the Ruby script file
  output = `ruby #{temp_file.path}`

  # Remove the temporary file
  temp_file.unlink

  content_type :json
  { output: output.strip }.to_json
end
