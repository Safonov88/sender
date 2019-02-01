class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    if [true, false].sample
      p '=' * 50
      puts "Сообщение #{message.body} отправлено #{message.recipient} через #{message.messanger}"
      p '=' * 50
      message.update(status: :delivered, number: (message.number + 1))
    else
      p '=' * 50
      puts 'Сообщение не доставлено'
      p '=' * 50
      message.update(status: :not_delivered, number: (message.number + 1))
    end
  end
end
