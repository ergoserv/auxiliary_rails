module AuxiliaryRails
  module Application
    class Error < StandardError
      def self.wrap(error)
        new(error.message)
      end
    end
  end
end
