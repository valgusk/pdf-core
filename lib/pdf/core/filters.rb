# frozen_string_literal: true

# prawn/core/filters.rb : Implements stream filters
#
# Copyright February 2013, Alexander Mankuta.  All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require 'zlib'

module PDF
  module Core
    module Filters
      module FlateDecode
        def self.encode(stream, params)
          if stream.respond_to?(:pdf_flate_encode)
            stream.pdf_flate_encode(params)
          else
            Zlib::Deflate.deflate(stream)
          end
        end

        def self.decode(stream, params = nil)
          if stream.respond_to?(:pdf_flate_decode)
            stream.pdf_flate_decode(params)
          else
            Zlib::Inflate.inflate(stream)
          end
        end
      end

      # Pass through stub
      module DCTDecode
        def self.encode(stream, _params = nil)
          stream
        end

        def self.decode(stream, _params = nil)
          stream
        end
      end
    end
  end
end
