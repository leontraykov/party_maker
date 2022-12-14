class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :cant_subscribe_to_self_event
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP },
              uniqueness: { scope: :event_id }
  end

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def cant_subscribe_to_self_event
    errors.add(:user_email, :own_event) if user == event.user
  end
end
