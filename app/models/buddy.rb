class Buddy < ApplicationRecord

  belongs_to :buddy_profile, class_name: "Profile", foreign_key: "buddy_profile_id"
end
