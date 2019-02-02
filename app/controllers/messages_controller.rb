class MessagesController < ApplicationController
  def index; end

  def create
    MessageService.call(message_params)
  end

  private
  def message_params
    params.require(:message).permit(:sender_id, :body, :time_of_the_sending, recipient: [], messanger: [])
  end
end
