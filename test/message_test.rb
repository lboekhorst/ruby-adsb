require 'test_helper'

class MessageTest < Minitest::Test
  def test_that_it_has_an_address
    message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
    assert_equal('4840d6', message.address)
  end

  def test_that_it_has_an_altitude
    message = ADSB::Message.new('8D40621D58C382D690C8AC2863A7')
    assert_equal(38000, message.altitude)
  end

  def test_that_it_has_data
    message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
    assert_equal('00100000001011001100001101110001110000110010110011100000', message.data)
  end

  def test_that_it_has_a_downlink_format
    message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
    assert_equal(17, message.downlink_format)
  end

  def test_that_it_has_a_heading
    message = ADSB::Message.new('8D485020994409940838175B284F')
    assert_in_delta(182.88, message.heading)
  end

  def test_that_it_has_an_identification
    message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
    assert_equal('KLM1023', message.identification)
  end

  def test_that_it_has_a_latitude
    message = ADSB::Message.new('8D40621D58C382D690C8AC2863A7')
    assert_equal(0.70953369140625, message.latitude)
  end

  def test_that_it_has_a_longitude
    message = ADSB::Message.new('8D40621D58C382D690C8AC2863A7')
    assert_equal(0.391937255859375, message.longitude)
  end

  def test_that_it_has_a_type_code
    message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
    assert_equal(4, message.type_code)
  end

  def test_that_it_has_a_velocity
    message = ADSB::Message.new('8D485020994409940838175B284F')
    assert_in_delta(159.201, message.velocity)
  end
end
