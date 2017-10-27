module Service
  Error = Struct.new(:name, :message)

  module Base
    private
    def add_error(name, message = '')
      errors << Error.new(name, message)
    end

    def result(objects = {})
      Result.new(objects, errors)
    end

    def errors
      @errors ||= []
    end

    def transaction
      ActiveRecord::Base.transaction do
        yield
        raise ActiveRecord::Rollback if errors.any?
      end
    end
  end
end
