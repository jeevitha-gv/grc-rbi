class Asset < ActiveRecord::Base
	belongs_to :assetable, :polymorphic => true
	belongs_to :company
	belongs_to :location
	belongs_to :department
	belongs_to :asset_state
	belongs_to :classification
	belongs_to :info_asset_owner, class_name: 'User', foreign_key: 'owner_id'
	belongs_to :info_asset_custodian, class_name: 'User', foreign_key: 'custodian_id'
	belongs_to :info_asset_identifier, class_name: 'User', foreign_key: 'identifier_id'
	belongs_to :info_asset_evaluator, class_name: 'User', foreign_key: 'evaluated_by'
	belongs_to :asset_confi, class_name: 'AssetCriticality', foreign_key: 'confidentiality'
	belongs_to :asset_avail, class_name: 'AssetCriticality', foreign_key: 'availability'
	belongs_to :asset_integ, class_name: 'AssetCriticality', foreign_key: 'integrity'

	has_one :assessment

	has_one :asset_review

	has_one :asset_action
	belongs_to :users

	after_create :save_value, :send_notification

	def save_value		
		self.value = self.asset_confi.id + self.asset_avail.id + self.asset_integ.id
		if self.value <= 5
			self.severity = "Low"
		else
			self.value > 7 ? self.severity = "High" : self.severity = "Medium"
		end		
		self.save
	end

	def send_notification
		users_email = []
        users_email << (self.info_asset_owner.email if self.owner_id.present?) << (self.info_asset_custodian.email if self.custodian_id.present?) << (self.info_asset_evaluator.email if self.evaluated_by.present?)
        users_email.each_with_index do |email, index|
            # RiskMailer.delay.notify_users_about_risk(self, email, subject_array[index], name="risk")
        AssetMailer.delay.notify_asset(self,email)
    end
	end
end
