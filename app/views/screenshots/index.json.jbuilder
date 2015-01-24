json.array!(@screenshots) do |screenshot|
  json.extract! screenshot, :id, :attachment, :season, :episode_number, :time
  json.url screenshot_url(screenshot, format: :json)
end
