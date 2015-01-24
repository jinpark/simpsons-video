class Screenshot < ActiveRecord::Base
	mount_uploader :attachment, ScreenshotUploader
end
