source "https://rubygems.org"

ruby "3.3.6"

# Core
gem "rails", "~> 8.1.3"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Auth
gem "devise"
gem "devise-jwt"

# Multitenancy
gem "acts_as_tenant"


# Autorización
gem "pundit"

# Serialización
gem "jsonapi-serializer"

# Paginación
gem "pagy", "~> 8.6"
gem "avo"

# Soft delete (del proyecto de tu compañero)
gem "discard"

# Background jobs
gem "solid_queue"
gem "solid_cache"

# CORS para React
gem "rack-cors"

# Deploy
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "bundler-audit", require: false
end

group :test do
  gem "shoulda-matchers"
  gem "database_cleaner-active_record"
end