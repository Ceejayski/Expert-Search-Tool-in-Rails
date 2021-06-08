class Member < ApplicationRecord
  validates :website, url: true
  validates_presence_of :name, :website
  validates_uniqueness_of :name

  has_one :shortner, dependent: :destroy
  has_many :friendships, foreign_key: 'person_id', class_name: 'Friendship', dependent: :delete_all
  has_many :friends, foreign_key: 'friend_id', class_name: 'Friendship', dependent: :delete_all
  scope :not_friends, ->(member) { where.not(id: (member.friends.map(&:person_id) + [member.id])) }
  scope :friends, ->(member) { where(id: member.friends.map(&:person_id)) }

  def friends?(member)
    pre_vote = friends.find { |friend| friend.person_id == member.person_id }
    !pre_vote.nil?
  end

  def mutuals(member)
    a_friends = friends
    b_friends = member.friends
    a_friends.select do |friend|
      b_friends.find_by(person_id: friend.person_id)
    end
  end
end
