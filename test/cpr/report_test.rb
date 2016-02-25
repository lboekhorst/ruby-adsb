require 'test_helper'

class ReportTest < Minitest::Test
  def setup
    even = ADSB::Message.new('8D40621D58C382D690C8AC2863A7')
    odd = ADSB::Message.new('8D40621D58C386435CC412692AD6')
    @report = ADSB::CPR::Report.new(even, odd)
  end

  def test_that_it_has_an_altitude
    assert_equal(38000, @report.altitude)
  end

  def test_that_it_has_a_latitude
    assert_in_delta(52.265, @report.latitude)
  end

  def test_that_it_has_a_longitude
    assert_in_delta(3.938, @report.longitude)
  end
end
