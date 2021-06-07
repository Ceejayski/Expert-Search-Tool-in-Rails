class Friendship < ApplicationRecord
  belongs_to :person, foreign_key: 'person_id', class_name: 'Member'
  belongs_to :friend, foreign_key: 'friend_id', class_name: 'Member'
end
