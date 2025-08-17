# frozen_string_literal: true

class AssignDeviceToUser
  def initialize(user:, device:)
    @user = user
    @device = device
  end

  def call
    # 1. User attempts to assign another user's device → error
    if @device.user_id.present? && @device.user_id != @user.id
      raise AssigningError::AlreadyUsedOnOtherUser
    end

    # 2. If it is the same user, but they have already returned the device → error
    if DeviceAssignment.exists?(user_id: @user.id, device_id: @device.id, returned: true)
      raise AssigningError::AlreadyReturnedByThisUser
    end

    # 3. Assign the device to the user
    DeviceAssignment.create!(user: @user, device: @device, returned: false)
  end
end
