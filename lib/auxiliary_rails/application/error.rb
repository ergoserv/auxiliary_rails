module AuxiliaryRails
  module Application
    class Error < StandardError
      # @return [self] Creates new error object
      def self.wrap(error)
        new(error.message)
      end
    end
  end
end
