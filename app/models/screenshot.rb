class Screenshot < ActiveRecord::Base
	mount_uploader :attachment, ScreenshotUploader

	after_save :enqueue_create_or_update_document_job
	after_destroy :enqueue_delete_document_job

	private

	def enqueue_create_or_update_document_job
	  Delayed::Job.enqueue CreateOrUpdateSwiftypeDocumentJob.new(self.id)
	end

	def enqueue_delete_document_job
	  Delayed::Job.enqueue DeleteSwiftypeDocumentJob.new(self.id)
	end
end


class CreateOrUpdateSwiftypeDocumentJob < Struct.new(:screenshot_id)
  def perform
    screenshot = Screenshot.find(screenshot_id)
    url = Rails.application.routes.url_helpers.screenshot_url(screenshot)
    tags = ''
    if screenshot.tags
	    tags = screenshot.tags.split /\s*,\s*/
	end
    client = Swiftype::Client.new
    client.create_or_update_document(ENV['SWIFTYPE_ENGINE_SLUG'],
                                     'gif',
                                     {:external_id => screenshot.id,
                                       :fields => [{:name => 'season', :value => screenshot.season, :type => 'integer'},
                                                   {:name => 'episode_number', :value => screenshot.episode_number, :type => 'integer'},
                                                   {:name => 'url', :value => url, :type => 'enum'},
                                                   {:name => 'image', :value => screenshot.attachment.url, :type => 'string'},
                                                   {:name => 'tags', :value => tags, :type => 'string'},
                                                   {:name => 'subtitle_text', :value => screenshot.subtitle_text, :type => 'text'},
                                                   {:name => 'created_at', :value => screenshot.created_at.iso8601, :type => 'date'}]})

  end
end

class DeleteSwiftypeDocumentJob < Struct.new(:screenshot_id)
  def perform
    client = Swiftype::Client.new
    client.destroy_document(ENV['SWIFTYPE_ENGINE_SLUG'], Screenshot.model_name.name.downcase, screenshot_id)
  end
end