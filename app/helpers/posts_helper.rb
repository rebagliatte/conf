module PostsHelper

  def last_post(conference_edition)
    @last_post ||= conference_edition.posts.last
  end

end
