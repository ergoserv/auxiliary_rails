module AuxiliaryRails
  class AbstractError < StandardError
    def self.wrap(error)
      new(error.message)
    end
  end
end
