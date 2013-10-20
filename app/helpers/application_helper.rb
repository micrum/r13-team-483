module ApplicationHelper

  ##
  # Method renders icon.
  # When :file option is set to true(:file => true), icon is rendered as image and image file should be specified in name parameter.
  def icon(name, options = {})
    html_class = options[:class] || ''
    html_class += ' icon'

    if options.delete(:stub)
      return content_tag :i, nil, :class => 'icon-stub'
    end

    is_file = options.delete(:file)
    if is_file
      options[:class] = html_class.strip
      res = image_tag(name, options)
    else
      html_class += ' icon-white' if (options.delete(:white))
      html_class += " icon-#{name}"
      options[:class] = html_class.strip

      res = content_tag :i, nil, options
    end

    res
  end

  ##
  # Method renders string which contain icon and text(if given).
  # When :file option is set to true(:file => true), icon is rendered as image and image file should be specified in name parameter.
  def icon_label(icon_name, text = nil, options = {})
    res = icon(icon_name, options)
    res +=  html_safe_for_str("&nbsp;#{text}") unless text.blank?
    res
  end

  def html_safe_for_str(str)
    ActiveSupport::SafeBuffer.new(str)
  end

  def format_time(duration)
    return '-' unless duration
    duration = (duration * 1000).to_i
    duration = '< 1' if duration == 0
    "#{duration} µs"
  end
end
