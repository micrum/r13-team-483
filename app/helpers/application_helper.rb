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
    "#{duration} ms"
  end

  def format_status(status)
    return nil unless status
    st = %w(Pending Running Completed Error Timeout)
    klass = case(status)
              when 1
                'default'
              when 2
                'primary'
              when 3
                'success'
              when 4
                'danger'
              when 5
                'warning'
            end
    "<span class='label label-#{klass}'>#{st[status - 1]}</span>".html_safe
  end

  def calc_percentage(cur, max)
    return 0 unless cur
    return 0 unless max

    p = cur.to_f / max * 100
    p = 1 if p < 1
    p
  end

  def percent_to_color(p, reverse = false)
    red = p<50 ? 255 : (256 - (p-50)*5.12).to_i
    green = p>50 ? 128 :((p)*2.56).to_i
    "rgb(#{red}, #{green}, 0)"
  end

end
