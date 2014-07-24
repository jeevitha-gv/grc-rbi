module RiskDashboardHelper
  def chart_input(x_axis)
    x_axis_records = []
    y_axis_records = []
    case x_axis
      when 'Category'
        current_user.accessible_risks.group_by(&:category_id).each do |key,value|
          x_axis_records << RiskCategory.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Status'
        current_user.accessible_risks.group_by(&:risk_status_id).each do |key,value|
          x_axis_records << RiskStatus.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Compliance Type'
        current_user.accessible_risks.group_by(&:compliance_id).each do |key,value|
          x_axis_records << key
          y_axis_records << value.count
        end
      when 'Technology'
         current_user.accessible_risks.group_by(&:technology_id).each do |key,value|
          x_axis_records << Technology.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Location'
        current_user.accessible_risks.group_by(&:location_id).each do |key,value|
          x_axis_records <<  Location.location_name(key)
          y_axis_records << value.count
        end
      when 'Department'
        current_user.accessible_risks.group_by(&:department_id).each do |key,value|
          x_axis_records <<  Department.department_name(key)
          y_axis_records << value.count
        end
      when 'Team'
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
