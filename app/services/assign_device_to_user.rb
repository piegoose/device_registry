# app/services/assign_device_to_user.rb
class AssignDeviceToUser
  def initialize(user, serial_number, target_user = nil)
    @current_user  = user
    @target_user   = target_user || user
    @serial_number = serial_number
  end

  def call
    # 1. User cannot assign device to another user
    if @current_user != @target_user
      raise RegistrationError::Unauthorized
    end

    device = Device.find_or_create_by!(serial_number: @serial_number)

    # 2. If device is already assigned and not returned
    if DeviceAssignment.exists?(device: device, returned_at: nil)
      existing_assignment = DeviceAssignment.find_by(device: device, returned_at: nil)
      if existing_assignment.user != @target_user
        raise AssigningError::AlreadyUsedOnOtherUser
      end
    end

    # 3. If already used & returned by same user
    if DeviceAssignment.where(device: device, user: @target_user).where.not(returned_at: nil).any?
      raise AssigningError::AlreadyUsedOnUser
    end

    # 4. Otherwise create assignment
    DeviceAssignment.create!(device: device, user: @target_user)
  end
end
