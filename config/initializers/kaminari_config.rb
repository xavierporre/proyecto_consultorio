# frozen_string_literal: true

# config/initializers/kaminari_config.rb
Kaminari.configure do |config|
  config.default_per_page = 10
  config.max_per_page = 100
  config.window = 2
  config.outer_window = 1
  config.left = 2
  config.right = 2
end