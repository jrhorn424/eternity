def with_env(env)
  env_base = Rails.env
  Rails.env = env.to_s
  ENV['RAILS_ENV'] = env.to_s
  ActiveRecord::Base.establish_connection("#{Rails.env}")
  yield
  Rails.env = env_base.to_s
  ENV['RAILS_ENV'] = env_base.to_s
  ActiveRecord::Base.establish_connection("#{Rails.env}")
end
