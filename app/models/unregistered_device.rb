class UnregisteredDevice < ActiveRecord::Base
    validates :device_id, uniqueness: {scope:  :device_id}
end
