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
    error "Timed out"
  rescue Errno::EHOSTUNREACH
    error "Host unreachable"
  rescue Errno::ECONNREFUSED
    error "Connection refused"
  rescue Net::SSH::AuthenticationFailed
    error "Authentication failure"
  rescue => err
    error err
  end
  case response
  when Net::HTTPSuccess then
    info "Successfully notified Hubot"
  when Net::HTTPBadGateway then
    error "Bad Gateway, (is Hubot running?)"
  when Net::HTTPNotFound then
    error "Not Found, (wrong URI?)"
  when Net::HTTPUnauthorized
    error "Authentication failure"
  else
    error "Not able to message Hubot for some reason; continuing the deployment."
  end
  debug "Response is #{response.inspect}"
end
