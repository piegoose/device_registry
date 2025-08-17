# frozen_string_literal: true

class ReturnDeviceFromUser
  def initialize(user:, device:)
    @user   = user
    @device = device
  end

  def call

  end

  private

  attr_reader :user, :device
end

