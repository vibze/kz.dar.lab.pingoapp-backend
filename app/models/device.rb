class Device < ApplicationRecord
  belongs_to :profile, inverse_of: :device
end
