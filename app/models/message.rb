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
#  status              :string           not null
#  number              :integer          not null
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
end
