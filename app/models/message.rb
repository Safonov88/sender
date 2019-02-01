# == Schema Information
#
# Table name: messages
#
#  id                  :integer          not null, primary key
#  sender_id           :integer          not null
#  messanger           :string           not null
#  body                :text             not null
#  recipient           :string           not null
#  time_of_the_sending :datetime         not null
#  status              :string           default("in_process"), not null
#  number              :integer          default(0), not null
#  number_max          :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Message < ApplicationRecord
  MESSANGERS = %w(telegram viber whatsapp).freeze
  NUMBER_MAX = 5
  STATUS = %w(not_delivered in_process delivered).freeze

  validates :sender_id, :messanger, :body, :recipient, :time_of_the_sending,
            :status, :number, :number_max, presence: true
  validates :messanger, inclusion: { in: MESSANGERS }
  validates :status, inclusion: { in: STATUS }
  validate :spam

  scope :not_delivered, -> { where(status: :not_delivered) }
  scope :sending_limit, -> { where('number < number_max') }

  def self.send_now
    Message.not_delivered.sending_limit.map { |m| SendMessageJob.perform_later m }
  end

  private
  def spam
    if Message.find_by(messanger: messanger, body: body, recipient: recipient, created_at: 1.hour.ago..Time.now).present?
      errors.add(:body, 'Такое сообщение уже было отправлено этому пользователю')
    end
  end
end
