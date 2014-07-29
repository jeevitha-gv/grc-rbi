module RiskDashboardHelper
  def risk_chart_input(x_axis)
    x_axis_records = []
    y_axis_records = []
    case x_axis
      when 'Risk Categories'
        current_user.accessible_risks.group_by(&:category_id).each do |key,value|
          x_axis_records << RiskCategory.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Risk Statuses'
        current_user.accessible_risks.group_by(&:risk_status_id).each do |key,value|
          x_axis_records << RiskStatus.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Risk Compliance Types'
        current_user.accessible_risks.group_by(&:compliance_id).each do |key,value|
          x_axis_records << Compliance.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Technology'
         current_user.accessible_risks.group_by(&:technology_id).each do |key,value|
          x_axis_records << Technology.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Risk Locations'
        current_user.accessible_risks.group_by(&:location_id).each do |key,value|
          x_axis_records <<  Location.location_name(key)
          y_axis_records << value.count
        end
      when 'Risk Departments'
        current_user.accessible_risks.group_by(&:department_id).each do |key,value|
          x_axis_records <<  Department.department_name(key)
          y_axis_records << value.count
        end
      when 'Risk Teams'
        current_user.accessible_risks.group_by(&:team_id).each do |key,value|
          x_axis_records <<  Team.team_name(key)
          y_axis_records << value.count
        end
    end
    return x_axis_records, y_axis_records
  end


  def pie_input(x_axis, y_axis)
    pie_records = []
    pie_input = []
    x_axis.each_with_index do |x, index|
      pie_input = []
      pie_input << x
      pie_input << y_axis[index]
      pie_records << pie_input
    end
  pie_records
  end
end
