namespace :videos do
  desc "Finds videos without titles and adds titles and slugs to the videos"
  task :add_titles => :environment do
  	no_title_videos = Video.where(title: ["", nil])
  	no_title_videos.each do |video|
  		xml_response = RestClient.get("http://services.tvrage.com/feeds/episodeinfo.php?sid=6190&ep=#{video.season}x#{video.episode_number}")
  		xml_doc = Nokogiri::XML(xml_response)
  		title = xml_doc.css('episode title').text
  		video.title = title
  		video.slug = title.parameterize
  		video.save
  	end
  end

  desc "Finds videos without slugs and adds slugs based on the title to the videos"
  task :add_slugs => :environment do
  	no_slug_videos = Video.where.not(title: ["", nil]).where(slug: ["", nil])
  	no_slug_videos.each do |video|
  		video.slug = video.title.parameterize
  		video.save
  	end
  end
end

