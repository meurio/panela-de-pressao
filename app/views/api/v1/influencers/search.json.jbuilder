json.array! @documents do |document|
  json.searchable_type document.searchable_type
  json.searchable_id document.searchable_id
  json.content "#{document.searchable.name}, #{document.searchable.role}"

  json.searchable do
    json.id document.searchable.id
    json.name document.searchable.name
    json.role document.searchable.role
    json.html render(partial: 'influencers/influencer_field.html', locals: { influencer: document.searchable })
  end
end