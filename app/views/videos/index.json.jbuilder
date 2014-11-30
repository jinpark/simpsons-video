json.array!(@videos) do |video|
  json.extract! video, :id, :title, :season, :episode_number, :thumbnail, :path, :filename
  json.url video_url(video, format: :json)
end
