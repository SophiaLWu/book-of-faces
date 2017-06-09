class FeedsController < ApplicationController
	before_action :create_enricher

	def notification
		feed = StreamRails.feed_manager.get_notification_feed(current_user.id)
		results = feed.get["results"]
		@activities = @enricher.enrich_aggregated_activities(results)
	end

	private

		def create_enricher
			@enricher = StreamRails::Enrich.new
		end
end
