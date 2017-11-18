class ApplicationSerializer
  include JSONAPI::Serializer

  def self_link; end

  def relationship_self_link(*); end

  def relationship_related_link(*); end
end
