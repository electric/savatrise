module NavigationHelper

  def navigation(html_options = nil, &proc)
    raise ArgumentError, "Missing block" unless block_given?
    if html_options
      tag_options = create_tag_options(html_options)
    else
      tag_options = nil
    end

    @rs = ActionController::Routing::Routes
    concat("<ul#{tag_options}>", proc.binding)
    yield self
    concat('</ul>', proc.binding)
  end

  def active_tab(tab, active = @active_tab)
    return if tab.nil?
    if active.is_a?(Array)
      ' class="selected"' if active.include?(tab.to_s)
    else
      ' class="selected"' if active == tab.to_s    
    end
  end

  def tab(name, options = {}, html_options = nil, *parameters_for_method_reference, &proc)

    # give the li's a class if theres a child
    if options.is_a?(Hash)
      klass = active_tab(@rs.generate(options))
    else
      klass = active_tab(options)
    end

    li_contents = link_to(name, options, html_options, *parameters_for_method_reference)

    if block_given?
      parent_klass = active_tab parent_path, url_for(options)
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

    def parent_path
      if @parent_path.is_a?(Hash)
        path = @rs.generate(@parent_path)
      else
        path = @parent_path
      end
      path
    end

end