module ApplicationHelper
  def flash_class(name)
    alert_type = case name.to_s
      when 'notice'  then 'alert-success'
      when 'error'   then 'alert-danger'
      when 'alert'   then 'alert-danger'
      when 'info'    then 'alert-info'
      when 'warning' then 'alert-warning'
      else "alert-#{name}"
    end
    alert_type
  end

  def post_url(post)
    return post.link if post.link?
    return post_path(post) if post.text?
  end
end
