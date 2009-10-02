# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def readable_date(time)
    unless time.nil?
      time.strftime("%m.%d.%Y")
    end
  end
  
end
