class RequestedAction < ActiveRecord::Base
  validates :device_id, presence:true;
  validates :requested_service, presence:true;
end
