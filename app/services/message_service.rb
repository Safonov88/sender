module MessageService
  extend self

  def call(prm)
    @prm = prm
    @message = ''
    current_time_of_the_sending
    separate_messages
  end

  def self.current_time_of_the_sending
    @prm[:time_of_the_sending] = Time.now if @prm[:time_of_the_sending].blank? || @prm[:time_of_the_sending].nil?
  end

  def self.separate_messages
    @prm[:messanger].each do |m|
      @prm[:recipient].each do |r|
        @message = Message.new(sender_id: @prm[:sender_id], messanger: m, body: @prm[:body],
                              recipient: r, time_of_the_sending: @prm[:time_of_the_sending].to_datetime - 3.hours, number_max: Message::NUMBER_MAX)

        create_job
      end
    end
  end

  def self.create_job
    SendMessageJob.set(wait_until: @message.time_of_the_sending).perform_later @message if @message.save
  end
end
