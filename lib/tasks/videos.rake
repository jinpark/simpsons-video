namespace :videos do
  desc "Finds videos without titles and adds titles and slugs to the videos"
  task :add_titles_and_slugs => :environment do
    no_title_videos = Video.where(title: ["", nil])
    puts "Video add_titles rake task started"
    no_title_videos.each do |video|
      puts "Video #{video.id} started"
      xml_response = RestClient.get("http://services.tvrage.com/feeds/episodeinfo.php?sid=6190&ep=#{video.season}x#{video.episode_number}")
      xml_doc = Nokogiri::XML(xml_response)
      title = xml_doc.css('episode title').text
      video.title = title
      video.slug = title.parameterize
      video.save
      puts "Video #{video.id} finished. Title is #{video.title}"
    end
    puts "Video add_titles rake task finished"
  end

  desc "Finds videos without slugs and adds slugs based on the title to the videos"
  task :add_slugs_from_titles => :environment do
    no_slug_videos = Video.where.not(title: ["", nil]).where(slug: ["", nil])
    puts "Video add_slugs rake task started"
    no_slug_videos.each do |video|
      puts "Video #{video.id} started"
      video.slug = video.title.parameterize
      video.save
      puts "Video #{video.id} finished. Slug is #{video.slug}"
    end
    puts "Video add_slugs rake task finished"
  end

  desc "Check if file exists in path/filename"
  task :check_file_path => :environment do
    videos = Video.all
    puts "Video check_file_path rake task started"
    videos.each do |video|
      video_path = Rails.public_path.to_s + Rails.root.join(video.path, video.filename).to_s
      if !(File.exist?(video_path) || File.symlink?(video_path))
        puts "Video #{video.id} has invalid file path - #{video_path}"
      end
    end
    puts "Video check_file_path rake task finished"
  end

  desc "add subtitle path and filename"
  task :sub_path_and_name => :environment do
    videos = Video.all
    puts "add subtitle path and filename"
    videos.each do |video|
      subtitle_path = "/subtitles/#{video.season}/"
      subtitle_filename = "#{video.season}x#{video.episode_number}.srt"
      video.subtitle_path = subtitle_path
      video.subtitle_filename = subtitle_filename
      if !video.save
        puts "Video #{video.id} has invalid file path - #{video_path}"
      end
    end
    puts "Video add subtitle path and filename finished"
  end 
end
