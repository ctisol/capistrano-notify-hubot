Gem::Specification.new do |s|
  s.name        = 'capistrano-notify-hubot'
  s.version     = '0.0.2'
  s.date        = '2015-08-06'
  s.summary     = "Notify Hubot during Capistrano Deployments"
  s.description = "Send Notifications to Hubot about Capistrano start, finish, etc."
  s.authors     = ["Kishore", "Dhanesh"]
  s.email       = "kishore@railsfactory.com"
  s.files       = [
    "lib/capistrano-notify-hubot.rb",
    "lib/capistrano-notify-hubot/capistrano-notify-hubot.rb",
    "lib/capistrano-notify-hubot/check.rb",
    "lib/capistrano-notify-hubot/built-in.rb",
    "lib/capistrano-notify-hubot/examples/Capfile",
    "lib/capistrano-notify-hubot/examples/config/deploy.rb"
  ]
  s.required_ruby_version  =                '>= 1.9.3'
  s.requirements           <<               "A Hubot instance"
  s.add_runtime_dependency 'capistrano',    '~> 3.2.1'
  s.add_runtime_dependency 'deployinator' 
  s.add_runtime_dependency 'rake',          '~> 10.3.2'
  s.add_runtime_dependency 'sshkit',        '~> 1.5.1'
  s.homepage    =
    'https://github.com/ctisol/capistrano-notify-hubot'
  s.license     = 'GNU'
end
