# frozen_string_literal: true

# app/services/return_device_from_user.rb
# frozen_string_literal: true

class ReturnDeviceFromUser
  # Keep constructor tolerant; real logic will be added in "return" stage.
  def initialize(user: nil, device: nil, **_ignored)
    @user   = user
    @device = device
  end

  def call
    # Will be implemented in the next stage (return).
  end

  private

  attr_reader :user, :device
end
