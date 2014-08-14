class AssetMailer < ActionMailer::Base
	default from: "noreply@fixrnix.in"

	def notify(other_asset,email)
		@other_asset = other_asset
		mail(:to => email, content_type: "text/html", :subject => "Asset Created susccefully" )
	end
end