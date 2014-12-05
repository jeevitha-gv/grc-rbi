# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(email: 'admin@fixnix.com', password: 'adminfixnix', password_confirmation: 'adminfixnix')

QuestionType.delete_all

    QuestionType.create(name: 'Yes or No')
    QuestionType.create(name: 'Descriptive Type')
    QuestionType.create(name: 'Multiple Choice')

Topic.delete_all

    Topic.create(name: 'Network Security')
    Topic.create(name: 'Physical Security')
    Topic.create(name: 'System Security')
    Topic.create(name: 'Access')
    Topic.create(name: 'Applications')
    Topic.create(name: 'Others')

Score.delete_all

     Score.create(level: '0', description: '0%')
     Score.create(level: '1', description: '>0% - 50%')
     Score.create(level: '2', description: '>50% - 70%')
     Score.create(level: '3', description: '>70% - 90%')
     Score.create(level: '4', description: '>90% - 100%')

AuditType.delete_all

    AuditType.create(name: 'Internal Audit')
    AuditType.create(name: 'External Audit')
    AuditType.create(name: 'Regulators')
    AuditType.create(name: 'Self Audit')

AuditStatus.delete_all

   AuditStatus.create(name: 'Planning')
   AuditStatus.create(name: 'Initiated')
   AuditStatus.create(name: 'In Progress')
   AuditStatus.create(name: 'Published')
   AuditStatus.create(name: 'Halted')
   AuditStatus.create(name: 'Cancelled')

Compliance.delete_all

    Compliance.create(name: 'ISO 27001')
    Compliance.create(name: 'FISMA')
    Compliance.create(name: 'HIPAA')
    Compliance.create(name: 'COBIT')
    Compliance.create(name: 'ISO 28000')
    Compliance.create(name: 'OSHAS')
    Compliance.create(name: 'PCI DSS')
    Compliance.create(name: 'SOX')

RecommendationStatus.delete_all

    RecommendationStatus.create(name: 'Opened Recommendation')
    RecommendationStatus.create(name: 'Risk accepted for Recommendation')
    RecommendationStatus.create(name: 'Closed Recommendation')
    RecommendationStatus.create(name: 'Closed duplicate Recommendation')

ResponseStatus.delete_all

    ResponseStatus.create(name: 'Planning')
    ResponseStatus.create(name: 'In Progress')
    ResponseStatus.create(name: 'Halted')
    ResponseStatus.create(name: 'Cancelled')
    ResponseStatus.create(name: 'Completed')

Role.delete_all

    role = Role.new(title: 'company_admin')
    role.save(validate: false)
    Role.create(title: 'company user')

Section.delete_all

    Section.create(name: 'Audit')
    Section.create(name: 'Risk')
    Section.create(name: 'Incident')
    Section.create(name: 'Asset')
    Section.create(name: 'Policy')
    Section.create(name: 'Control')
    Section.create(name: 'Fraud')
    Section.create(name: 'BCPM')

Priority.delete_all

    Priority.create(name: 'High')
    Priority.create(name: 'Medium')
    Priority.create(name: 'Low')

ReminderAssignment.delete_all

    ReminderAssignment.create(name: 'Company Admin')
    ReminderAssignment.create(name: 'Auditor')
    ReminderAssignment.create(name: 'Auditee')
    ReminderAssignment.create(name: 'Reporting Manager')
    ReminderAssignment.create(name: 'Manager of Manager')
    ReminderAssignment.create(name: 'Team')

