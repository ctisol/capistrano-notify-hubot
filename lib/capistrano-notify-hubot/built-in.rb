set :notify_hubot_log_level,             "info"

def message_hubot
  uri = URI.parse fetch(:hubot_uri)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(uri.request_uri)
  request.basic_auth fetch(:hubot_username), fetch(:hubot_password)
  request.add_field "Content-Type", "application/json"
  request.set_form_data({
    "pretext" => "Deploy `#{fetch(:temp_id, "unset")}` - by #{ENV['USER']}",
    "title"   => fetch(:title),
    "text"    => fetch(:message),
    "color"   => fetch(:color)
  })
  response = http.request(request)
  case response
  when Net::HTTPSuccess, Net::HTTPRedirection
  else
    $stdout.print "Error with response code #{response.code}!\n"
    $stdout.print "#{response.body}\n"
  end
end
