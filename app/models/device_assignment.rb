# app/models/device_assignment.rb
class DeviceAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :device

  scope :open,   -> { where(returned_at: nil) }
  scope :closed, -> { where.not(returned_at: nil) }
end
