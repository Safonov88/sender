FactoryBot.define do
  factory :message do
    sender_id 1
    messanger %i(telegram viber whatsapp)
    body 'Тестовое сообщение'
    recipient ["user #{rand(1..10)}", "user #{rand(11..20)}"]
    time_of_the_sending Time.now
  end
end
