require 'test_helper'

class AdsbTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ADSB::VERSION
  end
end
