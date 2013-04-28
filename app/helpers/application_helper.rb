module ApplicationHelper

  def video_embed_code(provider, uid)
    return '' unless provider && uid

    case provider
    when 'youtube'
      "<iframe class=\"youtube-player\" type=\"text/html\" width=\"640\" height=\"385\"
      src=\"http://www.youtube.com/embed/#{uid}\" allowfullscreen frameborder=\"0\"></iframe>".html_safe
    when 'vimeo'
      "<iframe src=\"http://player.vimeo.com/video/#{uid}\" width=\"640\" height=\"385\"
      frameborder=\"0\" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>".html_safe
    end
  end

end
