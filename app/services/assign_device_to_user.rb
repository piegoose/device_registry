# frozen_string_literal: true

class AssignDeviceToUser
  # Specs call from user:, serial_number:, and sometimes target_user:
  # - user:        who performs the operation
  # - target_user: who we assign it to (must be the same as user)
  # - serial_number: device identifier
  def initialize(user:, serial_number:, target_user: nil)
    @current_user  = user
    @target_user   = target_user || user
    @serial_number = serial_number
  end

  def call
    # 1) The user can only assign the device to themselves.
    raise RegistrationError::Unauthorized if current_user.id != target_user.id

    device = Device.find_or_create_by!(serial_number: serial_number)

    # 2) If the device is currently with another user → lock
    open_assignment = DeviceAssignment.open.find_by(device: device)
    if open_assignment && open_assignment.user_id != current_user.id
      raise AssigningError::AlreadyUsedOnOtherUser
    end

    # 3) If this user has ever returned the same device → permanent ban on re-assignment
    if DeviceAssignment.closed.exists?(user: current_user, device: device)
      raise AssigningError::AlreadyReturnedByThisUser
    end

    # 4) We create a new open assignment (history in DeviceAssignment)
    DeviceAssignment.create!(
      user: current_user,
      device: device,
      assigned_at: Time.current
    )

    device
  end

  private

  attr_reader :current_user, :target_user, :serial_number
end

