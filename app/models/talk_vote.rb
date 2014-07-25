class TalkVote < ActiveRecord::Base
  attr_accessible :talk_id, :organizer_id, :vote, :comment, :conference_edition_id

  belongs_to :talk
  belongs_to :organizer, class_name: 'User'

  VOTING_OPTIONS = [-1, 0, 1]

  # Validations
  validates :vote, presence: true, inclusion: { in: VOTING_OPTIONS }
  validates :talk_id, uniqueness: { scope: :organizer_id }

  # Callbacks
  after_save :update_talk_ranking

  def update_talk_ranking
    talk = Talk.find(talk_id)
    talk.update_columns(ranking: talk.talk_votes.sum(:vote))
  end

  # Scopes
  scope :stored, { where('id IS NOT NULL') }

end
