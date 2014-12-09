module ApplicationHelper

  def fix_url(string)

    str.starts_with?('http://') ? str : "htp://#{str}"
 end


def display_datetime(dt)
  if logged_in? && !current_user.time_zone.blank? 
    dt = dt.in_time_zone(current_user.time_zone)
  end
  dt.strftime("%m/%d/%Y %l:%M%P %Z")
end

def can_edit?(post)
  if post.creator == current_user
    return true
  end
  return false
end



end
