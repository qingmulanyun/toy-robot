module Exceptions
  module Command
    class InvalidCommand < StandardError
      def initialize(msg = 'ignored. invalid command')
        super
      end
    end
  end
end