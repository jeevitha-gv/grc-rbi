# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

QuestionType.delete_all

    QuestionType.create([{name: 'Yes or No'}])
    QuestionType.create([{name: 'Descriptive Type'}])
    QuestionType.create([{name: 'Multiple Choice'}])

Topic.delete_all

    Topic.create([{name: 'Network Security'}])
    Topic.create([{name: 'Physical Security'}])
    Topic.create([{name: 'System Security'}])
    Topic.create([{name: 'Access'}])
    Topic.create([{name: 'Applications'}])
    Topic.create([{name: 'Others'}])

Score.delete_all

     Score.create([{level: '0', description: '0%'}])
     Score.create([{level: '1', description: '>0% - 50%'}])
     Score.create([{level: '2', description: '>50% - 70%'}])
     Score.create([{level: '3', description: '>70% - 90%'}])
     Score.create([{level: '4', description: '>90% - 100%'}])

AuditType.delete_all

    AuditType.create([{name: 'Internal Audit'}])
    AuditType.create([{name: 'External Audit'}])
    AuditType.create([{name: 'Regulators'}])
    AuditType.create([{name: 'Self Audit'}])

AuditStatus.delete_all

   AuditStatus.create([{name: 'Planning'}])
   AuditStatus.create([{name: 'Initiated'}])
   AuditStatus.create([{name: 'In Progress'}])
   AuditStatus.create([{name: 'Published'}])
   AuditStatus.create([{name: 'Halted'}])
   AuditStatus.create([{name: 'Cancelled'}])

Compliance.delete_all

    Compliance.create([{name: 'COBIT'}])
    Compliance.create([{name: 'FISMA'}])
    Compliance.create([{name: 'HIPAA'}])
    Compliance.create([{name: 'ISO 27001'}])
    Compliance.create([{name: 'ISO 28000'}])
    Compliance.create([{name: 'OSHAS'}])
    Compliance.create([{name: 'PCI DSS'}])
    Compliance.create([{name: 'SOX'}])

RecommendationStatus.delete_all

    RecommendationStatus.create([{name: 'Opened Recommendation'}])
    RecommendationStatus.create([{name: 'Risk accepted for Recommendation'}])
    RecommendationStatus.create([{name: 'Closed Recommendation'}])
    RecommendationStatus.create([{name: 'Closed duplicate Recommendation'}])

ResponseStatus.delete_all

    ResponseStatus.create([{name: 'Planning'}])
    ResponseStatus.create([{name: 'In Progress'}])
    ResponseStatus.create([{name: 'Halted'}])
    ResponseStatus.create([{name: 'Cancelled'}])
    ResponseStatus.create([{name: 'Completed'}])

Role.delete_all

    Role.create([{title: 'company_admin'}])
    Role.create([{title: 'company user'}])

Section.delete_all

    Section.create([{name: 'Audit'}])
    Section.create([{name: 'Risk'}])

Priority.delete_all

    Priority.create([{name: 'High'}])
    Priority.create([{name: 'Medium'}])
    Priority.create([{name: 'Low'}])

ReminderAssignment.delete_all

    ReminderAssignment.create([{name: 'Company Admin'}])
    ReminderAssignment.create([{name: 'Auditor'}])
    ReminderAssignment.create([{name: 'Auditee'}])
    ReminderAssignment.create([{name: 'Reporting Manager'}])
    ReminderAssignment.create([{name: 'Manager of Manager'}])
    ReminderAssignment.create([{name: 'Team'}])