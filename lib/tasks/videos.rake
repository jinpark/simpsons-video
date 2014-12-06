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
end

