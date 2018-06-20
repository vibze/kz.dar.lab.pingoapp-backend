class Profile < ApplicationRecord

  mount_uploader :avatar, ProfileAvatarUploader

  has_and_belongs_to_many :buddies,
                          class_name: "Profile",
                          join_table: :buddies,
                          foreign_key: :owner_profile_id,
                          association_foreign_key: :buddy_profile_id
end
