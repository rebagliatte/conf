class Admin::TalksController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :talk, through: :conference_edition

  def index
    @talks = @talks.by_ranking unless @conference_edition.is_talk_voting_open?
    @talks = @talks.by_creation_date.group_by { |s| s.status }
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
      action = params[:talk][:status] ? @talk.status : 'updated'
      message = "Talk #{action} successfully. #{link_to_next_talk(@talk)}".html_safe
      redirect_to admin_conference_edition_talk_path(@conference_edition, @talk), flash: { success: message }
    else
      render :edit
    end
  end

  def vote
    vote_params = params[:talk_vote].merge(
      organizer_id: current_user.id,
      conference_edition_id: @conference_edition.id
    )

    @talk_vote = existing_talk_vote || @talk.talk_votes.new(vote_params)

    if (@talk_vote.id && @talk_vote.update_attributes(params[:talk_vote])) || @talk_vote.save
      success_and_redirect
    else
      @speaker = @talk.speakers.first
      params[:update_vote] = true
      render(:show)
    end
  end

  private

  def existing_talk_vote
    @talk.talk_votes.where(organizer_id: current_user.id).first
  end

  def success_and_redirect
    if !@conference_edition.is_talk_voting_open?
      url = admin_conference_edition_talk_path(@conference_edition, @talk)
      message = "Vote updated successfully. #{link_to_next_talk(@talk)}".html_safe
    elsif next_non_voted_talk
      url = admin_conference_edition_talk_path(@conference_edition, next_non_voted_talk)
      message = 'Vote saved successfully! Keep on going'
    else
      url = admin_conference_edition_talks_path(@conference_edition)
      message = 'All set!'
    end

    redirect_to(url, flash: { success: message })
  end

  def next_non_voted_talk
    voted_talk_ids = @conference_edition.talk_votes.where(organizer_id: current_user.id).pluck(:talk_id)
    all_talk_ids = @conference_edition.talks.pending.pluck(:id)
    non_voted_ids = all_talk_ids - voted_talk_ids
    Talk.where(id: non_voted_ids).by_creation_date.first
  end

  def link_to_next_talk(talk)
    next_talk = talk.conference_edition.talks.where(status: talk.status).where("created_at < ?", talk.created_at).by_creation_date.first
    if next_talk
      view_context.link_to('Review next talk', admin_conference_edition_talk_path(@conference_edition, next_talk, update_vote: true), tabindex: 1)
    else
      view_context.link_to('Back to talks listing', admin_conference_edition_talks_path(@conference_edition), tabindex: 1)
    end
  end
end
