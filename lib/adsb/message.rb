module ADSB
  class Message

    # Create a new message.
    #
    # ==== Attributes
    # * +body+ - The body of the message as a hexadecimal string
    #
    # ==== Examples
    #   message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
    def initialize body
      @body = body.hex.to_s(2)
      decoder = Kernel.const_get("ADSB::Decoders::#{type.to_s.capitalize}")
      extend(decoder)
    end

    # Get the address of the sender.
    #
    # ==== Examples
    #   message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
    #   address = message.address
    def address
       '%02x' % @body[8..31].to_i(2)
    end

    def data
      @body[32..87]
    end

    def downlink_format
      @body[0..4].to_i(2)
    end

    # Get type of message.
    #
    # ==== Examples
    #   message = ADSB::Message.new('8D4840D6202CC371C32CE0576098')
    #   type = message.type
    def type
      case type_code
        when 1, 2, 3, 4 then :identification
      end
    end

    def type_code
      @body[32..36].to_i(2)
    end
  end
end
