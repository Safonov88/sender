require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:message) { create(:message) }
  let(:message_new) { Message.new(sender_id: 1, messanger: :telegram, body: 'Тестовое сообщение', recipient: 'test_user',
                                  time_of_the_sending: Time.now, number_max: Message::NUMBER_MAX) }

  describe '#spam' do
    context 'when message is same body and recipient' do
      it 'checks error' do
        message_new.save

        expect(message_new.errors.messages).to eq(body: ['Такое сообщение уже было отправлено этому пользователю'])
      end
    end

    context 'when message is same body and recipient, but time more on hour' do
      it 'checks does not error' do
        Message.find(message.id).update(created_at: (Time.now + 1.hour))
        message_new.save

        expect(message_new.errors.messages).to be_empty
      end
    end
  end
end
