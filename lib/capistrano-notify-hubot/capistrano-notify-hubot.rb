namespace :notify_hubot do
  namespace :deploy do

    task :set_log_level do
      on roles(:notify_hubot) do |host|
        log_level = SSHKit.config.output_verbosity
        log_level = "info" if log_level.nil?
        set :temp_log_level, log_level
        SSHKit.config.output_verbosity = fetch(:notify_hubot_log_level)
      end
    end

    task :unset_log_level do
      on roles(:notify_hubot) do |host|
        SSHKit.config.output_verbosity = fetch(:temp_log_level)
      end
    end

    task :started => :set_log_level do
      on roles(:notify_hubot) do |host|
        set :temp_id, Digest::SHA1.hexdigest(Time.now.to_f.to_s)[8..16]
        set :title,   "Begin Deploy"
        set :message, "Application: `#{fetch(:application)}`\nHost: #{host}"
        set :color,   "0000CC"
        message_hubot
      end
    end
    after :started, :unset_log_level

    task :updated => :set_log_level do
      on roles(:notify_hubot) do |host|
        set :title,   "Code Updated, finishing up"
        set :message, "Application: `#{fetch(:application)}`\nHost: #{host}"
        set :color,   "9900CC"
        message_hubot
      end
    end
    after :updated, :unset_log_level

    task :finished => :set_log_level do
      on roles(:notify_hubot) do |host|
        set :title,   "Successful Deploy"
        set :message, "Application: `#{fetch(:application)}`\nHost: #{host}"
        set :color,   "good"
        message_hubot
      end
    end
    after :finished, :unset_log_level


  end
end
