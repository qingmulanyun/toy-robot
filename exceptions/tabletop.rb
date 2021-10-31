module Exceptions
  module Tabletop
    class OutOfTabletop < StandardError
      def initialize(msg = 'ignored. invalid position')
        super
      end
    end
  end
end