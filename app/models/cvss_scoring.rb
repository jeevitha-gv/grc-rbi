class CvssScoring < ActiveRecord::Base
	
	has_one :risk_scoring , as: :scoring
	belongs_to :access_vector, :class_name => "CvssMetricScoring", foreign_key: "cvss_access_vector"
	belongs_to :access_complexity, :class_name => "CvssMetricScoring", foreign_key: "cvss_access_complexity"
	belongs_to :authentication, :class_name => "CvssMetricScoring", foreign_key: "cvss_authentication"
	belongs_to :conf_impact, :class_name => "CvssMetricScoring", foreign_key: "cvss_conf_impact"
	belongs_to :integ_impact, :class_name => "CvssMetricScoring", foreign_key: "cvss_integ_impact"
	belongs_to :avail_impact, :class_name => "CvssMetricScoring", foreign_key: "cvss_avail_impact"
	belongs_to :exploitability, :class_name => "CvssMetricScoring", foreign_key: "cvss_exploitability"
	belongs_to :report_confidence, :class_name => "CvssMetricScoring", foreign_key: "cvss_report_confidence"
	belongs_to :collateral_damage_potential, :class_name => "CvssMetricScoring", foreign_key: "cvss_collateral_damage_potential"
	belongs_to :target_distribution, :class_name => "CvssMetricScoring", foreign_key: "cvss_target_distribution"
	belongs_to :confidentiality_requirement, :class_name => "CvssMetricScoring", foreign_key: "cvss_confidentiality_requirement"
	belongs_to :integrity_requirement, :class_name => "CvssMetricScoring", foreign_key: "cvss_integrity_requirement"
	belongs_to :availability_requirement, :class_name => "CvssMetricScoring", foreign_key: "cvss_availability_requirement"
end
