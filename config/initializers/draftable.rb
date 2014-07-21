# Draftable.configure do |config|
# end

DRAFTABLES = Dir['app/models/*.rb'].map do |f|
  File.basename(f, '.*').camelize.constantize.name
end.reject do |m|
  ['Draft','Draftable'].include? m.to_s
end.reject do |m|
  m.to_s.match 'Draft'
end.select do |m|
  m.constantize.respond_to?(:draftable?)
end
