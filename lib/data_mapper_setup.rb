  env = ENV['RACK_ENV'] || 'development'

  DataMapper.setup(:default, "postgres://localhost/chitter_2_#{env}")

  DataMapper.finalize

  DataMapper.auto_upgrade!
