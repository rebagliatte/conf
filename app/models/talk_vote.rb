class TalkVote < ActiveRecord::Base
  attr_accessible :talk_id, :organizer_id, :vote, :comment

  belongs_to :talk
  belongs_to :organizer, class_name: 'User'

  VOTING_OPTIONS = [-1, 0, 1]

  # Validations
  validates :vote, presence: true, inclusion: { in: VOTING_OPTIONS }
  validates :talk_id, uniqueness: { scope: :organizer_id }
end
