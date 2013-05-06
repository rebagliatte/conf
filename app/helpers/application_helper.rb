module ApplicationHelper

  def title(text, options = {})
    content_for(:title, text)
    "<h1 class='primary-heading'>#{text}</h1>".html_safe unless options[:visible] == false
  end

  def error_messages_for(object)
    render(partial: 'shared/error_messages', locals: { object: object })
  end

  def nav_link_to(text, path)
    if current_page?(path)
      link_to text, '#', class: 'current'
    else
      link_to text, path
    end
  end

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

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true).render(text).html_safe
  end

end
