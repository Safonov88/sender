class MessagesController < ApplicationController
  def index; end

  def create

  end

  private
  def message_params
    params.require(:message).permit(:sender_id, :messanger, :body, :recipient, :time_of_the_sending)
  end
end
