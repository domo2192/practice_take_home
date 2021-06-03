class TeaSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title,
             :description,
             :temperature,
             :brew_time,
             :tea_price 
end
