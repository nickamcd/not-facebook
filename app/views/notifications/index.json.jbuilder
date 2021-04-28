json.array! @notifications do |notification|
  json.actor notification.actor.full_name
  json.action notification.action
  json.notifiable do 
    json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  end
  json.url polymorphic_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end