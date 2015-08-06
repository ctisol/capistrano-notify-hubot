# config valid only for Capistrano 3.2.1
lock '3.2.1'

##### capistrano-notify-hubot
### ------------------------------------------------------------------
set :deployment_username,           ENV['USER']
before  'deploy:starting',          'notify_hubot:deploy:starting'
after   'deploy:updated',           'notify_hubot:deploy:updated'
after   'deploy:finished',          'notify_hubot:deploy:finished'
set :hubot_room,                    "hackery"
set :hubot_uri,                     "https://127.0.0.1:9001/hubot/message/#{fetch(:hubot_room)}"
set :hubot_username,                "my-user" # hubot basic auth
set :hubot_password,                "my-pass" # hubot basic auth
### ------------------------------------------------------------------
