module Service
  class Result
    attr_reader :errors, :objects

    def initialize(objects, errors)
      @objects = objects
      @errors = errors
    end

    def error_messages
      errors.collect(&:message)
    end

    def successful?
      errors.empty?
    end
  end
end
