require "yaml"

module Sitepress
  module Parsers
    # Parses nothing. The body is returned and the data is blank.
    class Base
      def parse(source)
        ParserResult.new(data: {}, body: source)
      end
    end
  end
end
