class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    if [true, false].sample
      puts "Сообщение #{message.body} отправлено #{message.recipient} через #{message.messanger}"
      message.update(status: :delivered)
    else
      puts 'Сообщение не доставлено'
      message.update(status: :not_delivered)
    end
  end
end
