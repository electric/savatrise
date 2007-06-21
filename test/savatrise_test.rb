require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/meta_helper'
require File.dirname(__FILE__) + '/../lib/navigation_helper'
require File.dirname(__FILE__) + '/../lib/savatrise'
require 'action_view/helpers/tag_helper'

class SavatriseTest < Test::Unit::TestCase
  # Replace this with your real tests.
  include ActionView::Helpers::TagHelper
  include Savatrise

  def test_this_plugin
    meta_tags do |meta|
      output = meta.keywords 'cat, mouse, squirrel'
    end
    assert_equal '<meta content="cat, mouse, squirrel" name="keywords" />', output
  end

end
