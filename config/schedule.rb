set :environment, 'development'
set :output, "#{path}/log/wenever.log"

every 1.minute do
  runner 'Message.send_now'
end
