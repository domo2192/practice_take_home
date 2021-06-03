class CancelSerializer
  include FastJsonapi::ObjectSerializer
  attribute :teas do |object|
    TeaSerializer.new(object.tea)
  end
end
