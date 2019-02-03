FactoryBot.define do
  factory :message do
    sender_id { 1 }
    messanger { :telegram }
    body { 'Тестовое сообщение' }
    recipient { ["user #{rand(1..10)}", "user #{rand(11..20)}"] }
    time_of_the_sending { Time.now }
    number_max { Message::NUMBER_MAX }
  end
end
