class MessagesController < ApplicationController
  def index; end

  def create
    prm = message_params

    prm[:time_of_the_sending] = Time.now if prm[:time_of_the_sending].blank? || (prm[:time_of_the_sending] < Time.current)

    prm[:messanger].each do |m|
      prm[:recipient].each do |r|
        message = Message.new(sender_id: prm[:sender_id], messanger: m, body: prm[:body],
                              recipient: r, time_of_the_sending: prm[:time_of_the_sending].to_datetime - 3.hours, number_max: Message::NUMBER_MAX)

        SendMessageJob.set(wait_until: message.time_of_the_sending).perform_later message if message.save
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:sender_id, :body, :time_of_the_sending, recipient: [], messanger: [])
  end
end
