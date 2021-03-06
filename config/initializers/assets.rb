# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( history.js )
Rails.application.config.assets.precompile += %w( show_video.js )

Rails.application.config.assets.precompile += %w( videos.css.scss )

Rails.application.config.assets.precompile += %w( darkly.css )
Rails.application.config.assets.precompile += %w( cyborg.css )
Rails.application.config.assets.precompile += %w( cyborg.js )

Rails.application.config.assets.precompile += %w( video.js )
Rails.application.config.assets.precompile += %w( videojs.hotkeys.js )

Rails.application.config.assets.precompile += %w( canvas-to-blob.min.js )