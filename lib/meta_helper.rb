module MetaHelper

  def meta_tags(options = {}, &proc)
    raise ArgumentError, "Missing block" unless block_given?

    (!options[:html].nil?) ? @open = true : @open = false

    yield self

  end

  protected

    def content_type content
      tag :meta, {'http-equiv' => 'Content-Type', :content => content}, @open
    end

    def description content
      tag :meta, {:name => 'description', :content => content}, @open
    end

    def keywords content
      tag :meta, {:name => 'keywords', :content => content}, @open
    end
    
    def author content
      tag :meta, {:name => 'author', :content => content}, @open
    end

end