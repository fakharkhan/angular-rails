json.array!(@categories) do |category|
  json.extract! category, :title, :description, :active, :id
end
