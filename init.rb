# Include hook code here
ENV['TZ'] = 'Pacific/Auckland'

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  error_style = "errorField"
  if html_tag =~ /<(input|textarea|select)[^>]+class=/
    style_attribute = html_tag =~ /class=['"]/
    html_tag.insert(style_attribute + 7, "#{error_style} ")
  elsif html_tag =~ /<(input|textarea|select)/
    first_whitespace = html_tag =~ /\s/
    html_tag[first_whitespace] = " class=\"#{error_style}\" "
  end
  html_tag
end


ActionController::Base.send :include, Savalicious
ActionView::Base.send :include, Savatrise