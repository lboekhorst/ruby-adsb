module ADSB
  module Messages
    module Identification

      # Get the reported identification.
      #
      # ==== Examples
      #   message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
      #   address = message.address
      def identification
        characters = '#ABCDEFGHIJKLMNOPQRSTUVWXYZ#####_###############0123456789######'
        data = self.data[8..-1]
        identification = String.new
        (0..48).step(6) { |x| identification += characters[data[x..x + 5].to_i(2)] }
        return identification.gsub(/(_|#)/, String.new)
      end
    end
  end
end
