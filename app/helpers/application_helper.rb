module ApplicationHelper

  def title(text)
    content_for(:title, text)
    "<h1 class='primary-heading'>#{text}</h1>".html_safe
  end

  def body_class
    "#{params[:controller].parameterize}-#{params[:action].parameterize}"
  end

  def error_messages_for(object)
    render(partial: 'shared/error_messages', locals: { object: object })
  end

  def anchor_nav_link_to(text, anchor)
    if current_page?(root_url)
      link_to text, anchor
    else
      link_to text, "#{root_url}#{anchor}"
    end
  end

  def video_embed_code(provider, uid)
    return '' unless provider.present? && uid.present?

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

  def translatable_fields_for(form, &block)
    translations = form.object.translations
    render(partial: 'admin/shared/translatable_fields', locals: { form: form, translations: translations, block: block })
  end

  def avatar_for(user, image_attribute, version = nil)
    image_src = if user.send(image_attribute).present?
      src = user.send(image_attribute)
      version ? src.send(version) : src
    elsif user.email
      email_hash = Digest::MD5.hexdigest(user.email).to_s
      "http://www.gravatar.com/avatar/#{email_hash}?s=45"
    end

    image_tag(image_src, alt: user.name, class: 'avatar')
  end

  def record_count(records, status)
    records.where(status: status).size
  end

 end
