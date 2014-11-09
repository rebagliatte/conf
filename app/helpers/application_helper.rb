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

  def video_iframe(provider, uid)
    "<iframe id=\"video-player\" allowfullscreen src=\"#{ video_src(provider, uid) }\"></iframe>".html_safe
  end

  def video_src(provider, uid)
    case provider
    when 'youtube'
      "http://www.youtube.com/embed/#{uid}?modestbranding=1&showinfo=0"
    when 'vimeo'
      "http://player.vimeo.com/video/#{uid}"
    end
  end

  def markdown(text)
    return '' if !text
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, no_intra_emphasis: true).render(text).html_safe
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
    else
      'fallback/default.jpg'
    end

    image_tag(image_src, alt: user.name, class: 'avatar')
  end

  def record_count(records, status)
    records.where(status: status).size
  end

  def humanized_collection(collection)
    collection.collect{ |item| [ item.to_s.humanize, item ] }
  end

 end
