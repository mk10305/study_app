module ApplicationHelper

  def fix_url(string)

    str.starts_with?('http://') ? str : "htp://#{str}"
 end


def display_datetime(dt)
  dt.strftime("%m/%d/%Y %l:%M%P %Z")
end



end
