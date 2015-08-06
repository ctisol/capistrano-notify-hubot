namespace :notify_hubot do
  namespace :check do

    desc 'Ensure all notify_hubot specific settings are set, and warn and exit if not.'
    before 'deploy:started', :settings do
      {
        (File.dirname(__FILE__) + "/examples/config/deploy.rb") => 'config/deploy.rb'
      }.each do |abs, rel|
        Rake::Task['deployinator:settings'].invoke(abs, rel)
        Rake::Task['deployinator:settings'].reenable
      end
    end

    namespace :settings do
      desc 'Print example notify_hubot specific settings for comparison.'
      task :print do
        set :print_all, true
        Rake::Task['notify_hubot:check:settings'].invoke
      end
    end

  end
end
