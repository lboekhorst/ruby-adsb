module ADSB
  module CPR
    class Report < SimpleDelegator

      # Create a new compact position report.
      #
      # ==== Attributes
      # * +even+ - The position message of even parity
      # * +odd+ - The position message of odd parity
      #
      # ==== Examples
      #   even = ADSB::Message.new('8D40621D58C382D690C8AC2863A7')
      #   odd = ADSB::Message.new('8D40621D58C382D690C8AC2863A7')
      #   report = ADSB::CPR::Report.new(even, odd)
      def initialize even, odd
        @even = even
        @odd = odd
        @parity = even.created_at > odd.created_at ? 0 : 1
        super @parity.eql?(0) ? @even : @odd
      end

      # Get the reported altitude in feet.
      #
      # ==== Examples
      #   even = CPR::Message.new('8D40621D58C382D690C8AC2863A7')
      #   odd = CPR::Message.new('8D40621D58C382D690C8AC2863A7')
      #   report = CPR::Report.new(even, odd)
      #   altitude = report.altitude
      def altitude
        message = @parity.eql?(0) ? @even : @odd
        return message.altitude
      end

      # Get the reported latitude in decimal degrees.
      #
      # ==== Examples
      #   even = CPR::Message.new('8D40621D58C382D690C8AC2863A7')
      #   odd = CPR::Message.new('8D40621D58C382D690C8AC2863A7')
      #   report = CPR::Report.new(even, odd)
      #   latitude = report.latitude
      def latitude
        return @parity.eql?(0) ? even_latitude : odd_latitude
      end

      # Get the reported longitude in decimal degrees.
      #
      # ==== Examples
      #   even = CPR::Message.new('8D40621D58C382D690C8AC2863A7')
      #   odd = CPR::Message.new('8D40621D58C382D690C8AC2863A7')
      #   report = CPR::Report.new(even, odd)
      #   longitude = report.longitude
      def longitude
        ni = n(latitude, @parity)
        m = (@even.longitude * (transition_latitude(latitude) - 1) - @odd.longitude * transition_latitude(latitude) + 0.5).floor
        longitude = @parity.eql?(0) ? 360.0 / ni * (m % ni + @even.longitude) : 360.0 / ni * (m % ni + @odd.longitude)
        return longitude >= 180 ? longitude - 360 : longitude
      end

      private

      def even_latitude
        latitude = (latitude_index % 59) + @even.latitude
        latitude = 360.0 / 60 * latitude
        return latitude >= 270 ? latitude - 360 : latitude
      end

      def latitude_index
        latitude_index = 59 * @even.latitude - 60 * @odd.latitude + 0.5
        return latitude_index.floor
      end

      def odd_latitude
        latitude = (latitude_index % 59) + @odd.latitude
        latitude = 360.0 / 59 * latitude
        return latitude >= 270 ? latitude - 360 : latitude
      end

      def n latitude, parity
        transition_latitude = transition_latitude(latitude) - parity
        return transition_latitude > 1 ? transition_latitude : 1
      end

      def transition_latitude latitude
        a = 1 - Math.cos(Math::PI * 2 / 60)
        b = Math.cos(Math::PI / 180.0 * latitude.abs) ** 2
        transition_latitude = 2 * Math::PI / Math.acos(1 - a / b)
        return transition_latitude.to_i
      end
    end
  end
end
