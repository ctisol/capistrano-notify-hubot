set :notify_hubot_log_level,             "info"

def message_hubot
  uri = URI.parse fetch(:hubot_uri)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(uri.request_uri)
  request.basic_auth fetch(:hubot_username), fetch(:hubot_password)
  request.add_field "Content-Type", "application/json"
  request.set_form_data({
    "pretext" => "Deploy `#{fetch(:temp_id, "unset!")}` - by #{ENV['USER']}",
    "title"   => fetch(:title),
    "text"    => fetch(:message),
    "color"   => fetch(:color)
  })
  begin
    response = http.request(request)
  rescue Timeout::Error
    error "Message Hubot Error: Timed out"
  rescue Errno::EHOSTUNREACH
    error "Message Hubot Error: Host unreachable"
  rescue Errno::ECONNREFUSED
    error "Message Hubot Error: Connection refused"
  rescue Net::SSH::AuthenticationFailed
    error "Message Hubot Error: Authentication failure"
  rescue => err
    error err
  end
  case response
  when Net::HTTPSuccess then
    info "Successfully notified Hubot"
  when Net::HTTPBadGateway then
    error "Message Hubot Error: Bad Gateway, (is Hubot running?)"
  when Net::HTTPNotFound then
    error "Message Hubot Error: Not Found, (wrong URI?)"
  when Net::HTTPUnauthorized
    error "Message Hubot Error: Authentication failure"
  else
    error "Message Hubot Error: Not able to message Hubot for some reason; continuing the deployment."
  end
  debug "Response is #{response.inspect}"
end
