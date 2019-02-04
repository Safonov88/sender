FactoryBot.define do
  factory :message do
    sender_id { 1 }
    messanger { :telegram }
    body { 'Тестовое сообщение' }
    recipient { 'test_user' }
    time_of_the_sending { Time.now }
    number_max { Message::NUMBER_MAX }
  end
end
