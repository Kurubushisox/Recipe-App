module ApplicationHelper
  def is_active(*options)
    ' active'  if current_page?(*options)
  end
end
