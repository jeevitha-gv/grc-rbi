class AssetMailer < ActionMailer::Base
	default from: "noreply@fixrnix.in"

	def notify(other_asset,email)
		@other_asset = other_asset
		mail(:to => email, content_type: "text/html", :subject => "Asset Created susccefully" )
	end

	def notify_vendor(vendor,email)
		@vendor = vendor
		mail(:to => email, content_type: "text/html", :subject => "Vendor asset created")
	end

	def notify_computer(computer,email)
		@computer = computer
		mail(:to => email, content_type: "text/html", :subject => "Computer asset created")
	end
end