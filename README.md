capistrano-notify-hubot
============

*A Capistrano plugin to notify hubot about deploys*

This is a Capistrano 3.x plugin, and relies on SSH access with passwordless sudo rights.

### Installation:
* `gem install capistrano-notify-hubot` (Or add it to your Gemfile and `bundle install`.)
* Add "require 'capistrano-notify-hubot'" to your Capfile
`echo "require 'capistrano-notify-hubot'" >> Capfile`
* Add the `notify_hubot` role to all servers about which you want to be notified.)
* Add the following settings to your `config/deploy.rb` file:
```
##### capistrano-notify-hubot
### ------------------------------------------------------------------
set :deployment_username,           ENV['USER']
before  'deploy:started',           'notify_hubot:deploy:started'
after   'deploy:updated',           'notify_hubot:deploy:updated'
after   'deploy:finished',          'notify_hubot:deploy:finished'
set :hubot_room,                    "hackery"
set :hubot_uri,                     "https://127.0.0.1:9001/hubot/message/#{fetch(:hubot_room)}"
set :hubot_username,                "my-user" # hubot basic auth
set :hubot_password,                "my-pass" # hubot basic auth
### ------------------------------------------------------------------
```
* To your Hubot instance add a listening hook like:
```
module.exports = (robot) ->
  robot.router.post '/hubot/message/:room', (req, res) ->
    # your code here to send a message to req.params.room. E.G.:
    # robot.emit "message_slack", req.params.room, req.body.pretext, req.body.title, req.body.text, req.body.color
    res.send "OK\n"
```

### Usage:
* After setting up your config files during installation, a deploy will notify before starting, after updating, and after finished.

###### Debugging:
* You can add the `--trace` option at the end of a command to see when which tasks are invoked, and when which task is actually executed.

###### TODO:
* Fix some silent failures with reaching Hubot.
