Fabrication.configure do |config|
  config.fabricator_path << 'db/samples/fabricators'
  config.path_prefix = Rails.root
  config.sequence_start = 10000
end
