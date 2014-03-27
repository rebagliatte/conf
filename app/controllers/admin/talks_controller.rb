class Admin::TalksController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :talk, through: :conference_edition

  def index
    @talks = @talks.order('ranking DESC, created_at DESC').group_by { |s| s.status }
  end

  def show
    @speaker = @talk.speakers.first
    @talk_vote = existing_talk_vote || @talk.talk_votes.new()
  end

  def new
    @conference_edition.languages.map(&:code).each do |locale|
      @talk.translations.build locale: locale
    end
  end

  def create
    if @talk.save
      redirect_to admin_conference_edition_talk_path(@conference_edition, @talk), flash: { success: 'Talk created successfully!' }
    else
      render :new
    end
  end

  def edit
    missing_translations = @conference_edition.languages.pluck(:code) - @talk.translations.pluck(:locale)
    missing_translations.each do |locale|
      @talk.translations.build locale: locale
    end
  end

  def update
    if @talk.update_attributes(params[:talk])
      redirect_to admin_conference_edition_talk_path(@conference_edition, @talk), flash: { success: 'Talk updated successfully!' }
    else
      render :edit
    end
  end

  def vote
    @talk_vote = existing_talk_vote || @talk.talk_votes.new(params[:talk_vote].merge(organizer_id: current_user.id))

    if (@talk_vote.id && @talk_vote.update_attributes(params[:talk_vote])) || @talk_vote.save
      success_and_redirect_to_next_talk
    else
      @speaker = @talk.speakers.first
      render :show
    end
  end

  private

  def existing_talk_vote
    @talk.talk_votes.where(organizer_id: current_user.id).first
  end

  def success_and_redirect_to_next_talk
    next_talk = @conference_edition.talks.pending.order('id DESC').where("id < ?", @talk.id).first

    if next_talk
      url = admin_conference_edition_talk_path(@conference_edition, next_talk)
      redirect_to(url, flash: { success: 'Vote saved successfully! Keep on going' })
    else
      url = admin_conference_edition_talks_path(@conference_edition)
      redirect_to(url, flash: { success: 'All set! Nicely done!' })
    end
  end
end
