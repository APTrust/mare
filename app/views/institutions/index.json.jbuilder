json.array!(@institutions) do |institution|
  json.extract! institution, 
  json.url institution_url(institution, format: :json)
end
