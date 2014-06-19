class CreateCvssScorings < ActiveRecord::Migration
  def change
    create_table :cvss_scorings do |t|
      t.integer :cvss_access_vector
      t.integer :cvss_access_complexity
      t.integer :cvss_authentication
      t.integer :cvss_conf_impact
      t.integer :cvss_integ_impact
      t.integer :cvss_avail_impact
      t.integer :cvss_exploitability
      t.integer :cvss_remediation_level
      t.integer :cvss_report_confidence
      t.integer :cvss_collateral_damage_potential
      t.integer :cvss_target_distribution
      t.integer :cvss_confidentiality_requirement
      t.integer :cvss_integrity_requirement
      t.integer :cvss_availability_requirement
      t.timestamps
    end
    
    add_index :cvss_scorings, :cvss_access_vector, unique: true
    add_index :cvss_scorings, :cvss_access_complexity, unique: true
    add_index :cvss_scorings, :cvss_authentication, unique: true
    add_index :cvss_scorings, :cvss_conf_impact, unique: true
    add_index :cvss_scorings, :cvss_integ_impact, unique: true
    add_index :cvss_scorings, :cvss_avail_impact, unique: true
    add_index :cvss_scorings, :cvss_exploitability, unique: true
    add_index :cvss_scorings, :cvss_remediation_level, unique: true
    add_index :cvss_scorings, :cvss_report_confidence, unique: true
    add_index :cvss_scorings, :cvss_collateral_damage_potential, unique: true
    add_index :cvss_scorings, :cvss_target_distribution, unique: true
    add_index :cvss_scorings, :cvss_confidentiality_requirement, unique: true
    add_index :cvss_scorings, :cvss_integrity_requirement, unique: true
    add_index :cvss_scorings, :cvss_availability_requirement, unique: true
    
  end
end
