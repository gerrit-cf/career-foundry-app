class Redis
  class << self
    def store(&block)
      @store ||= Redis.new(url: ENV['REDIS_URL'])
      @store.instance_eval(&block) if block_given?
      @store
    end
  end
end
