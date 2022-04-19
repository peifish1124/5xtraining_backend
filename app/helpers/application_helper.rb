module ApplicationHelper
    DISPLAY = { 'notice' => 'alert alert-success', 'alert' => 'alert alert-danger' }
    def flash_display
        DISPLAY
    end
end