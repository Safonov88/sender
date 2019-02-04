require 'rails_helper'

RSpec.describe MessageService do
  let(:params) { { sender_id: 1, body: 'Тестовое сообщение',
                   recipient: [:user1, :user2], messanger: [:viber] } }

  describe '#current_time_of_the_sending' do
    let(:stubtime) { Time.now }

    context 'when date is nill' do
      it 'checks :time_of_the_sending equivalent to current date' do
        described_class.instance_variable_set(:@prm, params)
        expect(Time).to receive(:now).and_return(stubtime)

        described_class.current_time_of_the_sending
        expect(described_class.instance_variable_get(:@prm)[:time_of_the_sending]).to eq(stubtime)
      end
    end

    context 'when date is blank' do
      it 'checks :time_of_the_sending equivalent to current date' do
        params[:time_of_the_sending] = ''
        described_class.instance_variable_set(:@prm, params)
        expect(Time).to receive(:now).and_return(stubtime)

        described_class.current_time_of_the_sending
        expect(described_class.instance_variable_get(:@prm)[:time_of_the_sending]).to eq(stubtime)
      end
    end

    context 'when date is > Time.now' do
      it 'checks :time_of_the_sending equivalent to params[:time_of_the_sending]' do
        params[:time_of_the_sending] = Time.now + 1.hour
        described_class.instance_variable_set(:@prm, params)
        described_class.current_time_of_the_sending

        expect(described_class.instance_variable_get(:@prm)[:time_of_the_sending]).to eq(params[:time_of_the_sending])
      end
    end
  end
end
