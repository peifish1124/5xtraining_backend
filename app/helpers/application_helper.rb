module ApplicationHelper
    DISPLAY = { 'notice' => 'alert alert-success', 'alert' => 'alert alert-danger' }
    def flash_display(type, msg)
        content_tag(:div, msg, class: DISPLAY[type])
    end
end