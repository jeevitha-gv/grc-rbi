module ControlDashboardHelper

  def control_chart_input(x_axis)
    x_axis_records = []
    y_axis_records = []
    case x_axis
      when 'Classification'
        current_user.accessible_controls.group_by(&:classification_control_id).each do |key,value|
          x_axis_records << ClassificationControl.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Owning Group'
        current_user.accessible_controls.group_by(&:risk_status_id).each do |key,value|
          x_axis_records << OwningGroup.find_by_id(key).name
          y_axis_records << value.count
        end
      when 'Purpose'
        current_user.accessible_controls.group_by(&:purpose_control_id).each do |key,value|
          key = PurposeControl.find_by_id(key)
          x_axis_records << key.name if key.present?
          y_axis_records << value.count
        end
      when 'Regulation'
         current_user.accessible_controls.group_by(&:control_regulation_id).each do |key,value|
          key = ControlRegulation.find_by_id(key)
          x_axis_records << key.name if key.present?
          y_axis_records << value.count
        end
      when 'Fraud'
        current_user.accessible_controls.group_by(&:fraud_related_id).each do |key,value|
          key = FraudRelated.find_by_id(key)
          x_axis_records << key.name if key.present?
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
