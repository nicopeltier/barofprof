Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.paths << Rails.root.join("app/assets/builds")
Rails.application.config.assets.excluded_paths << Rails.root.join("app/javascript")
Rails.application.config.assets.excluded_paths << Rails.root.join("app/assets/stylesheets")
