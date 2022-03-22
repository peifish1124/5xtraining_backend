class Task < ApplicationRecord
    belongs_to :user
    default_scope { order(created_at: :desc) }
    validates :title, presence: { message: I18n.t('notice.title_require') }
end
