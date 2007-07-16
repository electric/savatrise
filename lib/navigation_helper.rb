module NavigationHelper

  def navigation(html_options = nil, &proc)
    raise ArgumentError, "Missing block" unless block_given?
    if html_options
      tag_options = create_tag_options(html_options)
    else
      tag_options = nil
    end
    concat("<ul#{tag_options}>", proc.binding)
    yield self
    concat('</ul>', proc.binding)
  end

  def active_tab(tab, active = @active_tab)
    return if tab.nil?
    ' class="selected"' if tab.to_sym == active
  end

  def tab(name, options = {}, html_options = nil, *parameters_for_method_reference, &proc)
    if options.is_a?(Hash) && (options[:controller].nil? || options[:action].nil?)
      raise ArgumentError, 'You must include a controller and action!'
    end
    # give the li's a class if theres a child
    klass = active_tab "#{options[:controller]}_#{options[:action]}"

    li_contents = link_to(name, options, html_options, *parameters_for_method_reference)

    if block_given?
      parent_klass = active_tab @parent_tab, @parent_tab
      klass = parent_klass unless parent_klass.nil?

      concat("<li#{klass}>#{li_contents}<ul>", proc.binding)
      yield self
      concat("</ul></li>", proc.binding)
    else
      "<li#{klass}>#{li_contents}</li>"
    end
  end

  private

    def create_tag_options(html_options)
      html_options = html_options.stringify_keys
      convert_options_to_javascript!(html_options)
      tag_options = tag_options(html_options)
    end

end