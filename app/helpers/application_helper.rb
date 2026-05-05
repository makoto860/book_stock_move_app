module ApplicationHelper
  def l_datetime(value)
    return "-" if value.blank?
    l(value, format: :datetime_jp)
  end
end