ComplianceLibrary.delete_all

    ComplianceLibrary.create(name: 'Organizing Information Security', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL' )
    ComplianceLibrary.create(name: 'Internal Organization', compliance_id: '1', is_leaf: 'FALSE', parent_id: '1')
    ComplianceLibrary.create(name: 'Management Commitment to information security', compliance_id: '1', is_leaf: 'TRUE', parent_id: '2')
    ComplianceLibrary.create(name: 'Information Security Co-ordination', compliance_id: '1', is_leaf: 'TRUE', parent_id: '2')
    ComplianceLibrary.create(name: 'Allocation of information security Responsibilities',compliance_id: '1', is_leaf: 'TRUE', parent_id: '2')
    ComplianceLibrary.create(name: 'Authorization process for Information Processing facilities', compliance_id: '1',is_leaf: 'TRUE', parent_id: '2')
    ComplianceLibrary.create(name: 'Confidentiality agreements', compliance_id: '1', is_leaf: 'TRUE', parent_id: '2')
    ComplianceLibrary.create(name: 'Contact with authorities', compliance_id: '1', is_leaf: 'TRUE', parent_id: '2')
    ComplianceLibrary.create(name: 'Contact with special interest groups', compliance_id: '1', is_leaf: 'TRUE', parent_id: '2')
    ComplianceLibrary.create(name: 'Independent review of information security', compliance_id: '1', is_leaf: 'TRUE', parent_id: '2')
    ComplianceLibrary.create(name: 'External Parties', compliance_id: '1', is_leaf: 'FALSE', parent_id: '1')
    ComplianceLibrary.create(name: 'Identification of risk related to external parties', compliance_id: '1', is_leaf: 'TRUE', parent_id: '11')
    ComplianceLibrary.create(name: 'Addressing security when dealing with customers', compliance_id: '1', is_leaf: 'TRUE', parent_id: '11')
    ComplianceLibrary.create(name: 'Addressing security in third party agreements', compliance_id: '1', is_leaf: 'TRUE', parent_id: '11')
    ComplianceLibrary.create(name: 'Asset Management', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Resposibilty for Assets', compliance_id: '1', is_leaf: 'FALSE', parent_id: '15')
    ComplianceLibrary.create(name: 'Inventory of assets', compliance_id: '1', is_leaf: 'TRUE', parent_id: '16')
    ComplianceLibrary.create(name: 'Ownership of Assets', compliance_id: '1', is_leaf: 'TRUE', parent_id: '16')
    ComplianceLibrary.create(name: 'Acceptable use of assets', compliance_id: '1', is_leaf: 'TRUE', parent_id: '16')
    ComplianceLibrary.create(name: 'Information Classification', compliance_id: '1', is_leaf: 'FALSE', parent_id: '15')
    ComplianceLibrary.create(name: 'Classification Guidelines', compliance_id: '1', is_leaf: 'TRUE', parent_id: '20')
    ComplianceLibrary.create(name: 'Information Labeling and Handling', compliance_id: '1', is_leaf: 'TRUE', parent_id: '20')
    ComplianceLibrary.create(name: 'Human Resources Security', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Prior to Employment', compliance_id: '1', is_leaf: 'FALSE', parent_id: '23')
    ComplianceLibrary.create(name: 'Roles and Responsibilities', compliance_id: '1', is_leaf: 'TRUE', parent_id: '24')
    ComplianceLibrary.create(name: 'Screening', compliance_id: '1', is_leaf: 'TRUE', parent_id: '24')
    ComplianceLibrary.create(name: 'Terms and conditions of employment', compliance_id: '1', is_leaf: 'TRUE', parent_id: '24')
    ComplianceLibrary.create(name: 'During Employment', compliance_id: '1', is_leaf: 'FALSE', parent_id: '23')
    ComplianceLibrary.create(name: 'Management Responsibility', compliance_id: '1', is_leaf: 'TRUE', parent_id: '28')
    ComplianceLibrary.create(name: 'Information security awareness, education and training', compliance_id: '1', is_leaf: 'TRUE', parent_id: '28')
    ComplianceLibrary.create(name: 'Disciplinary process', compliance_id: '1', is_leaf: 'TRUE', parent_id: '28')
    ComplianceLibrary.create(name: 'Termination or Change of Employment', compliance_id: '1', is_leaf: 'FALSE', parent_id: '23')
    ComplianceLibrary.create(name: 'Termination responsibility', compliance_id: '1', is_leaf: 'TRUE', parent_id: '32')
    ComplianceLibrary.create(name: 'Return of assets', compliance_id: '1', is_leaf: 'TRUE', parent_id: '32')
    ComplianceLibrary.create(name: 'Removal of access rights', compliance_id: '1', is_leaf: 'TRUE', parent_id: '32')
    ComplianceLibrary.create(name: 'Physical & Environmental Security', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Secure Areas', compliance_id: '1', is_leaf: 'FALSE', parent_id: '36')
    ComplianceLibrary.create(name: 'Physical security Perimeter', compliance_id: '1', is_leaf: 'TRUE', parent_id: '37')
    ComplianceLibrary.create(name: 'Physical entry controls', compliance_id: '1', is_leaf: 'TRUE', parent_id: '37')
    ComplianceLibrary.create(name: 'Securing offices, rooms and facilities', compliance_id: '1', is_leaf: 'TRUE', parent_id: '37')
    ComplianceLibrary.create(name: 'Protecting against external and environmental threats', compliance_id: '1', is_leaf: 'TRUE', parent_id: '37')
    ComplianceLibrary.create(name: 'Working in secure areas', compliance_id: '1', is_leaf: 'TRUE', parent_id: '37')
    ComplianceLibrary.create(name: 'Public access, delivery and loading areas', compliance_id: '1', is_leaf: 'TRUE', parent_id: '37')
    ComplianceLibrary.create(name: 'Equipment Security', compliance_id: '1', is_leaf: 'FALSE', parent_id: '36')
    ComplianceLibrary.create(name: 'Equipment sitting and protection', compliance_id: '1', is_leaf: 'TRUE', parent_id: '44')
    ComplianceLibrary.create(name: 'Support utilities', compliance_id: '1', is_leaf: 'TRUE', parent_id: '44')
    ComplianceLibrary.create(name: 'Cabling security', compliance_id: '1', is_leaf: 'TRUE', parent_id: '44')
    ComplianceLibrary.create(name: 'Equipment Maintenance', compliance_id: '1', is_leaf: 'TRUE', parent_id: '44')
    ComplianceLibrary.create(name: 'Security of equipment off-premises', compliance_id: '1', is_leaf: 'TRUE', parent_id: '44')
    ComplianceLibrary.create(name: 'Secure disposal or reuse of equipment', compliance_id: '1', is_leaf: 'TRUE', parent_id: '44')
    ComplianceLibrary.create(name: 'Removal of Property', compliance_id: '1', is_leaf: 'TRUE', parent_id: '44')
    ComplianceLibrary.create(name: 'Communications AND Operations Management', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Operational procedures and responsibilities', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Documented operating procedures', compliance_id: '1', is_leaf: 'TRUE', parent_id: '53')
    ComplianceLibrary.create(name: 'Change management', compliance_id: '1', is_leaf: 'TRUE', parent_id: '53')
    ComplianceLibrary.create(name: 'Segregation of duties', compliance_id: '1', is_leaf: 'TRUE', parent_id: '53')
    ComplianceLibrary.create(name: 'Separation of development, test and operational facilities', compliance_id: '1', is_leaf: 'TRUE', parent_id: '53')
    ComplianceLibrary.create(name: 'Third party service delivery management', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Service delivery', compliance_id: '1', is_leaf: 'TRUE', parent_id: '58')
    ComplianceLibrary.create(name: 'Monitoring and review of third party services', compliance_id: '1', is_leaf: 'TRUE', parent_id: '58')
    ComplianceLibrary.create(name: 'Managing changes to third party services', compliance_id: '1', is_leaf: 'TRUE', parent_id: '58')
    ComplianceLibrary.create(name: 'System planning and acceptance', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Capacity management', compliance_id: '1', is_leaf: 'TRUE', parent_id: '62')
    ComplianceLibrary.create(name: 'System acceptance', compliance_id: '1', is_leaf: 'TRUE', parent_id: '62')
    ComplianceLibrary.create(name: 'Third party/Vendor service delivery  management', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Controls against malicious code', compliance_id: '1', is_leaf: 'TRUE', parent_id: '65')
    ComplianceLibrary.create(name: 'Controls against mobile code', compliance_id: '1', is_leaf: 'TRUE', parent_id: '65')
    ComplianceLibrary.create(name: 'Back-up', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Information back-up', compliance_id: '1', is_leaf: 'TRUE', parent_id: '68')
    ComplianceLibrary.create(name: 'Network security management', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Network controls', compliance_id: '1', is_leaf: 'TRUE', parent_id: '70')
    ComplianceLibrary.create(name: 'Security of network services', compliance_id: '1', is_leaf: 'TRUE', parent_id: '70')
    ComplianceLibrary.create(name: 'Media handling', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Management of removable media', compliance_id: '1', is_leaf: 'TRUE', parent_id: '73')
    ComplianceLibrary.create(name: 'Disposal of media', compliance_id: '1', is_leaf: 'TRUE', parent_id: '73')
    ComplianceLibrary.create(name: 'Information handling procedures', compliance_id: '1', is_leaf: 'TRUE', parent_id: '73')
    ComplianceLibrary.create(name: 'Security of system documentation', compliance_id: '1', is_leaf: 'TRUE', parent_id: '73')
    ComplianceLibrary.create(name: 'Exchange of information', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Information exchange policies and procedures', compliance_id: '1', is_leaf: 'TRUE', parent_id: '78')
    ComplianceLibrary.create(name: 'Exchange agreements', compliance_id: '1', is_leaf: 'TRUE', parent_id: '78')
    ComplianceLibrary.create(name: 'Physical media in transit', compliance_id: '1', is_leaf: 'TRUE', parent_id: '78')
    ComplianceLibrary.create(name: 'Electronic messaging', compliance_id: '1', is_leaf: 'TRUE', parent_id: '78')
    ComplianceLibrary.create(name: 'Business information systems', compliance_id: '1', is_leaf: 'TRUE', parent_id: '78')
    ComplianceLibrary.create(name: 'Electronic commerce services', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Electronic commerce', compliance_id: '1', is_leaf: 'TRUE', parent_id: '84')
    ComplianceLibrary.create(name: 'On-line transactions', compliance_id: '1', is_leaf: 'TRUE', parent_id: '84')
    ComplianceLibrary.create(name: 'Publicly available information', compliance_id: '1', is_leaf: 'TRUE', parent_id: '84')
    ComplianceLibrary.create(name: 'Monitoring', compliance_id: '1', is_leaf: 'FALSE', parent_id: '52')
    ComplianceLibrary.create(name: 'Audit logging', compliance_id: '1', is_leaf: 'TRUE', parent_id: '88')
    ComplianceLibrary.create(name: 'Monitoring system use', compliance_id: '1', is_leaf: 'TRUE', parent_id: '88')
    ComplianceLibrary.create(name: 'Protection of log information', compliance_id: '1', is_leaf: 'TRUE', parent_id: '88')
    ComplianceLibrary.create(name: 'Administrator and operator logs', compliance_id: '1', is_leaf: 'TRUE', parent_id: '88')
    ComplianceLibrary.create(name: 'Fault logging', compliance_id: '1', is_leaf: 'TRUE', parent_id: '88')
    ComplianceLibrary.create(name: 'Clock synchronization', compliance_id: '1', is_leaf: 'TRUE', parent_id: '88')
    ComplianceLibrary.create(name: 'Access Control', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Business requirement for access control', compliance_id: '1', is_leaf: 'FALSE', parent_id: '95')
    ComplianceLibrary.create(name: 'Access control policy', compliance_id: '1', is_leaf: 'TRUE', parent_id: '96')
    ComplianceLibrary.create(name: 'User access management', compliance_id: '1', is_leaf: 'FALSE', parent_id: '95')
    ComplianceLibrary.create(name: 'User registration', compliance_id: '1', is_leaf: 'TRUE', parent_id: '98')
    ComplianceLibrary.create(name: 'Privilege management', compliance_id: '1', is_leaf: 'TRUE', parent_id: '98')
    ComplianceLibrary.create(name: 'User password management', compliance_id: '1', is_leaf: 'TRUE', parent_id: '98')
    ComplianceLibrary.create(name: 'Review of user access rights', compliance_id: '1', is_leaf: 'TRUE', parent_id: '98')
    ComplianceLibrary.create(name: 'User responsibilities', compliance_id: '1', is_leaf: 'FALSE', parent_id: '95')
    ComplianceLibrary.create(name: 'Password use', compliance_id: '1', is_leaf: 'TRUE', parent_id: '103')
    ComplianceLibrary.create(name: 'Unattended user equipment', compliance_id: '1', is_leaf: 'TRUE', parent_id: '103')
    ComplianceLibrary.create(name: 'Clear desk and clear screen policy', compliance_id: '1', is_leaf: 'TRUE', parent_id: '103')
    ComplianceLibrary.create(name: 'User Access Management', compliance_id: '1',is_leaf: 'FALSE', parent_id: '95')
    ComplianceLibrary.create(name: 'Policy on use of network services', compliance_id: '1', is_leaf: 'TRUE', parent_id: '107')
    ComplianceLibrary.create(name: 'User authentication for external connections', compliance_id: '1', is_leaf: 'TRUE', parent_id: '107')
    ComplianceLibrary.create(name: 'Equipment identification in networks', compliance_id: '1', is_leaf: 'TRUE', parent_id: '107')
    ComplianceLibrary.create(name: 'Remote diagnostic and configuration port protection', compliance_id: '1', is_leaf: 'TRUE', parent_id: '107')
    ComplianceLibrary.create(name: 'Segregation in networks', compliance_id: '1', is_leaf: 'TRUE', parent_id: '107')
    ComplianceLibrary.create(name: 'Network connection control', compliance_id: '1', is_leaf: 'TRUE', parent_id: '107')
    ComplianceLibrary.create(name: 'Network routing control', compliance_id: '1', is_leaf: 'TRUE', parent_id: '107')
    ComplianceLibrary.create(name: 'Operating system access control', compliance_id: '1', is_leaf: 'FALSE', parent_id: '95')
    ComplianceLibrary.create(name: 'Secure log-on procedures', compliance_id: '1', is_leaf: 'TRUE', parent_id: '115')
    ComplianceLibrary.create(name: 'User identification and authentication', compliance_id: '1', is_leaf: 'TRUE', parent_id: '115')
    ComplianceLibrary.create(name: 'Password management system', compliance_id: '1', is_leaf: 'TRUE', parent_id: '115')
    ComplianceLibrary.create(name: 'Use of system utilities', compliance_id: '1', is_leaf: 'TRUE', parent_id: '115')
    ComplianceLibrary.create(name: 'Session time-out', compliance_id: '1', is_leaf: 'TRUE', parent_id: '115')
    ComplianceLibrary.create(name: 'Limitation of connection time', compliance_id: '1', is_leaf: 'TRUE', parent_id: '115')
    ComplianceLibrary.create(name: 'Application and information access control', compliance_id: '1', is_leaf: 'FALSE', parent_id: '95')
    ComplianceLibrary.create(name: 'Information access restriction', compliance_id: '1', is_leaf: 'TRUE', parent_id: '122')
    ComplianceLibrary.create(name: 'Sensitive system isolation', compliance_id: '1', is_leaf: 'TRUE', parent_id: '122')
    ComplianceLibrary.create(name: 'Mobile computing and teleworking', compliance_id: '1', is_leaf: 'FALSE', parent_id: '95')
    ComplianceLibrary.create(name: 'Mobile computing and communications', compliance_id: '1', is_leaf: 'TRUE', parent_id: '125')
    ComplianceLibrary.create(name: 'Teleworking', compliance_id: '1', is_leaf: 'TRUE', parent_id: '125')
    ComplianceLibrary.create(name: 'Information Systems Acquisition, Development and Maintenance', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Security Requirements of Information Systems', compliance_id: '1', is_leaf: 'FALSE', parent_id: '128')
    ComplianceLibrary.create(name: 'Security requirements analysis and specification', compliance_id: '1', is_leaf: 'TRUE', parent_id: '129')
    ComplianceLibrary.create(name: 'Internal Processing & Integrity of Information Systems', compliance_id: '1', is_leaf: 'FALSE', parent_id: '128')
    ComplianceLibrary.create(name: 'Input data validation', compliance_id: '1', is_leaf: 'TRUE', parent_id: '131')
    ComplianceLibrary.create(name: 'Control of internal processing', compliance_id: '1', is_leaf: 'TRUE', parent_id: '131')
    ComplianceLibrary.create(name: 'Message integrity', compliance_id: '1', is_leaf: 'TRUE', parent_id: '131')
    ComplianceLibrary.create(name: 'Output data validation', compliance_id: '1', is_leaf: 'TRUE', parent_id: '131')
    ComplianceLibrary.create(name: 'Cryptography', compliance_id: '1', is_leaf: 'FALSE', parent_id: '128')
    ComplianceLibrary.create(name: 'Policy on the use of cryptographic controls', compliance_id: '1', is_leaf: 'TRUE', parent_id: '136')
    ComplianceLibrary.create(name: 'Key management', compliance_id: '1', is_leaf: 'TRUE', parent_id: '136')
    ComplianceLibrary.create(name: 'Security of system files', compliance_id: '1', is_leaf: 'FALSE', parent_id: '128')
    ComplianceLibrary.create(name: 'Control of operational software', compliance_id: '1', is_leaf: 'TRUE', parent_id: '139')
    ComplianceLibrary.create(name: 'Protection of system test data', compliance_id: '1', is_leaf: 'TRUE', parent_id: '139')
    ComplianceLibrary.create(name: 'Access control to program source code', compliance_id: '1', is_leaf: 'TRUE', parent_id: '139')
    ComplianceLibrary.create(name: 'Security in development and support processes', compliance_id: '1', is_leaf: 'FALSE', parent_id: '128')
    ComplianceLibrary.create(name: 'Change control procedures', compliance_id: '1', is_leaf: 'TRUE', parent_id: '143')
    ComplianceLibrary.create(name: 'Technical review of applications after operating system changes', compliance_id: '1', is_leaf: 'TRUE', parent_id: '143')
    ComplianceLibrary.create(name: 'Restrictions on changes to software packages', compliance_id: '1', is_leaf: 'TRUE', parent_id: '143')
    ComplianceLibrary.create(name: 'Information leakage', compliance_id: '1', is_leaf: 'TRUE', parent_id: '143')
    ComplianceLibrary.create(name: 'Outsourced software development', compliance_id: '1', is_leaf: 'TRUE', parent_id: '143')
    ComplianceLibrary.create(name: 'Technical Vulnerability Management', compliance_id: '1', is_leaf: 'FALSE', parent_id: '128')
    ComplianceLibrary.create(name: 'Control of technical vulnerabilities', compliance_id: '1', is_leaf: 'TRUE', parent_id: '149')
    ComplianceLibrary.create(name: 'Information Security Incident Management', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Reporting information security events and weaknesses', compliance_id: '1', is_leaf: 'FALSE', parent_id: '151')
    ComplianceLibrary.create(name: 'Reporting information security events', compliance_id: '1', is_leaf: 'TRUE', parent_id: '152')
    ComplianceLibrary.create(name: 'Reporting security weaknesses', compliance_id: '1', is_leaf: 'TRUE', parent_id: '152')
    ComplianceLibrary.create(name: 'Management of information security incidents and improvements', compliance_id: '1', is_leaf: 'FALSE', parent_id: '151')
    ComplianceLibrary.create(name: 'Responsibilities and procedures', compliance_id: '1', is_leaf: 'TRUE', parent_id: '155')
    ComplianceLibrary.create(name: 'Learning from information security incidents', compliance_id: '1', is_leaf: 'TRUE', parent_id: '155')
    ComplianceLibrary.create(name: 'Collection of evidence', compliance_id: '1', is_leaf: 'TRUE', parent_id: '155')
    ComplianceLibrary.create(name: 'Business continuity Management', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Information security aspects of business continuity management', compliance_id: '1', is_leaf: 'FALSE', parent_id: '159')
    ComplianceLibrary.create(name: 'Including information security in the business continuity management process', compliance_id: '1', is_leaf: 'TRUE', parent_id: '160')
    ComplianceLibrary.create(name: 'Business continuity and risk assessment', compliance_id: '1', is_leaf: 'TRUE', parent_id: '160')
    ComplianceLibrary.create(name: 'Developing and implementing continuity plans including information security', compliance_id: '1', is_leaf: 'TRUE', parent_id: '160')
    ComplianceLibrary.create(name: 'Business continuity planning framework', compliance_id: '1', is_leaf: 'TRUE', parent_id: '160')
    ComplianceLibrary.create(name: 'Testing, maintaining and reassessing business continuity plans', compliance_id: '1', is_leaf: 'TRUE', parent_id: '160')
    ComplianceLibrary.create(name: 'Compliance', compliance_id: '1', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Compliance with Legal Requirements', compliance_id: '1', is_leaf: 'FALSE', parent_id: '166')
    ComplianceLibrary.create(name: 'Identification of applicable legislation', compliance_id: '1', is_leaf: 'TRUE', parent_id: '167')
    ComplianceLibrary.create(name: 'Intellectual property rights (IPR)', compliance_id: '1', is_leaf: 'TRUE', parent_id: '167')
    ComplianceLibrary.create(name: 'Protection of organizational records', compliance_id: '1', is_leaf: 'TRUE', parent_id: '167')
    ComplianceLibrary.create(name: 'Data protection and privacy of personal information', compliance_id: '1', is_leaf: 'TRUE', parent_id: '167')
    ComplianceLibrary.create(name: 'Prevention of misuse of information processing facilities', compliance_id: '1', is_leaf: 'TRUE', parent_id: '167')
    ComplianceLibrary.create(name: 'Regulation of cryptographic controls', compliance_id: '1', is_leaf: 'TRUE', parent_id: '167')
    ComplianceLibrary.create(name: 'Compliance with Security Policies, Standards and technical Compliance', compliance_id: '1', is_leaf: 'FALSE', parent_id: '166')
    ComplianceLibrary.create(name: 'Compliance with security policies and standards', compliance_id: '1', is_leaf: 'TRUE', parent_id: '174')
    ComplianceLibrary.create(name: 'Technical compliance checking', compliance_id: '1', is_leaf: 'TRUE', parent_id: '174')
    ComplianceLibrary.create(name: 'Information Systems Audit Considerations', compliance_id: '1', is_leaf: 'FALSE', parent_id: '166')
    ComplianceLibrary.create(name: 'Information systems audit controls', compliance_id: '1', is_leaf: 'TRUE', parent_id: '177')
    ComplianceLibrary.create(name: 'Protection of information systems audit tools', compliance_id: '1', is_leaf: 'TRUE', parent_id: '177')
    ComplianceLibrary.create(name: 'Install and maintain a firewall configuration to protect cardholder data', compliance_id: '7', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Establish firewall and router configuration standards that include the following:', compliance_id: '7', is_leaf: 'FALSE', parent_id: '180')
    ComplianceLibrary.create(name: 'A formal process for approving and testing all network connections and changes to the firewall and router configurations', compliance_id: '7', is_leaf: 'TRUE', parent_id: '181')
    ComplianceLibrary.create(name: 'Current network diagram with all connections to cardholder data, including any wireless networks', compliance_id: '7', is_leaf: 'TRUE', parent_id: '181')
    ComplianceLibrary.create(name: 'Requirements for a firewall at each Internet connection and between any demilitarized zone and the internal network zone', compliance_id: '7', is_leaf: 'TRUE', parent_id: '181')
    ComplianceLibrary.create(name: 'Description of groups, roles, and responsibilities for logical management of network components', compliance_id: '7', is_leaf: 'TRUE', parent_id: '181')
    ComplianceLibrary.create(name: 'Documentation and business justification for use of all services, protocols, and ports allowed', compliance_id: '7', is_leaf: 'TRUE', parent_id: '181')
    ComplianceLibrary.create(name: 'Requirement to review firewall and router rule sets at least every six months', compliance_id: '7', is_leaf: 'TRUE', parent_id: '181')
    ComplianceLibrary.create(name: 'Build firewall and router configurations that restrict connections between untrusted networks and any system components in the cardholder data environment', compliance_id: '7', is_leaf: 'FALSE', parent_id: '180')
    ComplianceLibrary.create(name: 'Restrict inbound and outbound traffic to that which is necessary for the cardholder data environment', compliance_id: '7', is_leaf: 'TRUE', parent_id: '188')
    ComplianceLibrary.create(name: 'Secure and synchronize router configuration files', compliance_id: '7', is_leaf: 'TRUE', parent_id: '188')
    ComplianceLibrary.create(name: 'Install perimeter firewalls between any wireless networks and the cardholder data environment, and configure  any traffic from the wireless environment into the cardholder data environment', compliance_id: '7', is_leaf: 'TRUE', parent_id: '188')
    ComplianceLibrary.create(name: 'Prohibit direct public access between the Internet and any system component in the cardholder data environment', compliance_id: '7', is_leaf: 'FALSE', parent_id: '180')
    ComplianceLibrary.create(name: 'Implement a DMZ to limit inbound traffic to only system components that provide authorized publicly accessible services, protocols, and ports', compliance_id: '7', is_leaf: 'TRUE', parent_id: '192')
    ComplianceLibrary.create(name: 'Limit inbound Internet traffic to IP addresses within the DMZ', compliance_id: '7', is_leaf: 'TRUE', parent_id: '192')
    ComplianceLibrary.create(name: 'Do not allow any direct connections inbound or outbound for traffic between the Internet and the cardholder data environment', compliance_id: '7', is_leaf: 'TRUE', parent_id: '192')
    ComplianceLibrary.create(name: 'Do not allow internal addresses to pass from the Internet into the DMZ', compliance_id: '7', is_leaf: 'TRUE', parent_id: '192')
    ComplianceLibrary.create(name: 'Do not allow unauthorized outbound traffic from the cardholder data environment to the Internet', compliance_id: '7', is_leaf: 'TRUE', parent_id: '192')
    ComplianceLibrary.create(name: 'Implement stateful inspection, also known as dynamic packet filtering. (That is, only ”established” connections are allowed into the network.)', compliance_id: '7', is_leaf: 'TRUE', parent_id: '192')
    ComplianceLibrary.create(name: 'Place system components that store cardholder data (such as a database) in an internal network zone, segregated from the DMZ and other untrusted networks', compliance_id: '7', is_leaf: 'TRUE', parent_id: '192')
    ComplianceLibrary.create(name: 'Do not disclose private IP addresses and routing information to unauthorized parties', compliance_id: '7', is_leaf: 'TRUE', parent_id: '192')
    ComplianceLibrary.create(name: 'Do not use vendor-supplied defaults for system passwords and other security parameters', compliance_id: '7', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Always change vendor-supplied defaults before installing a system on the network—including but not limited to passwords, simple network management protocol ', compliance_id: '7', is_leaf: 'FALSE', parent_id: '201')
    ComplianceLibrary.create(name: 'For wireless environments connected to the cardholder data environment or transmitting cardholder data, change wireless vendor defaults', compliance_id: '7', is_leaf: 'TRUE', parent_id: '202')
    ComplianceLibrary.create(name: 'Develop configuration standards for all system components. ', compliance_id: '7', is_leaf: 'FALSE', parent_id: '201')
    ComplianceLibrary.create(name: 'Implement only one primary function per server to prevent functions that require different security levels from co-existing on the same server. ', compliance_id: '7', is_leaf: 'TRUE', parent_id: '204')
    ComplianceLibrary.create(name: 'Enable only necessary and secure services, protocols, daemons as required for the function of the system.', compliance_id: '7', is_leaf: 'TRUE', parent_id: '204')
    ComplianceLibrary.create(name: 'Configure system security parameters to prevent misuse', compliance_id: '7', is_leaf: 'TRUE', parent_id: '204')
    ComplianceLibrary.create(name: 'Remove all unnecessary functionality, such as scripts, drivers, features, subsystems, file systems, and unnecessary web servers', compliance_id: '7', is_leaf: 'TRUE', parent_id: '204')
    ComplianceLibrary.create(name: 'Encrypt all non-console administrative access using strong cryptography. Use technologies such as SSH, VPN, or SSL/TLS for web-based management and other non-console administrative access', compliance_id: '7', is_leaf: 'FALSE', parent_id: '201')
    ComplianceLibrary.create(name: 'Protect stored cardholder data', compliance_id: '7', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Keep cardholder data storage to a minimum by implementing data retention and disposal policies, procedures and processes as follows', compliance_id: '7', is_leaf: 'FALSE', parent_id: '210')
    ComplianceLibrary.create(name: 'Implement a data retention and disposal policy that includes:', compliance_id: '7', is_leaf: 'TRUE', parent_id: '211')
    ComplianceLibrary.create(name: 'Limiting data storage amount and retention time to that which is required for legal, regulatory, and business requirements', compliance_id: '7', is_leaf: 'TRUE', parent_id: '211')
    ComplianceLibrary.create(name: 'Processes for secure deletion of data when no longer needed', compliance_id: '7', is_leaf: 'TRUE', parent_id: '211')
    ComplianceLibrary.create(name: 'Specific retention requirements for cardholder data', compliance_id: '7', is_leaf: 'TRUE', parent_id: '211')
    ComplianceLibrary.create(name: 'A quarterly automatic or manual process for identifying and securely deleting stored cardholder data that exceeds defined retention requirements', compliance_id: '7', is_leaf: 'TRUE', parent_id: '211')
    ComplianceLibrary.create(name: 'Do not store sensitive authentication data after authorization ', compliance_id: '7', is_leaf: 'FALSE', parent_id: '210')
    ComplianceLibrary.create(name: 'Do not store the full contents of any track from the magnetic stripe. ', compliance_id: '7', is_leaf: 'TRUE', parent_id: '217')
    ComplianceLibrary.create(name: 'Do not store the card-verification code or value (three-digit or four-digit number printed on the front or back of a payment card) used to verify card-not-present transactions', compliance_id: '7', is_leaf: 'TRUE', parent_id: '217')
    ComplianceLibrary.create(name: 'Do not store the personal identification number (PIN) or the encrypted PIN block', compliance_id: '7', is_leaf: 'TRUE', parent_id: '217')
    ComplianceLibrary.create(name: 'Render PAN unreadable anywhere it is stored (including on portable digital media, backup media, and in logs)', compliance_id: '7', is_leaf: 'FALSE', parent_id: '210')
    ComplianceLibrary.create(name: 'If disk encryption is used (rather than file- or column-level database encryption), logical access must be managed independently of native operating system access control', compliance_id: '7', is_leaf: 'TRUE', parent_id: '221')
    ComplianceLibrary.create(name: 'Protect any keys used to secure cardholder data against both disclosure and misuse', compliance_id: '7', is_leaf: 'FALSE', parent_id: '210')
    ComplianceLibrary.create(name: 'Restrict access to cryptographic keys to the fewest number of custodians necessary', compliance_id: '7', is_leaf: 'TRUE', parent_id: '223')
    ComplianceLibrary.create(name: 'Store cryptographic keys securely in the fewest possible locations and forms', compliance_id: '7', is_leaf: 'TRUE', parent_id: '223')
    ComplianceLibrary.create(name: 'Fully document and implement all key management processes and procedures for cryptographic keys used for encryption of cardholder data', compliance_id: '7', is_leaf: 'FALSE', parent_id: '210')
    ComplianceLibrary.create(name: 'Generation of strong cryptographic keys', compliance_id: '7', is_leaf: 'TRUE', parent_id: '226')
    ComplianceLibrary.create(name: 'Secure cryptographic key distribution', compliance_id: '7', is_leaf: 'TRUE', parent_id: '226')
    ComplianceLibrary.create(name: 'Secure cryptographic key storage', compliance_id: '7', is_leaf: 'TRUE', parent_id: '226')
    ComplianceLibrary.create(name: 'Cryptographic key changes for keys that have reached the end of their cryptoperiod as defined by the associated application vendor or key owner, and based on industry best practices and guidelines', compliance_id: '7', is_leaf: 'TRUE', parent_id: '226')
    ComplianceLibrary.create(name: 'Retirement or replacement  of keys as deemed necessary when the integrity of the key has been weakened , or keys are suspected of being compromised', compliance_id: '7', is_leaf: 'TRUE', parent_id: '226')
    ComplianceLibrary.create(name: 'If manual clear-text cryptographic key management operations are used, these operations must be managed using split knowledge and dual control', compliance_id: '7', is_leaf: 'TRUE', parent_id: '226')
    ComplianceLibrary.create(name: 'Prevention of unauthorized substitution of cryptographic keys', compliance_id: '7', is_leaf: 'TRUE', parent_id: '226')
    ComplianceLibrary.create(name: 'Requirement for cryptographic key custodians to formally acknowledge that they understand and accept their key-custodian responsibilities', compliance_id: '7', is_leaf: 'TRUE', parent_id: '226')
    ComplianceLibrary.create(name: 'Encrypt transmission of cardholder data across open, public networks', compliance_id: '7', is_leaf: 'FALSE', parent_id: '210')
    ComplianceLibrary.create(name: 'Use strong cryptography and security protocols (for example, SSL/TLS, IPSEC, SSH, etc.) to safeguard sensitive cardholder data during transmission over open, public networks. ', compliance_id: '7', is_leaf: 'FALSE', parent_id: '235')
    ComplianceLibrary.create(name: 'Ensure wireless networks transmitting cardholder data or connected to the cardholder data environment,  use industry best practices ( e.g., IEEE 802.11i) to implement strong encryption for authentication and transmission', compliance_id: '7', is_leaf: 'TRUE', parent_id: '236')
    ComplianceLibrary.create(name: 'Use and regularly update anti-virus software or programs', compliance_id: '7', is_leaf: 'FALSE', parent_id: 'NULL')
    ComplianceLibrary.create(name: 'Deploy anti-virus software on all systems commonly affected by malicious software (particularly personal computers and servers).', compliance_id: '7', is_leaf: 'FALSE', parent_id: '237')
    ComplianceLibrary.create(name: 'Ensure that all anti-virus programs are capable of detecting, removing, and protecting against all known types of malicious software', compliance_id: '7', is_leaf: 'TRUE', parent_id: '238')

Artifact.delete_all

    Artifact.create(name: 'Information Security Policies?', compliance_library_id: '3', company_id: '1')
    Artifact.create(name: 'Infosec SPOC for the project present?', compliance_library_id: '4', company_id: '1')
    Artifact.create(name: 'Infosec SPOC knowledge on specific client security requirements', compliance_library_id: '5', company_id: '1')
    Artifact.create(name: 'Confidentiality agreements with employees(Client specific also if any)', compliance_library_id: '7', company_id: '1')
    Artifact.create(name: 'Has client access been given to MphasiS network and resources. If yes then check if approvals and security considerations have been taken?', compliance_library_id: '13', company_id: '1')
    Artifact.create(name: 'Access control policy to customers for accessing MphasiS network', compliance_library_id: '13', company_id: '1')
    Artifact.create(name: 'Authorization process for client access', compliance_library_id: '13', company_id: '1')
    Artifact.create(name: 'Revoking process', compliance_library_id: '13', company_id: '1')
    Artifact.create(name: 'Type and acceptable levels of service provided to the client', compliance_library_id: '13', company_id: '1')
    Artifact.create(name: 'Third parties associated with the ODC for project requirements (Outsourced software, trainers,etc.,)', compliance_library_id: '14', company_id: '1')
    Artifact.create(name: 'Confidentiality agreements with the Third party', compliance_library_id: '14', company_id: '1')
    Artifact.create(name: 'Asset Management Process', compliance_library_id: '17', company_id: '1')
    Artifact.create(name: 'Inventory of assets', compliance_library_id: '17', company_id: '1')
    Artifact.create(name: 'Check for Asset Owners for different assets', compliance_library_id: '18', company_id: '1')
    Artifact.create(name: 'Refer to Acceptable use Standard', compliance_library_id: '19', company_id: '1')
    Artifact.create(name: 'Asset Classification Policy/Standard/Procedure present?', compliance_library_id: '21', company_id: '1')
    Artifact.create(name: 'Are the Assets Classified/Labelled?', compliance_library_id: '22', company_id: '1')
    Artifact.create(name: 'Security Roles & Resp for all employees', compliance_library_id: '25', company_id: '1')
    Artifact.create(name: 'Background screening of all employees', compliance_library_id: '26', company_id: '1')
    Artifact.create(name: 'Additional client requirements on employee pre-employment screening', compliance_library_id: '26', company_id: '1')
    Artifact.create(name: 'Code of conduct agreement', compliance_library_id: '27', company_id: '1')
    Artifact.create(name: 'Work from home option for employees', compliance_library_id: '27', company_id: '1')
    Artifact.create(name: 'User awareness training on Information security', compliance_library_id: '30', company_id: '1')
    Artifact.create(name: 'Information awareness pin ups in all cubicles', compliance_library_id: '30', company_id: '1')
    Artifact.create(name: 'Termination process of employee', compliance_library_id: '31', company_id: '1')
    Artifact.create(name: 'Removal process of Client ID, ODC AD ID, Physical access', compliance_library_id: '31', company_id: '1')
    Artifact.create(name: 'Termination process of employee', compliance_library_id: '33', company_id: '1')
    Artifact.create(name: 'Removal process of Client ID, ODC AD ID, Physical access', compliance_library_id: '33', company_id: '1')
    Artifact.create(name: 'Asset Inventory Database', compliance_library_id: '34', company_id: '1')
    Artifact.create(name: 'AD Server/Network Devices/EDS Network access rights.', compliance_library_id: '35', company_id: '1')
    Artifact.create(name: 'Physical access control to ODC', compliance_library_id: '39', company_id: '1')
    Artifact.create(name: 'Review of access control of authorized employee to the ODC', compliance_library_id: '39', company_id: '1')
    Artifact.create(name: 'Review of access control policy violation incidents', compliance_library_id: '39', company_id: '1')
    Artifact.create(name: 'Visitors register should be available for both the ODC and the secure rooms', compliance_library_id: '39', company_id: '1')
    Artifact.create(name: 'Check Access control for Secure rooms where critical devices are maintained', compliance_library_id: '40', company_id: '1')
    Artifact.create(name: 'Review Access rights to secure rooms. Also check if this is regularly reviewed', compliance_library_id: '40', company_id: '1')
    Artifact.create(name: 'Check if Fire extinguishers inside are at prominent places', compliance_library_id: '41', company_id: '1')
    Artifact.create(name: 'Emergency exists and proper display of Emergency exit boards with alarms', compliance_library_id: '41', company_id: '1')
    Artifact.create(name: 'No recording device should be allowed inside the ODC( Cameras, camera mobiles) ', compliance_library_id: '42', company_id: '1')
    Artifact.create(name: 'CCTV for entry/exit and secure room doors', compliance_library_id: '42', company_id: '1')
    Artifact.create(name: 'Public loading/delivery areas', compliance_library_id: '43', company_id: '1')
    Artifact.create(name: 'Critical Devices to be in secured rooms', compliance_library_id: '45', company_id: '1')
    Artifact.create(name: 'Fire/smoke detectors and alarms', compliance_library_id: '45', company_id: '1')
    Artifact.create(name: 'Temperature and humidity should be monitored for the secure rooms', compliance_library_id: '45', company_id: '1')
    Artifact.create(name: 'Operating Procedures of ODC devices(Hardening Documents)', compliance_library_id: '54', company_id: '1')
    Artifact.create(name: 'Change Management procedure', compliance_library_id: '55', company_id: '1')
    Artifact.create(name: 'Segregated VLANs for Test/Develpoment/Operational Environments', compliance_library_id: '57', company_id: '1')
    Artifact.create(name: 'Monitoring & review of third party services', compliance_library_id: '60', company_id: '1')
    Artifact.create(name: 'Managing changes to third party services', compliance_library_id: '61', company_id: '1')
    Artifact.create(name: 'Total employees in ODC-Capacity Mgmt', compliance_library_id: '63', company_id: '1')
    Artifact.create(name: 'Details on the number of employees joined and left the ODC', compliance_library_id: '63', company_id: '1')
    Artifact.create(name: 'Server resource capacity mgmt', compliance_library_id: '63', company_id: '1')
    Artifact.create(name: 'Anti-Virus Process', compliance_library_id: '66', company_id: '1')
    Artifact.create(name: 'Antivirus Server', compliance_library_id: '66', company_id: '1')
    Artifact.create(name: 'Antivirus Updations on PCs & Servers', compliance_library_id: '66', company_id: '1')
    Artifact.create(name: 'Unwanted softwares(Freeware)', compliance_library_id: '66', company_id: '1')
    Artifact.create(name: 'USB/CD/Floppy Drives', compliance_library_id: '67', company_id: '1')
    Artifact.create(name: 'Check for the Backup Procedures', compliance_library_id: '69', company_id: '1')
    Artifact.create(name: 'Check if the Onsite & Offsite Backups are taken', compliance_library_id: '69', company_id: '1')
    Artifact.create(name: 'Router hardening & Configuration', compliance_library_id: '72', company_id: '1')
    Artifact.create(name: 'Switch hardening & configuration', compliance_library_id: '72', company_id: '1')
    Artifact.create(name: 'Firewall hardening & configuration', compliance_library_id: '72', company_id: '1')
    Artifact.create(name: 'Media Copy/Destruction', compliance_library_id: '74', company_id: '1')
    Artifact.create(name: 'Secure disposal of media', compliance_library_id: '75', company_id: '1')
    Artifact.create(name: 'Media Classification', compliance_library_id: '76', company_id: '1')
    Artifact.create(name: 'Security of system documentation', compliance_library_id: '77', company_id: '1')
    Artifact.create(name: 'Information exchange procedure (Email,physical media)', compliance_library_id: '79', company_id: '1')
    Artifact.create(name: 'Event logs should be backed up', compliance_library_id: '92', company_id: '1')
    Artifact.create(name: 'Track IT, JIRA requests', compliance_library_id: '93', company_id: '1')
    Artifact.create(name: 'Clock Synchronisation (NTP)', compliance_library_id: '94', company_id: '1')
    Artifact.create(name: 'User ID Creation/Deletion Process', compliance_library_id: '99', company_id: '1')
    Artifact.create(name: 'Privilege Access Forms (PAFs)', compliance_library_id: '100', company_id: '1')
    Artifact.create(name: 'User password management', compliance_library_id: '101', company_id: '1')
    Artifact.create(name: 'Review of user access rights', compliance_library_id: '102', company_id: '1')
    Artifact.create(name: 'Policy on use of Internet services', compliance_library_id: '108', company_id: '1')
    Artifact.create(name: 'Network Diagram of Site', compliance_library_id: '110', company_id: '1')
    Artifact.create(name: 'Segregation of Networks', compliance_library_id: '112', company_id: '1')
    Artifact.create(name: 'Usage of Generic user IDs', compliance_library_id: '117', company_id: '1')
    Artifact.create(name: 'Use of system utilities', compliance_library_id: '119', company_id: '1')
    Artifact.create(name: 'Software Management System (SMS)', compliance_library_id: '119', company_id: '1')
    Artifact.create(name: 'Session time-out', compliance_library_id: '120', company_id: '1')
    Artifact.create(name: 'User level restriction for accessing of critical devices', compliance_library_id: '123', company_id: '1')
    Artifact.create(name: 'Sensitive system isolation (Firesafe) ', compliance_library_id: '124', company_id: '1')
    Artifact.create(name: 'Firesafe inventory register ', compliance_library_id: '124', company_id: '1')
    Artifact.create(name: 'Firesafe asset movement register', compliance_library_id: '124', company_id: '1')
    Artifact.create(name: 'Firesafe key register', compliance_library_id: '124', company_id: '1')
    Artifact.create(name: 'Wireless LAN Communications', compliance_library_id: '126', company_id: '1')
    Artifact.create(name: 'Control of Operational Software', compliance_library_id: '140', company_id: '1')
    Artifact.create(name: 'Patch Management (WSUS Reports)', compliance_library_id: '150', company_id: '1')
    Artifact.create(name: 'VA Scan for site', compliance_library_id: '150', company_id: '1')
    Artifact.create(name: 'Information Security Incident (Tech)', compliance_library_id: '153', company_id: '1')
    Artifact.create(name: 'Incident reporting procedure', compliance_library_id: '153', company_id: '1')
    Artifact.create(name: 'Collection of Evidence', compliance_library_id: '158', company_id: '1')

Modular.delete_all

  Modular.create(model_name: 'ArtifactAnswer', action_name: 'update', section_id: '1', label:"Authorize to submit Artifacts")
  Modular.create(model_name: 'AuditCompliance', action_name: 'update', section_id: '1', label:"Authorize to update Compliance Checklist")
  Modular.create(model_name: 'AuditCompliance', action_name: 'create',section_id: '1', label:"Authorize to prepare Compliance Checklist")
  Modular.create(model_name: 'Audit', action_name: 'new', section_id: '1', label:"Authorize to Plan Audit")
  Modular.create(model_name: 'Audit', action_name: 'edit', section_id: '1', label:"Authorize to edit Audit")
  Modular.create(model_name: 'Audit', action_name: 'create', section_id: '1', label:"Authorize to Create Audit")
  Modular.create(model_name: 'Audit', action_name: 'update', section_id: '1', label:"Authorize to update Audit")
  Modular.create(model_name: 'ChecklistRecommendation', action_name: 'new', section_id: '1', label:"Authorize to give Recommendation")
  Modular.create(model_name: 'ChecklistRecommendation', action_name: 'create', section_id: '1', label:"Authorize to create Recommendation")
  Modular.create(model_name: 'ChecklistRecommendation', action_name: 'update', section_id: '1', label:"Authorize to update recommendation")
  Modular.create(model_name: 'ChecklistRecommendation', action_name: 'auditee_response', section_id: '1', label: "Authorize to give Response")
  Modular.create(model_name: 'ChecklistRecommendation', action_name: 'auditee_response_create', section_id: '1', label: "Authorize to create Response")
  Modular.create(model_name: 'ChecklistRecommendation', action_name: 'audit_observation', section_id: '1', label: "Authorize to give final observation")
  Modular.create(model_name: 'ChecklistRecommendation', action_name: 'audit_observation_create', section_id: '1', label: "Authorize to create final observation")
  Modular.create(model_name: 'NcQuestion', action_name: 'new', section_id: '1', label:"Authorize to prepare NC Checklist")
  Modular.create(model_name: 'NcQuestion', action_name: 'create', section_id: '1', label:"Authorize to create NC Checklist")
  Modular.create(model_name: 'NcQuestion', action_name: 'update', section_id: '1', label:"Authorize to update NC checklist")
  Modular.create(model_name: 'Answer', action_name: 'new', section_id: '1', label: "Authorize to submit Answers")
  Modular.create(model_name: 'Answer', action_name: 'create', section_id: '1', label: "Authorize to create Answers")
  Modular.create(model_name: 'Answer', action_name: 'update', section_id: '1', label:"Authorize to update Answer")
  Modular.create(model_name: 'Risk', action_name: 'create', section_id: '2', label: "Authorise to file Risk")
  Modular.create(model_name: 'Risk', action_name: 'update', section_id: '2', label: "Authorise to Update risk")
  Modular.create(model_name: 'Risk', action_name: 'edit', section_id: '2', label: "Authorise to Edit risk")
  Modular.create(model_name: 'MgmtReview', action_name: 'new', section_id: '2', label: "Authorise to Review the Risk")
  Modular.create(model_name: 'MgmtReview', action_name: 'create', section_id: '2', label: "Authorise to create the Risk")
  Modular.create(model_name: 'MgmtReview', action_name: 'edit', section_id: '2', label:"Authorise to edit the Review of Risk")
  Modular.create(model_name: 'MgmtReview', action_name: 'update', section_id: '2', label: "Authorise to Update the Review of Risk")
  Modular.create(model_name: 'Mitigation', action_name: 'new', section_id: '2', label:"Authorise to Mitigate the risk")
  Modular.create(model_name: 'Mitigation', action_name: 'create', section_id: '2', label: "Authorise to create Mitigation")
  Modular.create(model_name: 'Mitigation', action_name: 'edit', section_id: '2', label: "Authorise to edit the Mitigation efforts")
  Modular.create(model_name: 'Mitigation', action_name: 'update', section_id: '2', label:"Authorise to update the Mitigation efforts")

# INCIDENT MANAGEMENT

IncidentCategory.delete_all
    IncidentCategory.create(:name => "Desktop Hardware")
    IncidentCategory.create(:name => "Internet")
    IncidentCategory.create(:name => "Network")
    IncidentCategory.create(:name => "Operating System")
    IncidentCategory.create(:name => "Printers")
    IncidentCategory.create(:name => "Routers")
    IncidentCategory.create(:name => "Switches")
    IncidentCategory.create(:name => "Telephone")

CloseEvaluation.delete_all
    CloseEvaluation.create(:name => "Great")
    CloseEvaluation.create(:name => "Good")
    CloseEvaluation.create(:name => "Bad")
    CloseEvaluation.create(:name => "regular")

CloseStatus.delete_all
    CloseStatus.create(:name => "Problem Solved")
    CloseStatus.create(:name => "Problem not Solved")

IncidentPriority.delete_all
    IncidentPriority.create(:name => "High")
    IncidentPriority.create(:name => "Medium")
    IncidentPriority.create(:name => "Low")

IncidentStatus.delete_all
    IncidentStatus.create(:name => "New")
    IncidentStatus.create(:name => "Draft")
    IncidentStatus.create(:name => "In-Progress")
    IncidentStatus.create(:name => "Resolved")
    IncidentStatus.create(:name => "Closed")


ClosureClassification.delete_all
    ClosureClassification.create(:name => "Advise Given")
    ClosureClassification.create(:name => "Change Request need to be raised")
    ClosureClassification.create(:name => "Documentation needs reviewing")
    ClosureClassification.create(:name => "Incident Completed Successfully")
    ClosureClassification.create(:name => "Monitoring Required")
    ClosureClassification.create(:name => "No Fault Found")


IncidentOrigin.delete_all
    IncidentOrigin.create(:name => "Phone")
    IncidentOrigin.create(:name => "Web")
    IncidentOrigin.create(:name => "email")

RequestType.delete_all
    RequestType.create(:name => "Incident")
    RequestType.create(:name => "Information Request")
    RequestType.create(:name => "Service Request")


Urgency.delete_all
    Urgency.create(:name => "High")
    Urgency.create(:name => "Medium")
    Urgency.create(:name => "Low")
    Urgency.create(:name => "Urgent")




CloseReason.delete_all
    CloseReason.create(:name => "Fully Mitigated")
    CloseReason.create(:name => "System Retired")
    CloseReason.create(:name => "Cancelled")
    CloseReason.create(:name => "Too Insignificant")

PlanningStrategy.delete_all
    PlanningStrategy.create(:name => "Research")
    PlanningStrategy.create(:name => "Accept")
    PlanningStrategy.create(:name => "Mitigate")
    PlanningStrategy.create(:name => "Watch")

RiskApprovalStatus.delete_all
    RiskApprovalStatus.create(:name => "Not Approved")
    RiskApprovalStatus.create(:name => "Approved")
    RiskApprovalStatus.create(:name => "Request for Rephrase")

Review.delete_all
    Review.create(:name => "Approve Risk")
    Review.create(:name => "Reject Risk")

NextStep.delete_all
    NextStep.create(:name => "Accept Until Next Review")
    NextStep.create(:name => "Submit as a Production Issue")
    NextStep.create(:name => "Consider for Audit")

ImplementationStatus.delete_all
    ImplementationStatus.create(:name => "Not Implemented")
    ImplementationStatus.create(:name => "Partially Implemented")
    ImplementationStatus.create(:name => "Fully Implemented")
    ImplementationStatus.create(:name => "Not Applicable")

Language.delete_all

    Language.create(name: 'English', code: 'en')
    Language.create(name: 'French', code: 'fr')

Country.delete_all

        Country.create( :name => 'Afghanistan', :iso_two_letter_code => 'AF' )
        Country.create( :name => 'Aland Islands', :iso_two_letter_code => 'AX' )
        Country.create( :name => 'Albania', :iso_two_letter_code => 'AL' )
        Country.create( :name => 'Algeria', :iso_two_letter_code => 'DZ' )
        Country.create( :name => 'American Samoa', :iso_two_letter_code => 'AS' )
        Country.create( :name => 'Andorra', :iso_two_letter_code => 'AD' )
        Country.create( :name => 'Angola', :iso_two_letter_code => 'AO' )
        Country.create( :name => 'Anguilla', :iso_two_letter_code => 'AI' )
        Country.create( :name => 'Antarctica', :iso_two_letter_code => 'AQ' )
        Country.create( :name => 'Antigua And Barbuda', :iso_two_letter_code => 'AG' )
        Country.create( :name => 'Argentina', :iso_two_letter_code => 'AR' )
        Country.create( :name => 'Armenia', :iso_two_letter_code => 'AM' )
        Country.create( :name => 'Aruba', :iso_two_letter_code => 'AW' )
        Country.create( :name => 'Australia', :iso_two_letter_code => 'AU' )
        Country.create( :name => 'Austria', :iso_two_letter_code => 'AT' )
        Country.create( :name => 'Azerbaijan', :iso_two_letter_code => 'AZ' )
        Country.create( :name => 'Bahamas', :iso_two_letter_code => 'BS' )
        Country.create( :name => 'Bahrain', :iso_two_letter_code => 'BH' )
        Country.create( :name => 'Bangladesh', :iso_two_letter_code => 'BD' )
        Country.create( :name => 'Barbados', :iso_two_letter_code => 'BB' )
        Country.create( :name => 'Belarus', :iso_two_letter_code => 'BY' )
        Country.create( :name => 'Belgium', :iso_two_letter_code => 'BE' )
        Country.create( :name => 'Belize', :iso_two_letter_code => 'BZ' )
        Country.create( :name => 'Benin', :iso_two_letter_code => 'BJ' )
        Country.create( :name => 'Bermuda', :iso_two_letter_code => 'BM' )
        Country.create( :name => 'Bhutan', :iso_two_letter_code => 'BT' )
        Country.create( :name => 'Bolivia', :iso_two_letter_code => 'BO' )
        Country.create( :name => 'Bosnia and Herzegovina', :iso_two_letter_code => 'BA' )
        Country.create( :name => 'Botswana', :iso_two_letter_code => 'BW' )
        Country.create( :name => 'Bouvet Island', :iso_two_letter_code => 'BV' )
        Country.create( :name => 'Brazil', :iso_two_letter_code => 'BR' )
        Country.create( :name => 'British Indian Ocean Territory', :iso_two_letter_code => 'IO' )
        Country.create( :name => 'Brunei Darussalam', :iso_two_letter_code => 'BN' )
        Country.create( :name => 'Bulgaria', :iso_two_letter_code => 'BG' )
        Country.create( :name => 'Burkina Faso', :iso_two_letter_code => 'BF' )
        Country.create( :name => 'Burundi', :iso_two_letter_code => 'BI' )
        Country.create( :name => 'Cambodia', :iso_two_letter_code => 'KH' )
        Country.create( :name => 'Cameroon', :iso_two_letter_code => 'CM' )
        Country.create( :name => 'Canada', :iso_two_letter_code => 'CA' )
        Country.create( :name => 'Cape Verde', :iso_two_letter_code => 'CV' )
        Country.create( :name => 'Cayman Islands', :iso_two_letter_code => 'KY' )
        Country.create( :name => 'Central African Republic', :iso_two_letter_code => 'CF' )
        Country.create( :name => 'Chad', :iso_two_letter_code => 'TD' )
        Country.create( :name => 'Chile', :iso_two_letter_code => 'CL' )
        Country.create( :name => 'China', :iso_two_letter_code => 'CN' )
        Country.create( :name => 'Christmas Island', :iso_two_letter_code => 'CX' )
        Country.create( :name => 'Cocos (Keeling) Islands', :iso_two_letter_code => 'CC' )
        Country.create( :name => 'Colombia', :iso_two_letter_code => 'CO' )
        Country.create( :name => 'Comoros', :iso_two_letter_code => 'KM' )
        Country.create( :name => 'Congo', :iso_two_letter_code => 'CG' )
        Country.create( :name => 'Congo (DRC)', :iso_two_letter_code => 'CD' )
        Country.create( :name => 'Cook Islands', :iso_two_letter_code => 'CK' )
        Country.create( :name => 'Costa Rica', :iso_two_letter_code => 'CR' )
        Country.create( :name => 'Cote d\'Ivoire', :iso_two_letter_code => 'CI' )
        Country.create( :name => 'Croatia', :iso_two_letter_code => 'HR' )
        Country.create( :name => 'Cuba', :iso_two_letter_code => 'CU' )
        Country.create( :name => 'Cyprus', :iso_two_letter_code => 'CY' )
        Country.create( :name => 'Czech Republic', :iso_two_letter_code => 'CZ' )
        Country.create( :name => 'Denmark', :iso_two_letter_code => 'DK' )
        Country.create( :name => 'Djibouti', :iso_two_letter_code => 'DJ' )
        Country.create( :name => 'Dominica', :iso_two_letter_code => 'DM' )
        Country.create( :name => 'Dominican Republic', :iso_two_letter_code => 'DO' )
        Country.create( :name => 'Ecuador', :iso_two_letter_code => 'EC' )
        Country.create( :name => 'Egypt', :iso_two_letter_code => 'EG' )
        Country.create( :name => 'El Salvador', :iso_two_letter_code => 'SV' )
        Country.create( :name => 'Equatorial Guinea', :iso_two_letter_code => 'GQ' )
        Country.create( :name => 'Eritrea', :iso_two_letter_code => 'ER' )
        Country.create( :name => 'Estonia', :iso_two_letter_code => 'EE' )
        Country.create( :name => 'Ethiopia', :iso_two_letter_code => 'ET' )
        Country.create( :name => 'Falkland Islands', :iso_two_letter_code => 'FK' )
        Country.create( :name => 'Faroe Islands', :iso_two_letter_code => 'FO' )
        Country.create( :name => 'Fiji', :iso_two_letter_code => 'FJ' )
        Country.create( :name => 'Finland', :iso_two_letter_code => 'FI' )
        Country.create( :name => 'France', :iso_two_letter_code => 'FR' )
        Country.create( :name => 'French Guiana', :iso_two_letter_code => 'GF' )
        Country.create( :name => 'French Polynesia', :iso_two_letter_code => 'PF' )
        Country.create( :name => 'French Southern Territories', :iso_two_letter_code => 'TF' )
        Country.create( :name => 'Gabon', :iso_two_letter_code => 'GA' )
        Country.create( :name => 'Gambia', :iso_two_letter_code => 'GM' )
        Country.create( :name => 'Georgia', :iso_two_letter_code => 'GE' )
        Country.create( :name => 'Germany', :iso_two_letter_code => 'DE' )
        Country.create( :name => 'Ghana', :iso_two_letter_code => 'GH' )
        Country.create( :name => 'Gibraltar', :iso_two_letter_code => 'GI' )
        Country.create( :name => 'Greece', :iso_two_letter_code => 'GR' )
        Country.create( :name => 'Greenland', :iso_two_letter_code => 'GL' )
        Country.create( :name => 'Grenada', :iso_two_letter_code => 'GD' )
        Country.create( :name => 'Guadeloupe', :iso_two_letter_code => 'GP' )
        Country.create( :name => 'Guam', :iso_two_letter_code => 'GU' )
        Country.create( :name => 'Guatemala', :iso_two_letter_code => 'GT' )
        Country.create( :name => 'Guernsey', :iso_two_letter_code => 'GG' )
        Country.create( :name => 'Guinea', :iso_two_letter_code => 'GN' )
        Country.create( :name => 'Guinea-Bissau', :iso_two_letter_code => 'GW' )
        Country.create( :name => 'Guyana', :iso_two_letter_code => 'GY' )
        Country.create( :name => 'Haiti', :iso_two_letter_code => 'HT' )
        Country.create( :name => 'Heard and McDonald Islands', :iso_two_letter_code => 'HM' )
        Country.create( :name => 'Holy See (Vatican City State)', :iso_two_letter_code => 'VA' )
        Country.create( :name => 'Honduras', :iso_two_letter_code => 'HN' )
        Country.create( :name => 'Hong Kong', :iso_two_letter_code => 'HK' )
        Country.create( :name => 'Hungary', :iso_two_letter_code => 'HU' )
        Country.create( :name => 'Iceland', :iso_two_letter_code => 'IS' )
        Country.create( :name => 'India', :iso_two_letter_code => 'IN' )
        Country.create( :name => 'Indonesia', :iso_two_letter_code => 'ID' )
        Country.create( :name => 'Iran', :iso_two_letter_code => 'IR' )
        Country.create( :name => 'Iraq', :iso_two_letter_code => 'IQ' )
        Country.create( :name => 'Ireland', :iso_two_letter_code => 'IE' )
        Country.create( :name => 'Isle of Man', :iso_two_letter_code => 'IM' )
        Country.create( :name => 'Israel', :iso_two_letter_code => 'IL' )
        Country.create( :name => 'Italy', :iso_two_letter_code => 'IT' )
        Country.create( :name => 'Jamaica', :iso_two_letter_code => 'JM' )
        Country.create( :name => 'Japan', :iso_two_letter_code => 'JP' )
        Country.create( :name => 'Jersey', :iso_two_letter_code => 'JE' )
        Country.create( :name => 'Jordan', :iso_two_letter_code => 'JO' )
        Country.create( :name => 'Kazakhstan', :iso_two_letter_code => 'KZ' )
        Country.create( :name => 'Kenya', :iso_two_letter_code => 'KE' )
        Country.create( :name => 'Kiribati', :iso_two_letter_code => 'KI' )
        Country.create( :name => 'North Korea', :iso_two_letter_code => 'KP' )
        Country.create( :name => 'South Korea', :iso_two_letter_code => 'KR' )
        Country.create( :name => 'Kuwait', :iso_two_letter_code => 'KW' )
        Country.create( :name => 'Kyrgyzstan', :iso_two_letter_code => 'KG' )
        Country.create( :name => 'Laos', :iso_two_letter_code => 'LA' )
        Country.create( :name => 'Latvia', :iso_two_letter_code => 'LV' )
        Country.create( :name => 'Lebanon', :iso_two_letter_code => 'LB' )
        Country.create( :name => 'Lesotho', :iso_two_letter_code => 'LS' )
        Country.create( :name => 'Liberia', :iso_two_letter_code => 'LR' )
        Country.create( :name => 'Libya', :iso_two_letter_code => 'LY' )
        Country.create( :name => 'Liechtenstein', :iso_two_letter_code => 'LI' )
        Country.create( :name => 'Lithuania', :iso_two_letter_code => 'LT' )
        Country.create( :name => 'Luxembourg', :iso_two_letter_code => 'LU' )
        Country.create( :name => 'Macao', :iso_two_letter_code => 'MO' )
        Country.create( :name => 'Macedonia', :iso_two_letter_code => 'MK' )
        Country.create( :name => 'Madagascar', :iso_two_letter_code => 'MG' )
        Country.create( :name => 'Malawi', :iso_two_letter_code => 'MW' )
        Country.create( :name => 'Malaysia', :iso_two_letter_code => 'MY' )
        Country.create( :name => 'Maldives', :iso_two_letter_code => 'MV' )
        Country.create( :name => 'Mali', :iso_two_letter_code => 'ML' )
        Country.create( :name => 'Malta', :iso_two_letter_code => 'MT' )
        Country.create( :name => 'Marshall Islands', :iso_two_letter_code => 'MH' )
        Country.create( :name => 'Martinique', :iso_two_letter_code => 'MQ' )
        Country.create( :name => 'Mauritania', :iso_two_letter_code => 'MR' )
        Country.create( :name => 'Mauritius', :iso_two_letter_code => 'MU' )
        Country.create( :name => 'Mayotte', :iso_two_letter_code => 'YT' )
        Country.create( :name => 'Mexico', :iso_two_letter_code => 'MX' )
        Country.create( :name => 'Micronesia', :iso_two_letter_code => 'FM' )
        Country.create( :name => 'Moldova', :iso_two_letter_code => 'MD' )
        Country.create( :name => 'Monaco', :iso_two_letter_code => 'MC' )
        Country.create( :name => 'Mongolia', :iso_two_letter_code => 'MN' )
        Country.create( :name => 'Montenegro', :iso_two_letter_code => 'ME' )
        Country.create( :name => 'Montserrat', :iso_two_letter_code => 'MS' )
        Country.create( :name => 'Morocco', :iso_two_letter_code => 'MA' )
        Country.create( :name => 'Mozambique', :iso_two_letter_code => 'MZ' )
        Country.create( :name => 'Myanmar', :iso_two_letter_code => 'MM' )
        Country.create( :name => 'Namibia', :iso_two_letter_code => 'NA' )
        Country.create( :name => 'Nauru', :iso_two_letter_code => 'NR' )
        Country.create( :name => 'Nepal', :iso_two_letter_code => 'NP' )
        Country.create( :name => 'Netherlands', :iso_two_letter_code => 'NL' )
        Country.create( :name => 'Netherlands Antilles', :iso_two_letter_code => 'AN' )
        Country.create( :name => 'New Caledonia', :iso_two_letter_code => 'NC' )
        Country.create( :name => 'New Zealand', :iso_two_letter_code => 'NZ' )
        Country.create( :name => 'Nicaragua', :iso_two_letter_code => 'NI' )
        Country.create( :name => 'Niger', :iso_two_letter_code => 'NE' )
        Country.create( :name => 'Nigeria', :iso_two_letter_code => 'NG' )
        Country.create( :name => 'Niue', :iso_two_letter_code => 'NU' )
        Country.create( :name => 'Norfolk Island', :iso_two_letter_code => 'NF' )
        Country.create( :name => 'Northern Mariana Islands', :iso_two_letter_code => 'MP' )
        Country.create( :name => 'Norway', :iso_two_letter_code => 'NO' )
        Country.create( :name => 'Oman', :iso_two_letter_code => 'OM' )
        Country.create( :name => 'Pakistan', :iso_two_letter_code => 'PK' )
        Country.create( :name => 'Palau', :iso_two_letter_code => 'PW' )
        Country.create( :name => 'Palestinian Territory', :iso_two_letter_code => 'PS' )
        Country.create( :name => 'Panama', :iso_two_letter_code => 'PA' )
        Country.create( :name => 'Papua New Guinea', :iso_two_letter_code => 'PG' )
        Country.create( :name => 'Paraguay', :iso_two_letter_code => 'PY' )
        Country.create( :name => 'Peru', :iso_two_letter_code => 'PE' )
        Country.create( :name => 'Philippines', :iso_two_letter_code => 'PH' )
        Country.create( :name => 'Pitcairn', :iso_two_letter_code => 'PN' )
        Country.create( :name => 'Poland', :iso_two_letter_code => 'PL' )
        Country.create( :name => 'Portugal', :iso_two_letter_code => 'PT' )
        Country.create( :name => 'Puerto Rico', :iso_two_letter_code => 'PR' )
        Country.create( :name => 'Qatar', :iso_two_letter_code => 'QA' )
        Country.create( :name => 'Reunion', :iso_two_letter_code => 'RE' )
        Country.create( :name => 'Romania', :iso_two_letter_code => 'RO' )
        Country.create( :name => 'Russia', :iso_two_letter_code => 'RU' )
        Country.create( :name => 'Rwanda', :iso_two_letter_code => 'RW' )
        Country.create( :name => 'Saint Barthelemy', :iso_two_letter_code => 'BL' )
        Country.create( :name => 'Saint Helena', :iso_two_letter_code => 'SH' )
        Country.create( :name => 'Saint Kitts and Nevis', :iso_two_letter_code => 'KN' )
        Country.create( :name => 'Saint Lucia', :iso_two_letter_code => 'LC' )
        Country.create( :name => 'Saint Pierre and Miquelon', :iso_two_letter_code => 'PM' )
        Country.create( :name => 'Saint Vincent and the Grenadines', :iso_two_letter_code => 'VC' )
        Country.create( :name => 'Samoa', :iso_two_letter_code => 'WS' )
        Country.create( :name => 'San Marino', :iso_two_letter_code => 'SM' )
        Country.create( :name => 'Sao Tome and Principe', :iso_two_letter_code => 'ST' )
        Country.create( :name => 'Saudi Arabia', :iso_two_letter_code => 'SA' )
        Country.create( :name => 'Senegal', :iso_two_letter_code => 'SN' )
        Country.create( :name => 'Serbia', :iso_two_letter_code => 'RS' )
        Country.create( :name => 'Seychelles', :iso_two_letter_code => 'SC' )
        Country.create( :name => 'Sierra Leone', :iso_two_letter_code => 'SL' )
        Country.create( :name => 'Singapore', :iso_two_letter_code => 'SG' )
        Country.create( :name => 'Slovakia', :iso_two_letter_code => 'SK' )
        Country.create( :name => 'Slovenia', :iso_two_letter_code => 'SI' )
        Country.create( :name => 'Solomon Islands', :iso_two_letter_code => 'SB' )
        Country.create( :name => 'Somalia', :iso_two_letter_code => 'SO' )
        Country.create( :name => 'South Africa', :iso_two_letter_code => 'ZA' )
        Country.create( :name => 'South Georgia and the South Sandwich Islands', :iso_two_letter_code => 'GS' )
        Country.create( :name => 'Spain', :iso_two_letter_code => 'ES' )
        Country.create( :name => 'Sri Lanka', :iso_two_letter_code => 'LK' )
        Country.create( :name => 'Sudan', :iso_two_letter_code => 'SD' )
        Country.create( :name => 'Surinam', :iso_two_letter_code => 'SR' )
        Country.create( :name => 'Svalbard and Jan Mayen', :iso_two_letter_code => 'SJ' )
        Country.create( :name => 'Swaziland', :iso_two_letter_code => 'SZ' )
        Country.create( :name => 'Sweden', :iso_two_letter_code => 'SE' )
        Country.create( :name => 'Switzerland', :iso_two_letter_code => 'CH' )
        Country.create( :name => 'Syria', :iso_two_letter_code => 'SY' )
        Country.create( :name => 'Taiwan', :iso_two_letter_code => 'TW' )
        Country.create( :name => 'Tajikistan', :iso_two_letter_code => 'TJ' )
        Country.create( :name => 'Tanzania', :iso_two_letter_code => 'TZ' )
        Country.create( :name => 'Thailand', :iso_two_letter_code => 'TH' )
        Country.create( :name => 'Timor-Leste', :iso_two_letter_code => 'TL' )
        Country.create( :name => 'Togo', :iso_two_letter_code => 'TG' )
        Country.create( :name => 'Tokelau', :iso_two_letter_code => 'TK' )
        Country.create( :name => 'Tonga', :iso_two_letter_code => 'TO' )
        Country.create( :name => 'Trinidad and Tobago', :iso_two_letter_code => 'TT' )
        Country.create( :name => 'Tunisia', :iso_two_letter_code => 'TN' )
        Country.create( :name => 'Turkey', :iso_two_letter_code => 'TR' )
        Country.create( :name => 'Turkmenistan', :iso_two_letter_code => 'TM' )
        Country.create( :name => 'Turks and Caicos Islands', :iso_two_letter_code => 'TC' )
        Country.create( :name => 'Tuvalu', :iso_two_letter_code => 'TV' )
        Country.create( :name => 'Uganda', :iso_two_letter_code => 'UG' )
        Country.create( :name => 'Ukraine', :iso_two_letter_code => 'UA' )
        Country.create( :name => 'UAE', :iso_two_letter_code => 'AE' )
        Country.create( :name => 'United Kingdom', :iso_two_letter_code => 'GB' )
        Country.create( :name => 'United States', :iso_two_letter_code => 'US' )
        Country.create( :name => 'United States Minor Outlying Islands', :iso_two_letter_code => 'UM' )
        Country.create( :name => 'Uruguay', :iso_two_letter_code => 'UY' )
        Country.create( :name => 'Uzbekistan', :iso_two_letter_code => 'UZ' )
        Country.create( :name => 'Vanuatu', :iso_two_letter_code => 'VU' )
        Country.create( :name => 'Venezuela', :iso_two_letter_code => 'VE' )
        Country.create( :name => 'Vietnam', :iso_two_letter_code => 'VN' )
        Country.create( :name => 'British Virgin Islands', :iso_two_letter_code => 'VG' )
        Country.create( :name => 'US Virgin Islands', :iso_two_letter_code => 'VI' )
        Country.create( :name => 'Wallis and Futuna', :iso_two_letter_code => 'WF' )
        Country.create( :name => 'Western Sahara', :iso_two_letter_code => 'EH' )
        Country.create( :name => 'Yemen', :iso_two_letter_code => 'YE' )
        Country.create( :name => 'Zambia', :iso_two_letter_code => 'ZM' )
        Country.create( :name => 'Zimbabwe', :iso_two_letter_code => 'ZW')

RiskStatus.delete_all

    RiskStatus.create(:name => "Draft")
    RiskStatus.create(:name => "Initiated")
    RiskStatus.create(:name => "Mitigated")
    RiskStatus.create(:name => "Measured")
    RiskStatus.create(:name => "Reviewed")
    RiskStatus.create(:name => "Rejected")

ClassicScoringMetric.delete_all

    ClassicScoringMetric.create(:name => "Remote", :value => "1", :metric_type => "Likelihood" )
    ClassicScoringMetric.create(:name => "Unlikely", :value => "2", :metric_type => "Likelihood" )
    ClassicScoringMetric.create(:name => "Credible", :value => "3", :metric_type => "Likelihood" )
    ClassicScoringMetric.create(:name => "Likely", :value => "4", :metric_type => "Likelihood" )
    ClassicScoringMetric.create(:name => "Almost Certain", :value => "5", :metric_type => "Likelihood" )

    ClassicScoringMetric.create(:name => "Insignificant", :value => "1", :metric_type => "Impact" )
    ClassicScoringMetric.create(:name => "Minor", :value => "2", :metric_type => "Impact" )
    ClassicScoringMetric.create(:name => "Moderate", :value => "3", :metric_type => "Impact" )
    ClassicScoringMetric.create(:name => "Major", :value => "4", :metric_type => "Impact" )
    ClassicScoringMetric.create(:name => "Extreme/Catastrophic", :value => "5", :metric_type => "Impact" )

    ClassicScoringMetric.create(:name => "Very Low", :value => "1", :metric_type => "Vulnerability" )
    ClassicScoringMetric.create(:name => "Low", :value => "2", :metric_type => "Vulnerability" )
    ClassicScoringMetric.create(:name => "Medium", :value => "3", :metric_type => "Vulnerability" )
    ClassicScoringMetric.create(:name => "High", :value => "4", :metric_type => "Vulnerability" )
    ClassicScoringMetric.create(:name => "Very High", :value => "5", :metric_type => "Vulnerability" )

    ClassicScoringMetric.create(:name => "Very Low", :value => "1", :metric_type => "Velocity" )
    ClassicScoringMetric.create(:name => "Low", :value => "2", :metric_type => "Velocity" )
    ClassicScoringMetric.create(:name => "Medium", :value => "3", :metric_type => "Velocity" )
    ClassicScoringMetric.create(:name => "High", :value => "4", :metric_type => "Velocity" )
    ClassicScoringMetric.create(:name => "Very High", :value => "5", :metric_type => "Velocity" )


CvssMetricScoring.delete_all

        CvssMetricScoring.create(metric_name: 'AccessComplexity', abrv_metric_name: 'AC', metric_value: 'High', abrv_metric_value: 'H', numeric_value: '0.35')
        CvssMetricScoring.create(metric_name: 'AccessComplexity', abrv_metric_name: 'AC', metric_value: 'Medium', abrv_metric_value: 'M', numeric_value: '0.61')
        CvssMetricScoring.create(metric_name: 'AccessComplexity', abrv_metric_name: 'AC', metric_value: 'Low', abrv_metric_value: 'L', numeric_value: '0.71')
        CvssMetricScoring.create(metric_name: 'AccessVector', abrv_metric_name: 'AV', metric_value: 'Local', abrv_metric_value: 'L', numeric_value: '0.395')
        CvssMetricScoring.create(metric_name: 'AccessVector', abrv_metric_name: 'AV', metric_value: 'Adjacent Network', abrv_metric_value: 'A', numeric_value: '0.646')
        CvssMetricScoring.create(metric_name: 'AccessVector', abrv_metric_name: 'AV', metric_value: 'Network', abrv_metric_value: 'N', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'Authentication', abrv_metric_name: 'Au', metric_value: 'None', abrv_metric_value: 'N', numeric_value: '0.704')
        CvssMetricScoring.create(metric_name: 'Authentication', abrv_metric_name: 'Au', metric_value: 'Single Instance', abrv_metric_value: 'S', numeric_value: '0.56')
        CvssMetricScoring.create(metric_name: 'Authentication', abrv_metric_name: 'Au', metric_value: 'Multiple Instance', abrv_metric_value: 'M', numeric_value: '0.45')
        CvssMetricScoring.create(metric_name: 'AvailabilityRequirement', abrv_metric_name: 'AR', metric_value: 'Undefined', abrv_metric_value: 'ND', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'AvailabilityRequirement', abrv_metric_name: 'AR', metric_value: 'Low', abrv_metric_value: 'L', numeric_value: '0.5')
        CvssMetricScoring.create(metric_name: 'AvailabilityRequirement', abrv_metric_name: 'AR', metric_value: 'Medium', abrv_metric_value: 'M', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'AvailabilityRequirement', abrv_metric_name: 'AR', metric_value: 'High', abrv_metric_value: 'H', numeric_value: '1.51')
        CvssMetricScoring.create(metric_name: 'AvailImpact', abrv_metric_name: 'A', metric_value: 'None', abrv_metric_value: 'N', numeric_value: '0')
        CvssMetricScoring.create(metric_name: 'AvailImpact', abrv_metric_name: 'A', metric_value: 'Partial', abrv_metric_value: 'P', numeric_value: '0.275')
        CvssMetricScoring.create(metric_name: 'AvailImpact', abrv_metric_name: 'A', metric_value: 'Complete', abrv_metric_value: 'C', numeric_value: '0.66')
        CvssMetricScoring.create(metric_name: 'CollateralDamagePotential', abrv_metric_name: 'CDP', metric_value: 'Undefined', abrv_metric_value: 'ND', numeric_value: '0')
        CvssMetricScoring.create(metric_name: 'CollateralDamagePotential', abrv_metric_name: 'CDP', metric_value: 'None', abrv_metric_value: 'N', numeric_value: '0')
        CvssMetricScoring.create(metric_name: 'CollateralDamagePotential', abrv_metric_name: 'CDP', metric_value: 'Low(light loss)', abrv_metric_value: 'L', numeric_value: '0.1')
        CvssMetricScoring.create(metric_name: 'CollateralDamagePotential', abrv_metric_name: 'CDP', metric_value: 'Low-Medium', abrv_metric_value: 'LM', numeric_value: '0.3')
        CvssMetricScoring.create(metric_name: 'CollateralDamagePotential', abrv_metric_name: 'CDP', metric_value: 'Medium-High', abrv_metric_value: 'MH', numeric_value: '0.4')
        CvssMetricScoring.create(metric_name: 'CollateralDamagePotential', abrv_metric_name: 'CDP', metric_value: 'High', abrv_metric_value: 'H', numeric_value: '0.5')
        CvssMetricScoring.create(metric_name: 'ConfidentialityRequirement', abrv_metric_name: 'CR', metric_value: 'Undefined', abrv_metric_value: 'ND', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'ConfidentialityRequirement', abrv_metric_name: 'CR', metric_value: 'Low', abrv_metric_value: 'L', numeric_value: '0.5')
        CvssMetricScoring.create(metric_name: 'ConfidentialityRequirement', abrv_metric_name: 'CR', metric_value: 'Medium', abrv_metric_value: 'M', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'ConfidentialityRequirement', abrv_metric_name: 'CR', metric_value: 'High', abrv_metric_value: 'H', numeric_value: '1.51')
        CvssMetricScoring.create(metric_name: 'ConfImpact', abrv_metric_name: 'C', metric_value: 'None', abrv_metric_value: 'N', numeric_value: '0')
        CvssMetricScoring.create(metric_name: 'ConfImpact', abrv_metric_name: 'C', metric_value: 'Partial', abrv_metric_value: 'P', numeric_value: '0.275')
        CvssMetricScoring.create(metric_name: 'ConfImpact', abrv_metric_name: 'C', metric_value: 'Complete', abrv_metric_value: 'C', numeric_value: '0.66')
        CvssMetricScoring.create(metric_name: 'Exploitability', abrv_metric_name: 'E', metric_value: 'Undefined', abrv_metric_value: 'ND', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'Exploitability', abrv_metric_name: 'E', metric_value: 'Unproven that exploit exists', abrv_metric_value: 'U', numeric_value: '0.85')
        CvssMetricScoring.create(metric_name: 'Exploitability', abrv_metric_name: 'E', metric_value: 'Proof of concept code', abrv_metric_value: 'POC', numeric_value: '0.9')
        CvssMetricScoring.create(metric_name: 'Exploitability', abrv_metric_name: 'E', metric_value: 'Functional exploit exists', abrv_metric_value: 'F', numeric_value: '0.95')
        CvssMetricScoring.create(metric_name: 'Exploitability', abrv_metric_name: 'E', metric_value: 'Widespread', abrv_metric_value: 'H', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'IntegImpact', abrv_metric_name: 'I', metric_value: 'None', abrv_metric_value: 'N', numeric_value: '0')
        CvssMetricScoring.create(metric_name: 'IntegImpact', abrv_metric_name: 'I', metric_value: 'Partial', abrv_metric_value: 'P', numeric_value: '0.275')
        CvssMetricScoring.create(metric_name: 'IntegImpact', abrv_metric_name: 'I', metric_value: 'Complete', abrv_metric_value: 'C', numeric_value: '0.66')
        CvssMetricScoring.create(metric_name: 'IntegrityRequirement', abrv_metric_name: 'IR', metric_value: 'Undefined', abrv_metric_value: 'ND', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'IntegrityRequirement', abrv_metric_name: 'IR', metric_value: 'Low', abrv_metric_value: 'L', numeric_value: '0.5')
        CvssMetricScoring.create(metric_name: 'IntegrityRequirement', abrv_metric_name: 'IR', metric_value: 'Medium', abrv_metric_value: 'M', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'IntegrityRequirement', abrv_metric_name: 'IR', metric_value: 'High', abrv_metric_value: 'H', numeric_value: '1.51')
        CvssMetricScoring.create(metric_name: 'RemediationLevel', abrv_metric_name: 'RL', metric_value: 'Undefined', abrv_metric_value: 'ND', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'RemediationLevel', abrv_metric_name: 'RL', metric_value: 'Official fix', abrv_metric_value: 'OF', numeric_value: '0.87')
        CvssMetricScoring.create(metric_name: 'RemediationLevel', abrv_metric_name: 'RL', metric_value: 'Temporary fix', abrv_metric_value: 'TF', numeric_value: '0.9')
        CvssMetricScoring.create(metric_name: 'RemediationLevel', abrv_metric_name: 'RL', metric_value: 'Workaround', abrv_metric_value: 'W', numeric_value: '0.95')
        CvssMetricScoring.create(metric_name: 'RemediationLevel', abrv_metric_name: 'RL', metric_value: 'Unavailable', abrv_metric_value: 'U', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'ReportConfidence', abrv_metric_name: 'RC', metric_value: 'Undefined', abrv_metric_value: 'ND', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'ReportConfidence', abrv_metric_name: 'RC', metric_value: 'Unconfirmed', abrv_metric_value: 'UC', numeric_value: '0.9')
        CvssMetricScoring.create(metric_name: 'ReportConfidence', abrv_metric_name: 'RC', metric_value: 'Uncorroborated', abrv_metric_value: 'UR', numeric_value: '0.95')
        CvssMetricScoring.create(metric_name: 'ReportConfidence', abrv_metric_name: 'RC', metric_value: 'Confirmed', abrv_metric_value: 'C', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'TargetDistribution', abrv_metric_name: 'TD', metric_value: 'Undefined', abrv_metric_value: 'ND', numeric_value: '1')
        CvssMetricScoring.create(metric_name: 'TargetDistribution', abrv_metric_name: 'TD', metric_value: 'None (0%)', abrv_metric_value: 'N', numeric_value: '0')
        CvssMetricScoring.create(metric_name: 'TargetDistribution', abrv_metric_name: 'TD', metric_value: 'Low (0-25%)', abrv_metric_value: 'L', numeric_value: '0.25')
        CvssMetricScoring.create(metric_name: 'TargetDistribution', abrv_metric_name: 'TD', metric_value: 'Medium (26-75%)', abrv_metric_value: 'M', numeric_value: '0.75')
        CvssMetricScoring.create(metric_name: 'TargetDistribution', abrv_metric_name: 'TD', metric_value: 'High (76-100%)', abrv_metric_value: 'H', numeric_value: '1')

Subscription.delete_all

    # Subscription.create(:name => "Free", :description => "free",:section_ids=> [1,2], :amount => 0.00, :valid_log =>23,:valid_period => 1)


    Subscription.create(name: "All Modules", description: "Subscribe all Modules", section_ids: [1,2,3,4,5,6,7,8], amount: 0.00, valid_log: 23, valid_period: 1, user_count: 10, file_size: 75)

    Subscription.create(name: "Audit", description: "Audit", section_ids: [1], amount: 500.00, valid_log: 23, valid_period: 1, user_count: 30, file_size: 150)
    Subscription.create(name: "Risk", description: "Risk", section_ids: [2], amount: 500.00, valid_log: 23, valid_period: 1, user_count: 30, file_size: 150)
    Subscription.create(name: "Asset", description: "Asset", section_ids: [3], amount: 500.00, valid_log: 23, valid_period: 1, user_count: 30, file_size: 150)
    Subscription.create(name: "Policy", description: "Policy", section_ids: [4], amount: 500.00, valid_log: 23, valid_period: 1, user_count: 30, file_size: 150)
    Subscription.create(name: "Incident", description: "Incident", section_ids: [5], amount: 500.00, valid_log: 23, valid_period: 1, user_count: 30, file_size: 150)

    Subscription.create(name: "Control", description: "Control", section_ids: [8], amount: 500.00, valid_log: 23, valid_period: 1, user_count: 30, file_size: 150)

    Subscription.create(name: "Fraud", description: "Fraud", section_ids: [6], amount: 500.00, valid_log: 23, valid_period: 1, user_count: 30, file_size: 150)
    Subscription.create(name: "BCPM", description: "Bcm", section_ids: [7], amount: 500.00, valid_log: 23, valid_period: 1, user_count: 30, file_size: 150)




RiskModel.delete_all

    RiskModel.create(:name => "Likelihood * Impact")
    RiskModel.create(:name => "Likelihood * Impact + 2(Impact)")
    RiskModel.create(:name => "Likelihood * Impact + Impact")
    RiskModel.create(:name => "Likelihood * Impact + Likelihood")
    RiskModel.create(:name => "Likelihood * Impact + 2(Likelihood)")

RiskCategory.delete_all

    RiskCategory.create(:name => "Access Management")
    RiskCategory.create(:name => "Environmental Resilience")
    RiskCategory.create(:name => "Monitoring")
    RiskCategory.create(:name => "Physical Security")
    RiskCategory.create(:name => "Policy and Procedure")
    RiskCategory.create(:name => "Sensitive Data Management")
    RiskCategory.create(:name => "Technical Vulnerability Management")
    RiskCategory.create(:name => "Third-Party Management")

Technology.delete_all

    Technology.create(:name => "All")
    Technology.create(:name => "Anti-Virus")
    Technology.create(:name => "Backups")
    Technology.create(:name => "Blackberry")
    Technology.create(:name => "Citrix")
    Technology.create(:name => "Datacenter")
    Technology.create(:name => "Mail Routing")
    Technology.create(:name => "Live Collaboration")
    Technology.create(:name => "Messaging")
    Technology.create(:name => "Mobile")
    Technology.create(:name => "Network")
    Technology.create(:name => "Power")
    Technology.create(:name => "Remote Access")
    Technology.create(:name => "SAN")
    Technology.create(:name => "Telecom")
    Technology.create(:name => "Unix")
    Technology.create(:name => "VMWare")
    Technology.create(:name => "Web")
    Technology.create(:name => "Windows")

MitigationEffort.delete_all

    MitigationEffort.create(:name => "Trivial")
    MitigationEffort.create(:name => "Minor")
    MitigationEffort.create(:name => "Considerable")
    MitigationEffort.create(:name => "Significant")
    MitigationEffort.create(:name => "Exceptional")


ResellerType.delete_all

    ResellerType.create(:name => "Sass Vendor")
    ResellerType.create(:name => "Manufacturer")
    ResellerType.create(:name => "Reseller")
    ResellerType.create(:name => "Value Added Reseller")
    ResellerType.create(:name => "System Intetgrator")
    ResellerType.create(:name => "Software Vendor")
    ResellerType.create(:name => "Internal Infrastructure")
    ResellerType.create(:name => "Facility Management")
    ResellerType.create(:name => "Office Supplies")
    ResellerType.create(:name => "Computer Hardware Vendor")
    ResellerType.create(:name => "Computer Service/Repair")
    ResellerType.create(:name => "Computer Supplies Vendor")
    ResellerType.create(:name => "General Business Vendor")
    ResellerType.create(:name => "Consultant")
    ResellerType.create(:name => "Vendor")



AssetStatus.delete_all

    AssetStatus.create(:name => "Operational")
    AssetStatus.create(:name => "Lost")
    AssetStatus.create(:name => "In Repair")
    AssetStatus.create(:name => "Broken")
    AssetStatus.create(:name => "Replacement")
    AssetStatus.create(:name => "Spare")
    AssetStatus.create(:name => "Disposed")
    AssetStatus.create(:name => "Duplicate")
    AssetStatus.create(:name => "Stolen")

ComputerCategory.delete_all

    ComputerCategory.create(:name => "Laptop")
    ComputerCategory.create(:name => "Workstation")
    ComputerCategory.create(:name => "Server")
    ComputerCategory.create(:name => "Thin Client")
    ComputerCategory.create(:name => "PDA")
    ComputerCategory.create(:name => "Server - Unix")
    ComputerCategory.create(:name => "Macintosh")
    ComputerCategory.create(:name => "Standalone")
    ComputerCategory.create(:name => "NAS/File Server")
    ComputerCategory.create(:name => "Server + VMware")
    ComputerCategory.create(:name => "VM: VMware")
    ComputerCategory.create(:name => "VM: XenServer")
    ComputerCategory.create(:name => "VM: Microsoft")
    ComputerCategory.create(:name => "VM: SWSoft")
    ComputerCategory.create(:name => "VM: Virtuallron")
    ComputerCategory.create(:name => "Mac Laptop")
    ComputerCategory.create(:name => "Mac Desktop")
    ComputerCategory.create(:name => "Tablet")
    ComputerCategory.create(:name => "Other")

 ContractType.delete_all

    ContractType.create(:name => "Software License")
    ContractType.create(:name => "Subscription")
    ContractType.create(:name => "Lease")
    ContractType.create(:name => "Maintenance")

 ContractStatus.delete_all

    ContractStatus.create(:name => "Draft")
    ContractStatus.create(:name => "Active")
    ContractStatus.create(:name => "Review")
    ContractStatus.create(:name => "Expired")
    ContractStatus.create(:name => "Terminated")

 LifecycleType.delete_all

    LifecycleType.create(:name => "Acquisition")
    LifecycleType.create(:name => "Installed")
    LifecycleType.create(:name => "Assigned")
    LifecycleType.create(:name => "Disposed")
    LifecycleType.create(:name => "Duplicate")
    LifecycleType.create(:name => "Service-Planned")
    LifecycleType.create(:name => "Service-Sent")
    LifecycleType.create(:name => "Service-Returned")
    LifecycleType.create(:name => "Loan-Sent")
    LifecycleType.create(:name => "Loan-Returned")
    LifecycleType.create(:name => "Spare-Deposited")
    LifecycleType.create(:name => "Spare-Returned")
    LifecycleType.create(:name => "Inventoried")
    LifecycleType.create(:name => "Shipped")
    LifecycleType.create(:name => "Received")
    LifecycleType.create(:name => "Operational")

 LicenseType.delete_all

    LicenseType.create(:name => "CAL")
    LicenseType.create(:name => "Concurrent")
    LicenseType.create(:name => "Developer")
    LicenseType.create(:name => "Enterprise")
    LicenseType.create(:name => "Evaluation")
    LicenseType.create(:name => "Floating")
    LicenseType.create(:name => "Free")
    LicenseType.create(:name => "Generic")
    LicenseType.create(:name => "Home Use")
    LicenseType.create(:name => "Named User")
    LicenseType.create(:name => "OEM")
    LicenseType.create(:name => "Open Source(GPU/GPL)")
    LicenseType.create(:name => "Per CPU")
    LicenseType.create(:name => "Per Project")
    LicenseType.create(:name => "Per Server")
    LicenseType.create(:name => "Per Usage")
    LicenseType.create(:name => "Perpetual")
    LicenseType.create(:name => "Secondary")
    LicenseType.create(:name => "Shareware")
    LicenseType.create(:name => "Site License")
    LicenseType.create(:name => "Subscription")
    LicenseType.create(:name => "Time Based")
    LicenseType.create(:name => "Volume")

 DeviceType.delete_all

    DeviceType.create(:name => "Phone")
    DeviceType.create(:name => "Tablet")
    DeviceType.create(:name => "Media Player")
    DeviceType.create(:name => "Other")


# Seed Data for Policy

    PolicyKind.delete_all

        PolicyKind.create(name: "Company Policy")
        PolicyKind.create(name: "Organization Policy")
        PolicyKind.create(name: "Data Asset Policy")
        PolicyKind.create(name: "Product Policy")
        PolicyKind.create(name: "Contract Policy")
        PolicyKind.create(name: "Company Control Policy")

    ControlClassification.delete_all

        ControlClassification.create(name: "Preventative")
        ControlClassification.create(name: "Corrective")
        ControlClassification.create(name: "Detective")

    Purpose.delete_all

        Purpose.create(name: "Process")
        Purpose.create(name: "Technical")

    ControlFreq.delete_all

        ControlFreq.create(name: "Continues")
        ControlFreq.create(name: "Event driven")
        ControlFreq.create(name: "Periodic")

    ControlState.delete_all

        ControlState.create(name: "Active")
        ControlState.create(name: "In-Active")

    PolicyClassification.delete_all

        PolicyClassification.create(name: "Public")
        PolicyClassification.create(name: "Restricted")
        PolicyClassification.create(name: "Confidential")

    PolicyStatus.delete_all

        PolicyStatus.create(name: "Drafted")
        PolicyStatus.create(name: "Waiting for review")
        PolicyStatus.create(name: "Reviewed")
        PolicyStatus.create(name: "Waiting for Approval")
        PolicyStatus.create(name: "Approved")
        PolicyStatus.create(name: "Discard/Declined")
        PolicyStatus.create(name: "Published")

    Audience.delete_all

        Audience.create(name: "Internal")
        Audience.create(name: "External")

    ReviewAction.delete_all

        ReviewAction.create(name: "Complete")
        ReviewAction.create(name: "Inprogress")

    ApprovalAction.delete_all

        ApprovalAction.create(name: "Save Draft")
        ApprovalAction.create(name: "Send to Rework")
        ApprovalAction.create(name: "Reject")
        ApprovalAction.create(name: "Approve")

 SoftwareType.delete_all

    SoftwareType.create(:name => "Application")
    SoftwareType.create(:name => "Database")
    SoftwareType.create(:name => "Operating System")
    SoftwareType.create(:name => "Web Server")

 DocumentStatus.delete_all
    
    DocumentStatus.create(:name => "Draft")
    DocumentStatus.create(:name => "Approved")
    DocumentStatus.create(:name => "Unapproved")

 DocumentType.delete_all
    
    DocumentType.create(:name => "Policy")
    DocumentType.create(:name => "Procedure")
    DocumentType.create(:name => "Reference")

 ServiceType.delete_all
    
    ServiceType.create(:name => "Business Service")
    ServiceType.create(:name => "Sales Service")
    ServiceType.create(:name => "Support Service")
    ServiceType.create(:name => "IT Service")
    ServiceType.create(:name => "Email Service")
    ServiceType.create(:name => "Backup Service")
    ServiceType.create(:name => "Hosting Service")

OperatingSystem.delete_all

    OperatingSystem.create(:name => "Windows")
    OperatingSystem.create(:name => "Linux")
    OperatingSystem.create(:name => "Mac")
    OperatingSystem.create(:name => "Solaris")
    OperatingSystem.create(:name => "AIX")

AssetDecision.delete_all
    
    AssetDecision.create(:name => "Accept Gap Analysis and Close")
    AssetDecision.create(:name => "Accept till next assessment")
    AssetDecision.create(:name => "Redo Actions")

AssetState.delete_all

    AssetState.create(:name => "Identified")
    AssetState.create(:name => "Evaluated")
    AssetState.create(:name => "Acted")
    AssetState.create(:name => "Reviewed")
    AssetState.create(:name => "Redo Actions")

Classification.delete_all

    Classification.create(:name => "Strictly Confidential")
    Classification.create(:name => "Confidential")
    Classification.create(:name => "Public")
    Classification.create(:name => "Business use only")

ClassificationControl.delete_all
    
    ClassificationControl.create(:name => "Preventive")
    ClassificationControl.create(:name => "Corrective")
    ClassificationControl.create(:name => "Detective")

PurposeControl.delete_all
    
    PurposeControl.create(:name => "Process")
    PurposeControl.create(:name => "Technical")

DataPurpose.delete_all
    
    DataPurpose.create(:name => "None")
    DataPurpose.create(:name => "Support Test Execution")
    DataPurpose.create(:name => "Identifies non compliacne")
    DataPurpose.create(:name => "Identifies Compliance")

ControlStatus.delete_all
    
    ControlStatus.create(:name => "New")
    ControlStatus.create(:name => "Draft")
    ControlStatus.create(:name => "Active")
    ControlStatus.create(:name => "In-Active")

ControlRegulation.delete_all
    
    ControlRegulation.create(:name => "ISO/IEC 27001")
    ControlRegulation.create(:name => "HIPAA")
    ControlRegulation.create(:name => "PCI-DSS")
    ControlRegulation.create(:name => "DIACAP")
    ControlRegulation.create(:name => "FISMA")
    ControlRegulation.create(:name => "FedRAMP")

FraudRelated.delete_all
    
    FraudRelated.create(:name => "Yes")
    FraudRelated.create(:name => "No")


RiskValue.delete_all

    RiskValue.create(:name => "1-10lakhs")
    RiskValue.create(:name => "10-100lakhs")

Finding.delete_all

    Finding.create(:name => "Proven Fraud") 
    Finding.create(:name => "Unproven Fraud") 
    Finding.create(:name => "Fraud Discarded")

Closing.delete_all

    Closing.create(:name => "Fraud Proven By Internal Investigation") 
    Closing.create(:name => "Unproven Fraud") 
    Closing.create(:name => "Unrelated Fraud")

Rating.delete_all

    Rating.create(:name => "1")
    Rating.create(:name => "2")
    Rating.create(:name => "3")
    Rating.create(:name => "")
    Rating.create(:name => "5")

FraudStatus.delete_all

    FraudStatus.create(:name => "Investigated")
    FraudStatus.create(:name => "Published")
    FraudStatus.create(:name => "Reviewed")

InvestigationObject.delete_all

    InvestigationObject.create(:name => "Investigate Insurance Claims")
    InvestigationObject.create(:name => "Questionable Payment")

AssetCriticality.delete_all

    AssetCriticality.create(name: 'Low')
    AssetCriticality.create(name: 'Medium')
    AssetCriticality.create(name: 'High')

# BCM 

PlanStatus.delete_all

    PlanStatus.create(:name => "Production")
    PlanStatus.create(:name => "Designed")
    PlanStatus.create(:name => "Proposed")
    PlanStatus.create(:name => "Transistion")
    PlanStatus.create(:name => "Retired")

Recurrence.delete_all

    Recurrence.create(:name => "Monthly")
    Recurrence.create(:name => "Quarterly")
    Recurrence.create(:name => "Semesterly")
    Recurrence.create(:name => "Annually")

TestType.delete_all

    TestType.create(:name => "Table Top")
    TestType.create(:name => "Functional")
    TestType.create(:name => "Full Scale")
    TestType.create(:name => "Orientation")

BcStatus.delete_all

    BcStatus.create(:name => "Analysis")
    BcStatus.create(:name => "Planned")
    BcStatus.create(:name => "Implemented")
    BcStatus.create(:name => "Acceptance")
    BcStatus.create(:name => "Maintenance")


